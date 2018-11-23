FROM python:3-alpine

ENV SPHINX_VERSION="1.8.2" \
    SPHINX_AUTOBUILD_VERSION="0.7.1" \
    SPHINX_RTD_THEME_VERSION="0.4.2" \
    SPHINXCONTRIB_PLANTUML_VERSION="0.12" \
    PLANTUML_VERSION="1.2018.12" \
    LANG="en_US.UTF-8"

# Install dependencies
RUN apk add --no-cache \
      ca-certificates \
      curl \
      fontconfig \
      graphviz \
      make \
      openjdk8-jre \
      unzip \
 && rm -rf /var/cache/apk/* \
 && pip install --no-cache-dir \
      sphinx==${SPHINX_VERSION} \
      sphinx-autobuild==${SPHINX_AUTOBUILD_VERSION} \
      sphinx-rtd-theme==${SPHINX_RTD_THEME_VERSION} \
      sphinxcontrib-plantuml==${SPHINXCONTRIB_PLANTUML_VERSION}

COPY plantuml/ /usr/share/plantuml/
COPY docker-entrypoint.sh /

RUN mv /usr/share/plantuml/plantuml /usr/bin/ \
  && chmod +x \
       /docker-entrypoint.sh \
       /usr/bin/plantuml \
  # Download PlantUML and validate checksum.
  && mkdir -p /usr/share/plantuml \
  && cd /usr/share/plantuml \
  && curl -sSL --output plantuml.jar "https://downloads.sourceforge.net/project/plantuml/${PLANTUML_VERSION}/plantuml.${PLANTUML_VERSION}.jar" \
  && sha512sum plantuml.jar \
  && plantuml_sha512='412876c077ddbfad6433c5b1fcb8dc2238a52f22b7f35a99bfeb768bf48a39110f38e9a23b582a9565dc7a9f15ef4f39fecc1526e42e0d440858a8df21b1bf24' \
  && echo "$plantuml_sha512  plantuml.jar" | sha512sum -c - \
  # Download Lato font and update font cache.
  && mkdir -p /usr/share/fonts/TTF \
  && cd /usr/share/fonts/TTF \
  && curl -sSL --output Lato.zip https://fonts.google.com/download?family=Lato \
  && unzip Lato.zip \
  && rm Lato.zip \
  && fc-cache

COPY quickstart_templates/* /etc/defaults/sphinx/
WORKDIR /doc
ENTRYPOINT [ "/docker-entrypoint.sh" ]
