# docker-mei

A docker image for anything concerning MEI.

## Build
```docker build -t docker-mei . ```


## Exampl usage (without local build)

```docker run --rm -v /ABSOLUTE/PATH/TO/YOUR/MUSIC_ENCODING/CLONE:/opt/music-encoding --name docker-mei ghcr.io/riedde/docker-mei-guidelines-image:main```


## Exampl usage (local build)

```docker run --rm -v /ABSOLUTE/PATH/TO/YOUR/MUSIC_ENCODING/CLONE:/opt/music-encoding --name docker-mei docker-mei```
