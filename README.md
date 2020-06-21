# vault-docker-compose

this project is meant to be use as a repeatable, three command approach to setting up a vault server via docker.

```bash
git clone https://github.com/GuyBarros/vault-docker-compose
cd vault-docker-compose
docker-compose up
```

(Optional) and then from another terminal

```bash
./vault-init.sh
```

## Ent vs OSS

this project is set up to use Vault Enterprise by default if you want to change to Open Source you'll need to change the image in the docker-compose.yaml

```yaml
    image: hashicorp/vault
```

## The Init script

The Init script initializes Vault Shammir's unseal. after that, it enables audit log and then creates a new root token called "root"

that is pretty much all you need to get started, happy Vaulting.

