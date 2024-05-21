FROM registry.access.redhat.com/ubi9/ubi-minimal:latest

LABEL org.opencontainers.image.source=https://github.com/scholzj/zoo-entrance
LABEL org.opencontainers.image.title="Zoo Entrance"
LABEL org.opencontainers.image.description="Stunnel proxy for exposing ZooKeeper in Apache Kafka clusters managed by Strimzi operator"

USER root:root

RUN microdnf update \
    && microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y stunnel net-tools \
    && microdnf clean all

ENV STUNNEL_HOME=/opt/stunnel
RUN mkdir $STUNNEL_HOME && mkdir -p -m g+rw /usr/local/var/run/
COPY ./stunnel-scripts/ $STUNNEL_HOME

USER 1001