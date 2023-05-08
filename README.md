# docker-mei

Docker image for anything concerning the MEI build process.

The image contains all the necessary dependencies:

* **Apache ANT:** to execute all necessary build steps
* **Saxon HE:** for executing XSL-Transformations
* **Verovio Toolkit:** to render MEI examples to SVG
* **Prince XML:** to convert the Guidelines HTML to PDF

The image is being published on the GitHub Container Registry.

## Pull docker image

```bash
docker pull ghcr.io/music-encoding/docker-mei
```

## Example usage

```bash
docker run --rm -v /ABSOLUTE/PATH/TO/YOUR/MUSIC_ENCODING/CLONE:/opt/docker-mei/music-encoding --name docker-mei ghcr.io/music-encoding/docker-mei
```

For example, if you start the Docker image from the root folder of your music-encoding repository clone:

```bash
docker run --rm -v `pwd`:/opt/docker-mei/music-encoding --name docker-mei ghcr.io/music-encoding/docker-mei
```

## Local build and usage

Clone the repository to your machine, e.g., via the command line:

1. Navigate to the parent directory where you want your clone to live, e.g.:

    ```bash
    cd /temp/ 
    ```

2. Clone the repository:

    ```bash
    git clone https://github.com/music-encoding/docker-mei.git 
    ```

3. Navigate to the new repository clone’s root directory:

    ```bash
    cd docker-mei
    ```

4. Build the Docker image locally:

    ```bash
    docker buildx build -t [some-name-tag] .
    ```

    N.B.: Before executing the above command, replace _[some-name-tag]_ with a name of your liking, e.g.:

    ```bash
    docker buildx build -t docker-mei:local .
    ```

5. Run your local Docker image

    ```bash
    docker run --rm -v [/ABSOLUTE/PATH/TO/YOUR/MUSIC_ENCODING/CLONE]:/opt/docker-mei/music-encoding --name docker-mei [some-name-tag]
    ```

    N.B.: Before executing the above command, replace the _[SQUARE-BRACKETS]_ with your local variables.
