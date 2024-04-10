ARG BASE_IMAGE=bikenow.vkw.tu-dresden.de/priobike/priobike-graphhopper-drn:stable
# Where the OSM file is located in the base image.
ARG OSM_FILE_PATH=/graphhopper/map.osm
# Depending on the format of the OSM file, we need conversion to have it in the .bz2 format
# This command looks a bit strange, but when downloading the osm file it is saved as planet.osm.bz2,
# although it might not be in .bz2 format.
ARG OVERPASS_PLANET_PREPROCESS='mv /db/planet.osm.bz2 /db/planet.osm && osmium cat -o /db/planet.osm.bz2 /db/planet.osm && rm /db/planet.osm'
# Use this argument to invalidate the cache of subsequent steps.
ARG CACHE_DATE=1970-01-01

FROM $BASE_IMAGE as graphhopper

FROM wiktorn/overpass-api as runner

COPY --from=graphhopper $OSM_FILE_PATH /map.osm

ARG OSM_FILE_URL=file:///map.osm

ENV OVERPASS_META=no
ENV OVERPASS_MODE=init
ENV OVERPASS_PLANET_URL=$OSM_FILE_URL
ENV OVERPASS_PLANET_PREPROCESS=$OVERPASS_PLANET_PREPROCESS
ENV OVERPASS_USE_AREAS=false
ENV OVERPASS_STOP_AFTER_INIT=true

# Imports the OSM file to the database and performs the preprocessing incl. indexing
RUN /app/docker-entrypoint.sh

ENV OVERPASS_STOP_AFTER_INIT=false

CMD ["/app/docker-entrypoint.sh"]