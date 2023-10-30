# https://docs.requarks.io/install/linux
FROM node:20-alpine

RUN apk add --no-cache bash curl git openssh gnupg sqlite wget

RUN mkdir -p /wiki && \
    mkdir -p /logs && \
    mkdir -p /wiki/data/content && \
    chown -R node:node /wiki /logs

WORKDIR /wiki

RUN wgt https://github.com/Requarks/wiki/releases/latest/download/wiki-js.tar.gz && \
    tar xzf wiki-js.tar.gz -C /wiki && \
    rm wiki-js.tar.gz && \
    cd /wiki

RUN mv config.sample.yml config.yml && \
    npm rebuild sqlite3

USER node

VOLUME ["/wiki/data/content"]

EXPOSE 3000

CMD ["node", "server"]