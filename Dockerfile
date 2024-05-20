FROM quay.io/strimzi/kafka:0.41.0-kafka-3.7.0

LABEL org.opencontainers.image.source=https://github.com/scholzj/zoo-entrance
LABEL org.opencontainers.image.title="Zoo Entrance"
LABEL org.opencontainers.image.description="Stunnel proxy for exposing ZooKeeper in Apache Kafka clusters managed by Strimzi operator"

USER root:root

RUN microdnf install -y stunnel

ENV STUNNEL_HOME=/opt/stunnel
RUN mkdir $STUNNEL_HOME && mkdir -p -m g+rw /usr/local/var/run/
COPY ./stunnel-scripts/ $STUNNEL_HOME

USER 1001
