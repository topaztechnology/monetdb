FROM alpine:3.17.3
LABEL maintainer=info@topaz.technology

ENV MONETDB_VERSION 11.45.13
ENV MONETDB_RELEASES https://www.monetdb.org/downloads/sources/archive

RUN addgroup monetdb && \
    adduser -S -G monetdb monetdb

# Build MonetDB
COPY mutils.patch /tmp

RUN \
  apk add --update --no-cache bash curl geos gsl python3 libatomic libxml2 readline pcre libbz2 lz4-libs \
    snappy xz-libs cfitsio unixodbc libuuid && \
  apk add --update --no-cache --virtual build-dependencies \
    file patch curl bison build-base cmake python3-dev curl-dev geos-dev gsl-dev libatomic_ops-dev \
    libxml2-dev readline-dev pcre-dev bzip2-dev lz4-dev snappy-dev xz-dev zlib-dev cfitsio-dev \
    unixodbc-dev zlib-dev && \
  mkdir -p /tmp/build/cmake && \
  curl -Ls "${MONETDB_RELEASES}/MonetDB-${MONETDB_VERSION}.tar.bz2" | tar xj --strip-components=1 -C /tmp/build  && \
  patch /tmp/build/common/utils/mutils.h /tmp/mutils.patch && \
  cd /tmp/build/cmake && \
  cmake -DCMAKE_BUILD_TYPE=Release /tmp/build && \
  cmake --build . --parallel "$(nproc)" && \
  cmake --build . --target install && \
  apk del build-dependencies && \
  cd /root && \
  rm -rf /tmp/build && \
  rm /tmp/mutils.patch

COPY bin/ /usr/local/bin/

RUN \
  mkdir -p /var/lib/monetdb && \
  chown -R monetdb:monetdb /var/lib/monetdb

USER monetdb

HEALTHCHECK --interval=1s --timeout=1s --retries=20 CMD /usr/local/bin/monet-health.sh

VOLUME [ "/var/lib/monetdb" ]

EXPOSE 50000

CMD [ "sh", "-c", "/usr/local/bin/monet-start.sh" ]
