FROM quay.io/strimzi/kafka:0.29.0-kafka-3.2.0

LABEL org.opencontainers.image.source=https://github.com/scholzj/zoo-entrance
LABEL org.opencontainers.image.title="Zoo Entrance"
LABEL org.opencontainers.image.description="Stunnel proxy for exposing ZooKeeper in Apache Kafka clusters managed by Strimzi operator"

COPY ./stunnel-scripts/ $STUNNEL_HOME
