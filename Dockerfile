FROM topaztechnology/base:3.6
MAINTAINER Topaz Tech Ltd <info@topaz.technology>

ENV MONETDB_VERSION 11.27.5
ENV MONETDB_RELEASES https://www.monetdb.org/downloads/sources/archive

RUN addgroup monetdb && \
    adduser -S -G monetdb monetdb

# Build MonetDB
COPY merovingian.patch /root
RUN \
  apk add --update --no-cache libatomic libxml2 readline libcrypto1.0 libssl1.0 pcre libbz2 lz4-libs \
    snappy xz-libs && \
  curl -Lso /tmp/MonetDB.tar.bz2 "${MONETDB_RELEASES}/MonetDB-${MONETDB_VERSION}.tar.bz2" && \
  cd /tmp && \
  bunzip2 MonetDB.tar.bz2 && \
  tar xvf MonetDB.tar && \
  rm MonetDB.tar && \
  cd MonetDB-${MONETDB_VERSION} && \
  patch tools/merovingian/daemon/merovingian.c /root/merovingian.patch && \
  apk add --update --no-cache --virtual build-dependencies \
    file bison python2 build-base curl-dev libatomic_ops-dev libxml2-dev readline-dev openssl-dev pcre-dev \
    bzip2-dev lz4-dev snappy-dev xz-dev zlib-dev && \
  ./configure && \
  make && \
  make install && \
  apk del build-dependencies && \
  cd /tmp && \
  rm -rf /tmp/MonetDB-${MONETDB_VERSION} && \
  rm /root/*

COPY containerpilot.json5 /etc/containerpilot.json5
COPY bin/ /usr/local/bin/

RUN \
  mkdir -p /var/lib/monetdb && \
  chown -R monetdb:monetdb /var/lib/monetdb

VOLUME ["/var/lib/monetdb"]

EXPOSE 50000
