# LUKSO Docker containers

This repo provides a base template to use Docker images to run LUKSO node (validator and non validator nodes).

LUKSO network configs are fetched from: [lukso-network/network-configs](https://github.com/lukso-network/network-configs).

It is provided "as is" and you are encouraged to adjust the configuration files for your own needs. The most important configuration files are the genesis files:

- `genesis.ssz`
- `genesis.json`

**⚠️ Important:** for mainnet launch, you have to select the genesis files with the initial supply you want to have (cf. step 6 below):

- `genesis_32.ssz`, `genesis_42.ssz` or `genesis_100.ssz`
- `genesis_32.json`, `genesis_42.json` or `genesis_100.json`

They can be found in our [`lukso-network/network-configs`](https://github.com/lukso-network/network-configs) repo.

For more information, check the [LUKSO Docs](https://docs.lukso.tech/networks/mainnet/running-a-node/).

## How to use

1. Clone the repo and fetch the submodules.

```sh
git clone git@github.com:lukso-network/network-docker-containers.git
cd network-docker-containers
git submodule update --init --recursive --depth 1
```

NOTE: if you want to support multiple networks, it is recommended to clone this repo again and work from different directories. This is to avoid mixing data and keystore folders.

2. Install [docker](https://docs.docker.com/engine/install/ubuntu/).
   Here is a tutorial for [Ubuntu 22.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04)

3. **IMPORTANT:** Adjust the values in `.env` file (node name, fee recipient address, etc.).

4. Copy your `keystore-xxx.json` files in the [`./keystores/[network]`](./keystores) folder.

5. Write your keystore password in a temporary txt file:

```sh
echo "yourPassword" > /tmp/secrets/password.txt
```

NOTE 1: This password will also be used for the validator wallet.

NOTE 2: You can set your keystore password differently by changing the configuration in the `docker-compose.yml` file for the `prysm_validator_import` service.

6. For mainnet, you need to select your supply:

```sh
# Example to select the 42M supply
cp network-configs/mainnet/shared/genesis_42.json network-configs/mainnet/shared/genesis.json
cp network-configs/mainnet/shared/genesis_42.ssz network-configs/mainnet/shared/genesis.ssz

# For other supplies, replace 42 with 35 or 100
```

7. Start the services:

```sh
docker compose up

# To run in the background, use detached mode with -d flag

# For testnet:
# docker compose --env-file .env.testnet up
```

### Useful commands

Check the status of the containers:

```sh
docker ps

# CONTAINER ID   IMAGE                                       COMMAND                  CREATED              STATUS                         PORTS                    NAMES
# 1ffeefcbcfb4   prysmaticlabs/prysm-validator:v4.0.3        "/app/cmd/validator/…"   About a minute ago   Up About a minute                                       prysm_validator
# 1dff26d8026a   prysmaticlabs/prysm-beacon-chain:v4.0.3     "/app/cmd/beacon-cha…"   About a minute ago   Up About a minute                                       prysm_beacon
# b3e2c814ddb5   ethereum/client-go:v1.11.6                  "geth --config /conf…"   About a minute ago   Up About a minute                                       geth
```

Check the logs to make sure everything is running fine:

```sh
docker compose logs -f geth

# You can see the logs of each service:
# docker compose logs -f prysm_validator
# ...
```

## Monitoring

We provide another repo which can help you set up monitoring for your node: [`lukso-network/network-docker-monitoring`](https://github.com/lukso-network/network-docker-monitoring).

You will need to uncomment these lines in the [`docker-compose.yml`](./docker-compose.yml) file:

```txt
--metrics
--metrics.addr "0.0.0.0"
--pprof
--pprof.addr=0.0.0.0
```

### Execution stats

To add your node on the [execution stats page](https://stats.execution.mainnet.lukso.network/), fill out [this form](https://docs.google.com/forms/d/e/1FAIpQLSf6_vflZkaRh8dgHMiFtZI5g3DrBFKP4Sc2l2DBW95OWRFO9g/viewform) to receive the secret.

You will then need to update these values in the [`.env`](./.env) file:

```
NODE_NAME=myNodeName
ETH_STATS_SECRET=xxx
```

And uncomment this line in the [`docker-compose.yml`](./docker-compose.yml) file:

```
--ethstats "${NODE_NAME}:${ETH_STATS_SECRET}@${ETH_STATS_ADDRESS}"
```

## Images

This repo is using the following docker images:

- Geth: [ethereum/client-go](https://hub.docker.com/r/ethereum/client-go)
- Prysm: [prysmaticlabs/prysm-beacon-chain](https://hub.docker.com/r/prysmaticlabs/prysm-beacon-chain)
- Prysm validator: [prysmaticlabs/prysm-validator](https://hub.docker.com/r/prysmaticlabs/prysm-validator)
- [macht/eth2stats-client](https://hub.docker.com/r/macht/eth2stats-client)

## Resources

- [LUKSO Docs](https://docs.lukso.network)
- [Genesis Validators, start your clients!](https://medium.com/lukso/genesis-validators-start-your-clients-fe01db8f3fba)
- [GitHub repo: lukso-network/network-configs](https://github.com/lukso-network/network-configs)
- [Deposit launchpad](https://deposit.mainnet.lukso.network/)
