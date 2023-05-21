export $(grep -v '^#' .env)
docker run \
  --rm \
  --volume $CONFIGS_VOLUME:/configs \
  --volume $TMP_VOLUME:/tmp/secrets \
  --volume $KEYSTORES_VOLUME:/keystores \
  --volume $VALIDATOR_DATA_VOLUME:/validator_data sigp/lighthouse:latest-modern lighthouse account validator import \
  --testnet-dir /configs \
  --password-file /tmp/secrets/password.txt \
  --reuse-password \
  --directory /keystores \
  --datadir /validator_data
