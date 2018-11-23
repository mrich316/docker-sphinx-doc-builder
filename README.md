# Sphinx Documentation Builder

## Building the docker image:
``` shell
docker build -t sphinx-doc-builder .
```

## To see the usage of this container:
``` shell
docker run -ti --rm --init -v `pwd`:/docs \
  sphinx-doc-builder
```

## Create a new documentation site:
``` shell
docker run -ti --rm --init -v `pwd`:/docs \
  sphinx-doc-builder sphinx-quickstart
```

## To see build targets:
``` shell
docker run -ti --rm --init -v `pwd`:/docs \
  sphinx-doc-builder make help
```

## To edit and live-reload the html:
``` shell
docker run -ti --rm --init -v `pwd`:/docs -p 8000:8000 \
  sphinx-doc-builder make livehtml
```