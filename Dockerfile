# small alpine image
FROM alpine

#add usefull tools
RUN apk add --update --no-cache  \
      openssl \
      curl \
      wget \
      unzip \
      git \
      rsync \
      findutils \
      bash \
      nodejs \
      nodejs-npm \
      openjdk8-jre \
      jq \
      gettext \
      xmlstarlet \
      ca-certificates

# install sfdx from npm
RUN npm install sfdx-cli --global
RUN sfdx --version
RUN sfdx plugins --core

RUN npm install sfdx-git-delta@latest --global
RUN sgd --version

wget https://github.com/pmd/pmd/releases/download/pmd_releases%2F6.22.0/pmd-bin-6.22.0.zip
unzip pmd-bin-6.22.0.zip

