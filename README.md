# emjpm-migration-k8s

```bash
cp 01.dump_prod.sample.sh 01.dump_prod.sh
// edit 01.dump_prod.sh and define params: VM_EMJPM_USER, VM_EMJPM_IP

cp 02.restore_prod_to_local.sample.sh 02.restore_prod_to_local.sh
// edit 01.dump_prod.sh and define param: EMJPM_GIT_REPO

./00.show_scripts.sh
```