# network-docker-containers

Docker container for LUKSO compatible clients

LUKSO network configs are fetched from: [lukso-network/network-configs](https://github.com/lukso-network/network-configs)

## How to use

```sh
git submodule update --recursive
docker compose --env-file .env.tesnet up
```

If you have database related issues (`database contains incompatible genesis`), delete the `./data` folder.

## Images

This repo is using the following docker images:

- Geth: [ethereum/client-go](https://hub.docker.com/r/ethereum/client-go)
- Prysm: [prysmaticlabs/prysm-beacon-chain](https://hub.docker.com/r/prysmaticlabs/prysm-beacon-chain)
- Prysm validator: [prysmaticlabs/prysm-validator](https://hub.docker.com/r/prysmaticlabs/prysm-validator)
- [macht/eth2stats-client](https://hub.docker.com/r/macht/eth2stats-client)
