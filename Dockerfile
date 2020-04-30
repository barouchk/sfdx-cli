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

ENV PMD_VERSION 6.20.0

RUN apk add --update --no-cache wget unzip
RUN mkdir -p /opt

RUN cd /opt \
      && wget -nc -O pmd.zip https://github.com/pmd/pmd/releases/download/pmd_releases/${PMD_VERSION}/pmd-bin-${PMD_VERSION}.zip \
      && unzip pmd.zip \
      && rm -f pmd.zip \
      && mv pmd-bin-${PMD_VERSION} pmd

COPY pmd /usr/bin/pmd
COPY cpd /usr/bin/cpd
RUN chmod +x /usr/bin/pmd /usr/bin/cpd

RUN mkdir /src
VOLUME /src
WORKDIR /src

CMD ["pmd"]

