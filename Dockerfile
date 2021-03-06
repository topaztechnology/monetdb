FROM alpine:3.12.1
LABEL maintainer=info@topaz.technology

ENV MONETDB_VERSION 11.37.11
ENV MONETDB_RELEASES https://www.monetdb.org/downloads/sources/archive

RUN addgroup monetdb && \
    adduser -S -G monetdb monetdb

# Build MonetDB
COPY merovingian.patch /root
RUN \
  apk add --update --no-cache bash curl libatomic libxml2 readline libressl3.1-libcrypto pcre libbz2 lz4-libs \
    snappy xz-libs && \
  apk add --update --no-cache --virtual build-dependencies \
    file patch curl bison python3 build-base curl-dev libatomic_ops-dev libxml2-dev readline-dev libressl-dev pcre-dev \
    bzip2-dev lz4-dev snappy-dev xz-dev zlib-dev && \
  curl -Lso /tmp/MonetDB.tar.bz2 "${MONETDB_RELEASES}/MonetDB-${MONETDB_VERSION}.tar.bz2" && \
  cd /tmp && \
  tar xjvf MonetDB.tar.bz2 && \
  rm MonetDB.tar.bz2 && \
  cd "MonetDB-${MONETDB_VERSION}" && \
  patch tools/merovingian/daemon/merovingian.c /root/merovingian.patch && \
  ./configure && \
  make -j "$(nproc)" && \
  make install && \
  apk del build-dependencies && \
  cd /tmp && \
  rm -rf /tmp/MonetDB-${MONETDB_VERSION} && \
  rm /root/*

COPY bin/ /usr/local/bin/

RUN \
  mkdir -p /var/lib/monetdb && \
  chown -R monetdb:monetdb /var/lib/monetdb

USER monetdb

HEALTHCHECK --interval=1s --timeout=1s --retries=20 CMD /usr/local/bin/monet-health.sh

VOLUME [ "/var/lib/monetdb" ]

EXPOSE 50000

CMD [ "sh", "-c", "/usr/local/bin/monet-start.sh" ]
