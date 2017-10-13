FROM nginx:1.12.1

ADD nginx.conf /etc/nginx/

ENV PHP_UPSTREAM_CONTAINER php-fpm
ENV PHP_UPSTREAM_PORT 9000

#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories

#RUN apk update \
#    && apk add --no-cache bash \
#    && adduser -D -H -u 1000 -s /bin/bash www-data

RUN adduser -D -H -u 1000 -s /bin/bash www-data

RUN echo "upstream php-upstream { server ${PHP_UPSTREAM_CONTAINER}:${PHP_UPSTREAM_PORT}; }" > /etc/nginx/conf.d/upstream.conf \
    && rm /etc/nginx/conf.d/default.conf

CMD ["nginx"]

EXPOSE 80 443