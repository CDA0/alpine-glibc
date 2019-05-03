FROM alpine:3.9
ARG GLIBC_VERSION="2.29-r0"
ARG GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download"

RUN apk --no-cache add ca-certificates wget

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget ${GLIBC_BASE_URL}/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk && \
    wget ${GLIBC_BASE_URL}/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk && \
    wget ${GLIBC_BASE_URL}/${GLIBC_VERSION}/glibc-i18n-${GLIBC_VERSION}.apk && \
    apk add glibc-${GLIBC_VERSION}.apk && \
    apk add glibc-bin-${GLIBC_VERSION}.apk && \
    apk add glibc-i18n-${GLIBC_VERSION}.apk && \
    rm -f glibc-${GLIBC_VERSION}.apk && \
    rm -f glibc-bin-${GLIBC_VERSION}.apk && \
    rm -f glibc-i18n-${GLIBC_VERSION}.apk

RUN /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true
RUN echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh

ENV LANG=C.UTF-8
