FROM ubuntu:20.04

LABEL org.opencontainers.image.authors="https://github.com/riedde"
LABEL org.opencontainers.image.authors="https://github.com/bwbohl"
LABEL org.opencontainers.image.authors="https://github.com/kepper"
LABEL org.opencontainers.image.source="https://github.com/riedde/docker-mei-guidelines-image"
LABEL org.opencontainers.image.revision="v0.0.1"

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

ENV ANT_VERSION=1.10.12
ENV SAXON_VERSION=Saxon-HE/10/Java/SaxonHE10-8J

USER root

# install apt-utils, jre8, unzip, git, npm
RUN apt-get update && apt-get install -y \
    apt-utils \
    openjdk-8-jre-headless \
    unzip \
    git \
    npm

# setup ant
ADD https://downloads.apache.org/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz /tmp/ant.tar.gz
RUN tar -xvf /tmp/ant.tar.gz -C /opt
ENV ANT_HOME=/opt/apache-ant-${ANT_VERSION}
ENV PATH=${PATH}:${ANT_HOME}/bin

# setup saxon
ADD https://sourceforge.net/projects/saxon/files/${SAXON_VERSION}.zip/download /tmp/saxon.zip

RUN unzip /tmp/saxon.zip -d ${ANT_HOME}/lib

#setup xerces
ADD https://www.oxygenxml.com/maven/com/oxygenxml/oxygen-patched-xerces/23.1.0.0/oxygen-patched-xerces-23.1.0.0.jar ${ANT_HOME}/lib

# setup xmlcalabash
ADD https://github.com/ndw/xmlcalabash1/releases/download/1.3.2-100/xmlcalabash-1.3.2-100.zip /tmp/xmlcalabash.zip
RUN unzip -q /tmp/xmlcalabash.zip -d /tmp/lib/ && \
    cp /tmp/lib/*/lib/** ${ANT_HOME}/lib/ && \
    cp /tmp/lib/*/xmlcalabas*.jar ${ANT_HOME}/lib/


ENV NODE_ENV=production

#WORKDIR /app
COPY ["package.json", "package-lock.json*", "./"]
RUN npm install --production


ENV PRINCE_VERSION=14.3-1
ENV PRINCE_BUILD=20.04

ADD https://www.princexml.com/download/prince_${PRINCE_VERSION}_ubuntu${PRINCE_BUILD}_amd64.deb /tmp/

RUN apt-get -y install libc6
RUN apt-get install -y --no-install-recommends gdebi fonts-stix && \
    gdebi --non-interactive /tmp/prince_${PRINCE_VERSION}_ubuntu${PRINCE_BUILD}_amd64.deb && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

