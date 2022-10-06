# socat

Single binary build of socat for the `x86_64` platform.

Packaged by https://github.com/morecontainers/

Binary build available on Docker Hub as `morecontainers/socat:latest` or `morecontainers/socat:1.7.4.2`.

Note that 1.7.4.3 will not build as a static binary due to an unresolved / unsupported musl-libc function

# changes

2022-10-07: Added tini-static dependency
----------------------------------------

tini allows a remap of exit code 143 (unhandled SIGTERM) to 0.  This makes
socat behave civilized and exit without error reported to K8s when used as a
sidecar in a Kubernetes Job.
