# nelson-containers
Various containers to support Nelson

## consul-template

The consul-template container is used by Nelson to lint templates in a simulated environment with the same Vault token as the deployed unit will be granted. This can be used to test the validity of a configuration without exposing the credentials to the developer.
