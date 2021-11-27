# ZooKeeper Entrance

**This is not part of the Strimzi project!**

[Strimzi](https://strimzi.io) is a CNCF project which provides an operator for Apache Kafka.
When Strimzi deploys the Kafka cluster, it keeps the ZooKeeper secure and inaccessible from any other application.
This project deploys an Stunnel proxy which exposes the Zookeeper without any authentication and encryption.
It is using the Cluster Operator certificate to authenticate against Zookeeper and handle encryption.

Strimzi has a good reasons why not expose ZooKeeper, such as security, stability and performance.
This proxy leaves the ZooKeeper cluster unprotected and everyone with access to the proxy and service can connect.
**So use only at your own risk!**

## Usage

To deploy the proxy, apply the `deploy.yaml` file:

```
kubectl apply -f deploy.yaml
```

That creates the deployment with the proxy named `zoo-entrance`, a service named `zoo-entrance` and a Network Policy to allow the proxy to connect to the broker.
You should deploy it into the same namespace where the Kafka cluster runs.
From your application, you can just connect to `zoo-entrance:2181` or from another namespace to `zoo-entrance.<namespce>.svc:2181`.

The deployment by default expects it is connecting to Strimzi deployed Kafka cluster named `my-cluster`.
When your cluster has different name, you have to change the deployment:

* The `STRIMZI_ZOOKEEPER_CONNECT` environment variable (line 32)
* The name of the secret with the Cluster Operator key (line 65)
* The name of the secret with the Cluster public key (line 69)
* The match label in the Network Policy (line 106)

In all cases, just replace `my-cluster` with the name of your cluster.

## Building the image

The Docker image is available on Docker Hub under `ghcr.io/scholzj/zoo-entrance:latest`.
If you want to build your own, you can use `make` for it.

Define following environment variables:
* `DOCKER_REGISTRY` with the Docker registry you want to use (e.g. `docker.io`)
* `DOCKER_ORG` with the name of your Docker organization (e.g. `scholzj`)
* `DOCKER_IMAGE` with he name of the image (e.g. `zoo-entrance`)
* `DOCKER_TAG` with the tag (e.g. `latest`)

After wards run either `make all` to build and push the Docker image or `make docker_build` and `make docker_push` to build and push it separately.