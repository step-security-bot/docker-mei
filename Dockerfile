FROM ubuntu:22.04

LABEL org.opencontainers.image.authors="https://github.com/riedde"
LABEL org.opencontainers.image.authors="https://github.com/bwbohl"
LABEL org.opencontainers.image.authors="https://github.com/kepper"
LABEL org.opencontainers.image.source="https://github.com/riedde/docker-mei-guidelines-image"
LABEL org.opencontainers.image.revision="v0.0.1"

ARG DEBIAN_FRONTEND=noninteractive
ARG TARGETPLATFORM

ENV TZ=Europe/Berlin
ENV ANT_VERSION=1.10.12
ENV SAXON_VERSION=Saxon-HE/10/Java/SaxonHE10-8J
ENV PRINCE_VERSION=15-1
ENV UBUNTU_VERSION=22.04
ENV TARGETPLATFORM=$TARGETPLATFORM

ENV ANT_HOME=/opt/apache-ant-${ANT_VERSION}
ENV PATH=${PATH}:${ANT_HOME}/bin
ENV NODE_ENV=production

USER root

# install packages
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils openjdk-8-jre-headless unzip git npm libc6 aptitude libaom-dev gdebi fonts-stix

# setup ant
ADD https://downloads.apache.org/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz /tmp/ant.tar.gz
RUN tar -xvf /tmp/ant.tar.gz -C /opt

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

#WORKDIR /app
COPY ["package.json", "package-lock.json*", "./"]
#RUN npm install


ADD https://www.princexml.com/download/prince_${PRINCE_VERSION}_ubuntu${UBUNTU_VERSION}_${ARCHITECTURE}.deb /tmp/

RUN aptitude install -y gdebi
RUN gdebi --non-interactive /tmp/prince_${PRINCE_VERSION}_ubuntu${UBUNTU_VERSION}_${ARCHITECTURE}.deb && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

