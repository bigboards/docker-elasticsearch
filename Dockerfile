#FROM bigboards/java-8-__arch__
FROM bigboards/java-8-x86_64

MAINTAINER Daan Gerits <daan@bigboards.io>

ADD docker_files/archive.key /tmp/archive.key
ADD docker_files/elasticsearch.list /etc/apt/sources.list.d/elasticsearch.list

RUN apt-key add /tmp/archive.key
RUN apt-get update && apt-get install -y elasticsearch=2.3.4

VOLUME /data
VOLUME /etc/elasticsearch

EXPOSE 9200 9300

CMD ["elasticsearch"]