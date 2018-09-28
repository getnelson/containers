#!/bin/bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

if [ -f "${INPUT_FILE:-}" ]; then
  /usr/local/bin/consul-template \
  -config /consul-template/config.d/root.conf \
  -once \
  -dry \
  -vault-addr="${VAULT_ADDR:-}" \
  -vault-token="${VAULT_TOKEN:-}" \
  -template="${INPUT_FILE}"
else
  echo "[fatal] the file specified at $INPUT_FILE does not exist or could not be read."
  exit 1;
fi
