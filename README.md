# network-docker-containers

Docker container for LUKSO compatible clients

LUKSO network configs are fetched from: [lukso-network/network-configs](https://github.com/lukso-network/network-configs)

## How to use

Compose V2 style (Docker):
```sh
git submodule update --recursive
docker compose --env-file .env.testnet up
```

Compose V1 style (Docker):
```sh
git submodule update --recursive`
docker-compose --env-file .env.testnet up
```

If you have database related issues (`database contains incompatible genesis`), delete the `./data` folder.

## Images

This repo is using the following docker images:

- Geth: https://hub.docker.com/r/ethereum/client-go
- Prysm: https://hub.docker.com/r/prysmaticlabs/prysm-beacon-chain
- Prysm validator: https://hub.docker.com/r/prysmaticlabs/prysm-validator

- https://hub.docker.com/r/macht/eth2stats-client
