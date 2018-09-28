#!/bin/bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

RENDER_SCRIPT=/usr/local/bin/render

die() {
  echo "$*" 1>&2 ; exit 1;
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --file) ARG_INPUT_FILE="$2"; shift 2;;
    --vault-addr) ARG_VAULT_ADDR="$2"; shift 2;;
    --vault-token) ARG_VAULT_TOKEN="$2"; shift 2;;
    --debug) IS_DEBUG="true"; shift 1;;
    -*) echo "unknown option: $1" >&2; exit 1;;
    *) die "unrecognized argument: $1"; shift 1;;
  esac
done

if [ -z "${ARG_INPUT_FILE:-}" ] || [ -z "${ARG_VAULT_ADDR:-}" ] || [ -z "${ARG_VAULT_TOKEN:-}" ]; then
  echo "[fatal] the following arguments must be passed to this script:"
  echo "[fatal]     --file /path/to/thing.template"
  echo "[fatal]     --vault-addr https://you.vault.company.com"
  echo "[fatal]     --vault-token qwert-xfffg-ssfff-wweee"
  exit 1;
else
  if [ "${IS_DEBUG:-false}" = "true" ]; then
    echo INPUT_FILE="${ARG_INPUT_FILE}" \
    VAULT_ADDR="${ARG_VAULT_ADDR}" \
    VAULT_TOKEN="${ARG_VAULT_TOKEN}" \
    "${RENDER_SCRIPT}"
  else
    if [ -f "${RENDER_SCRIPT}" ]; then
      INPUT_FILE="${ARG_INPUT_FILE}" \
      VAULT_ADDR="${ARG_VAULT_ADDR}" \
      VAULT_TOKEN="${ARG_VAULT_TOKEN}" \
      "${RENDER_SCRIPT}"
    else
      echo "[fatal] Unable to invoke the template rendering engine in the configured container."
      echo "[fatal] Please ensure that the specified template container for templating linting can"
      echo "[fatal] accept the Nelson lint protocol by having a script at ${RENDER_SCRIPT} that"
      echo "[fatal] recieves the following environment variables:"
      echo "[fatal]     INPUT_FILE=/path/to/thing.template"
      echo "[fatal]     VAULT_ADDR=https://you.vault.company.com"
      echo "[fatal]     VAULT_TOKEN=qwert-xfffg-ssfff-wweee"
      exit 1;
    fi
  fi
fi
