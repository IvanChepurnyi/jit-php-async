FROM node:current-alpine

COPY package.json ./
RUN yarn --yes

ENTRYPOINT ["yarn"]
CMD ["run", "load"]