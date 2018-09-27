# Containers

[![Build Status](https://travis-ci.org/getnelson/containers.svg?branch=master)](https://travis-ci.org/getnelson/containers)

Various containers to support Nelson at runtime - template linting, sidecars etc.

## linter-consul-template

The [consul-template](https://github.com/hashicorp/consul-template) container is used by Nelson to lint templates in a simulated environment with the same Vault token as the deployed unit will be granted. This can be used to test the validity of a configuration without exposing the credentials to the developer.

## linter-gomplate 

The [gomplate](https://gomplate.hairyhenderson.ca) container is used by Nelson to lint templates in a simulated environment with the same Vault token as the deployed unit will be granted. This can be used to test the validity of a configuration without exposing the credentials to the developer.
