# Containers

[![Build Status](https://travis-ci.org/getnelson/containers.svg?branch=master)](https://travis-ci.org/getnelson/containers)

Various containers to support Nelson at runtime - template linting, sidecars etc.

# Linters

At present Nelson supports two generic type of end-user templating linting engines:

* [Consul Template](#linter-consul-template)
* [Gomplate](#linter-gomplate)

Users are able to add arbitrary templating engines as they see fit, provided they meet the protocol with which Nelson will invoke them. Specifically, the `ENTRYPOINT` must accept the following arguments:

* `--file`: The path to the input file on the filesystem (inside the container)
* `--vault-addr`: The fully qualified URL to the Vault server (for example, https://vault.foo.com)
* `--vault-token`: The token Nelson should use to interact with Vault (as needed)

By default `common/entrypoint.sh` handles this argument parsing, and delegates to a script of your choosing at `/usr/local/bin/render`, at which point you can delegate to any templating engine.

At runtime, Nelson will run a docker command that looks like this:

```
docker -H tcp://127.0.0.1:2375 \
  run --name $containerName \
  --rm -v ${path.getParent}:/templates \
  --memory=${templateConfig.memoryMegabytes}m \
  --memory-swap=-1 \
  --cpu-period=${templateConfig.cpuPeriod} \
  --cpu-quota=${templateConfig.cpuQuota} \
  --net=host \
  --env=NELSON_DATACENTER \
  --env=NELSON_DNS_ROOT=${dnsRoot} \
  --env=NELSON_ENV=${$ns.root.asString} \
  --env=NELSON_PLAN=default \
  --env=NELSON_STACKNAME=sn.toString \
  getnelson/linter-gomplate \
  --vault-addr=${vaultAddr} \
  --vault-token=${vaultToken} \
  --file=/templates/${path.getFileName}
```

Whislt verbose, this means that Nelson can invoke the container with constrained resources and provide a realistic linting scenario for end-application developers.

## linter-consul-template

The [consul-template](https://github.com/hashicorp/consul-template) container is used by Nelson to lint templates in a simulated environment with the same Vault token as the deployed unit will be granted. This can be used to test the validity of a configuration without exposing the credentials to the developer.

```
# to build, use the following:
IMAGE_SRC=linter-consul-template make build
```

## linter-gomplate

The [gomplate](https://gomplate.hairyhenderson.ca) container is used by Nelson to lint templates in a simulated environment with the same Vault token as the deployed unit will be granted. This can be used to test the validity of a configuration without exposing the credentials to the developer.

```
# to build, use the following:
IMAGE_SRC=linter-gomplate make build
```
