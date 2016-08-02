#
# ElasticSearch Dockerfile
#
# Modified from https://github.com/dockerfile/elasticsearch for the BigBoards Hex.
#

# Pull base image.
FROM bigboards/java-7-__arch__

MAINTAINER bigboards

ENV ES_PKG_NAME elasticsearch-2.3.4
ENV ES_PKG_VERSION 2.3.4

# Install ElasticSearch.
RUN \
  cd / && \
  wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/$ES_PKG_VERSION/elasticsearch-$ES_PKG_VERSION.tar.gz && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ES_PKG_VERSION.tar.gz && \
  tar xzf elasticsearch-$ES_PKG_VERSION.tar.gz && \
  rm -f elasticsearch-$ES_PKG_VERSION.tar.gz && \
  mv /elasticsearch-$ES_PKG_VERSION /elasticsearch

# Install Sigar
ADD libsigar-*.so /elasticsearch/lib/sigar/

RUN \
  /elasticsearch/bin/plugin -i lmenezes/elasticsearch-kopf/master

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300