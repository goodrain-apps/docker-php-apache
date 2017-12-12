FROM goodrainapps/debian:jessie-20171210
LABEL MAINTAINER="zhouyq@goodrain.com"

ENV APACHE_DIR=/opt/goodrain/apache2
ENV APACHE_VERSION=2.2.34
ENV PHP_VERSION=5.6.32
ENV PHP_DIR=/opt/goodrain/php
ENV PATH=$PATH:${APACHE_DIR}/bin:${PHP_DIR}/bin
ENV DOWNLOAD_URL=https://pkg.goodrain.com/grstack/debian

RUN apt-get update \
    && apt-get install -y libapr1 libaprutil1 \
    libxml2 libedit2 libpng12-dev libjpeg62-turbo-dev \
    libfreetype6-dev libmcrypt-dev --no-install-recommends \
    && rm -r /var/lib/apt/lists/*

RUN set -x\
    && curl -k ${DOWNLOAD_URL}/apache-${APACHE_VERSION}-jessie.tar.gz | tar xz -C / \
    && curl -k ${DOWNLOAD_URL}/php-${PHP_VERSION}-jessie.tar.gz | tar xz -C /

RUN set -x \
    && groupadd  -g 200 rain \
    && useradd -u 200 -g 200 rain \
    && mkdir -p /data \
    && echo "<?php\nphpinfo();\n?>" > /data/index.php

EXPOSE 80

VOLUME [ "/data" ]

COPY httpd.conf $APACHE_DIR/conf/
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "httpd -DFOREGROUND" ]
