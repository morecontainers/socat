#     syntax: docker/dockerfile:1.4
FROM  alpine:3.16
ENV   SOCAT_VERSION=1.7.4.2
RUN   mkdir -p /var/cache/apk && ln -s /var/cache/apk /etc/apk/cache
RUN   --mount=type=cache,target=/var/cache apk add \
      bash \
      build-base \
      curl \
      linux-headers \
      musl-dev \
      ncurses-dev \
      ncurses-static \
      readline-dev \
      readline-static \
      openssl-dev \
      openssl-libs-static \
        ;
RUN <<EOF
      mkdir -p /build
      cd build
      curl -C - -LO http://www.dest-unreach.org/socat/download/socat-${SOCAT_VERSION}.tar.gz
      tar xzvf socat-${SOCAT_VERSION}.tar.gz
      cd socat-${SOCAT_VERSION}
      CC='/usr/bin/gcc -static -O2' ./configure
      make
      strip socat
      cp socat /usr/local/bin
EOF

FROM  scratch
COPY  --from=0 /usr/local/bin/socat /socat
ENTRYPOINT  ["/socat"]
