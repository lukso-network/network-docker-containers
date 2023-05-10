# LUKSO Docker containers

This repo provides a base template to use Docker images to run LUKSO node (validator and non validator nodes).

LUKSO network configs are fetched from: [lukso-network/network-configs](https://github.com/lukso-network/network-configs).

It is provided "as is" and you are encouraged to adjust the configuration files for your own needs. The most important configuration files (which can't be changed) are the genesis files:

- `genesis.ssz`
- `genesis.json`

They can be found in our [`lukso-network/network-configs`](https://github.com/lukso-network/network-configs) repo.

For more information, check the [LUKSO Docs](https://docs.lukso.tech/networks/mainnet/running-a-node/).

## How to use

1. Clone the repo and fetch the submodules

```sh
git clone git@github.com:lukso-network/network-docker-containers.git
git submodule update --recursive
```

NOTE: if you want to support multiple networks, it is recommended to clone this repo again and work from different directories. This is to avoid mixing data and keystore folders.

2. Install docker

**Non validator mode**

3. Start the services:

```sh
# Compose V2 style (Docker):
docker compose --env-file .env.testnet up

# For compose V1 style (Docker), use:
# docker-compose --env-file .env.testnet up
```

**Validator mode**

3. Copy your `keystore-xxx.json` files in the [`./keystore](./keystore/) folder.

4. Write your keystore password in a temporary txt file:

```sh
echo "yourPassword" > /tmp/secrets/password.txt
```

NOTE 1: This password will also be used for the validator wallet.
NOTE 2: You can set your keystore password differently by changing the configuration in the `docker-compose.yml` file for the `prysm_validator_import` service.

5. Start the services with the `validator` profile:

```sh
docker compose --env-file .env.testnet --profile validator up

# To run in the background, use detached mode with -d flag
```

If you have database related issues (`database contains incompatible genesis`), delete the `./data` folder.

## Images

This repo is using the following docker images:

- Geth: [ethereum/client-go](https://hub.docker.com/r/ethereum/client-go)
- Prysm: [prysmaticlabs/prysm-beacon-chain](https://hub.docker.com/r/prysmaticlabs/prysm-beacon-chain)
- Prysm validator: [prysmaticlabs/prysm-validator](https://hub.docker.com/r/prysmaticlabs/prysm-validator)
- [macht/eth2stats-client](https://hub.docker.com/r/macht/eth2stats-client)
