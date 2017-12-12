FROM goodrainapps/debian:jessie-20171210
LABEL MAINTAINER="zhouyq@goodrain.com"

ENV APACHE_DIR=/opt/goodrain/apache2
ENV APACHE_VERSION=2.2.34
ENV PHP_VERSION=5.6.32
ENV PHP_DIR=/opt/goodrain/php
ENV PATH=$PATH:${APACHE_DIR}/bin:${PHP_DIR}/bin
ENV DOWNLOAD_URL=https://pkg.goodrain.com/grstack/debian

RUN set -x\
    && curl -k ${DOWNLOAD_URL}/apache-${APACHE_VERSION}-jessie.tar.gz | tar xz -C / \
    && curl -k ${DOWNLOAD_URL}/php-${PHP_VERSION}-jessie.tar.gz | tar xz -C /

EXPOSE 80

VOLUME [ "/data" ]

COPY httpd.conf $APACHE_DIR/conf/
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "httpd -DFOREGROUND" ]