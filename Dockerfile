FROM quay.io/strimzi/kafka:0.28.0-kafka-3.1.0

LABEL org.opencontainers.image.source https://github.com/scholzj/zoo-entrance \
      summary="Zoo Entrance" \
      description="Stunnel proxy for exposing ZooKeeper in Apache Kafka clusters managed by Strimzi operator"

COPY ./stunnel-scripts/ $STUNNEL_HOME
