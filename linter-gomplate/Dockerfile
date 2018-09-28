FROM alpine:3.8

ENV GOMPLATE_VERSION 3.0.0

COPY render.sh /usr/local/bin/render
COPY entrypoint.sh /usr/local/bin/entrypoint

ADD https://github.com/hairyhenderson/gomplate/releases/download/v${GOMPLATE_VERSION}/gomplate_linux-amd64 /
RUN mv /gomplate_linux-amd64 /usr/local/bin/gomplate && \
    chmod +x /usr/local/bin/gomplate && \
    chmod +x /usr/local/bin/entrypoint && \
    chmod +x /usr/local/bin/render && \
    apk add --update ca-certificates && \
    apk add bash

ENTRYPOINT ["/usr/local/bin/entrypoint"]
