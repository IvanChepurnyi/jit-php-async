FROM node:current-alpine

COPY app /app
WORKDIR /app
RUN yarn --yes

ENTRYPOINT ["./node_modules/.bin/autocannon"]