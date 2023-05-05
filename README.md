# network-docker-containers

Docker container for LUKSO compatible clients

LUKSO network configs are fetched from: [lukso-network/network-configs](https://github.com/lukso-network/network-configs)

## How to use

```sh
git submodule update --recursive
docker compose up
```

## Images

This repo is using the following docker images:

- Geth: https://hub.docker.com/r/ethereum/client-go
- Prysm: https://hub.docker.com/r/prysmaticlabs/prysm-beacon-chain
- Prysm validator: https://hub.docker.com/r/prysmaticlabs/prysm-validator

- https://hub.docker.com/r/macht/eth2stats-client
