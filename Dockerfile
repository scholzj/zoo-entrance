FROM quay.io/strimzi/kafka:latest-kafka-2.8.0

LABEL org.opencontainers.image.source https://github.com/scholzj/zoo-entrance

COPY ./stunnel-scripts/ $STUNNEL_HOME