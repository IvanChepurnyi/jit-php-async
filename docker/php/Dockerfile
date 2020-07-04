FROM akondas/php:8.0-cli-alpine

COPY entrypoint.sh /custom-entry-point.sh
RUN mkdir -p /usr/src/app

ENTRYPOINT ["/custom-entry-point.sh"]
CMD []
WORKDIR /usr/src/app
