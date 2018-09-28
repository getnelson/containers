#!/bin/bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

if [ -f "${INPUT_FILE:-}" ]; then
  VAULT_ADDR="${VAULT_ADDR}" VAULT_TOKEN="${VAULT_TOKEN}" /usr/local/bin/gomplate \
    -d vault="vault+https:///" \
    -f "${INPUT_FILE}"
else
  echo "[fatal] the file specified at $INPUT_FILE does not exist or could not be read."
  exit 1;
fi
