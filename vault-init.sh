export VAULT_ADDR=http://localhost:8200
while ! curl $VAULT_ADDR/sys/health -s --show-error; do
  echo "Waiting for Vault to be ready"
  sleep 2
done
vault operator init -status > /dev/null
if [ $? -eq 2 ]; then
vault operator init > keys.txt
fi
#   The exit code reflects the seal status:
#       - 0 - unsealed
#       - 1 - error
#       - 2 - sealed
vault status
if [ $? -eq 2 ]; then
vault operator unseal $(grep -h 'Unseal Key 1' keys.txt | awk '{print $NF}')
vault operator unseal $(grep -h 'Unseal Key 2' keys.txt | awk '{print $NF}')
vault operator unseal $(grep -h 'Unseal Key 3' keys.txt | awk '{print $NF}')
fi
# login
vault login $(grep -h 'Initial Root Token' keys.txt | awk '{print $NF}') > /dev/null
vault audit enable file file_path=/vault/logs/$(date "+%Y%m%d%H%M.%S").log.json


ent=$(vault version| grep -o '...$')
if [ $ent == "ent" ]
then
echo "--> Ent - Appyling License"
vault write sys/license text=${vaultlicense}
echo "--> Ent - License applied"
else
echo "--> OSS - no license necessary"
fi
# license

echo "--> Optional: create a root token called root"
vault token create -id root -display-name root
