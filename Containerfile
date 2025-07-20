FROM scratch AS ctx 
COPY build_files / 

FROM quay.io/fedora/fedora-coreos:testing 

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh && \
    /ctx/initramfs.sh && \
    ostree container commit

RUN bootc container lint
