FROM docker-mei-base
#ghcr.io/riedde/docker-mei-guidelines-image:main

LABEL org.opencontainers.image.authors="https://github.com/riedde"
LABEL org.opencontainers.image.source="https://github.com/riedde/docker-mei-guidelines-image"
LABEL org.opencontainers.image.revision="v0.0.1"

CMD ["ant"]