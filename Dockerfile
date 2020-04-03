FROM strimzi/kafka:latest-kafka-2.4.0

COPY ./stunnel-scripts/ $STUNNEL_HOME