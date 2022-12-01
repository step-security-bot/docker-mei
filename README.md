# docker-mei

Docker images for anything concerning the MEI build process.

The repository contains two Dockerfiles:

- `Dockerfile.base`: creates a basic image with all necessary dependencies (Saxon, Ant, Verovio, Prince)
- `Dockerfile`: creates an executing image that allows running different MEI build steps (incl. building schema, customizations, or guidelines)

## Local build of basic image

```docker build -f Dockerfile.base -t docker-mei-base . ```

## Local build of executing image

```docker build -t docker-mei .```

## Example usage (without local build)

tbc.

## Example usage (local build)

```docker run --rm -v /ABSOLUTE/PATH/TO/YOUR/MUSIC_ENCODING/CLONE:/opt/music-encoding --name docker-mei docker-mei```
