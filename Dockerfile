FROM node:16-buster-slim AS frontend-builder

WORKDIR /build
COPY ringtools-web-v2 .

RUN cp .env.defaults .env && yarn install

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

RUN yarn build

FROM node:16-buster-slim AS api-builder

WORKDIR /build
COPY ringtools-server-ts .
RUN yarn install && yarn build:ts
RUN npm prune --production

FROM node:16-buster-slim 

USER 1000

WORKDIR /build
COPY --from=api-builder /build .
COPY --from=frontend-builder /build/dist/ringtools-web public

EXPOSE 7464
CMD ["node", "dist/server.js"]
