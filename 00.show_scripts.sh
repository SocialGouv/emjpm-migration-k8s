DUMP_FILE=dump_`date +%d-%m-%Y"_"%H_%M_%S`.dump


echo ""
echo ""

echo "1. DUMP PRODUCTION"
echo ""
echo "./01.dump_prod.sh $DUMP_FILE"

echo ""
echo ""
echo "2. RESTORE / MIGRATE / DUMP PRODUCTION ON LOCAL "
echo ""
echo "./02.restore_prod_to_local.sh $DUMP_FILE"

echo ""
echo ""
echo "3. RESTORE MIGRATED DUMP ON K8S"
echo ""
echo "./03.restore_prod_to_k8s.sh $DUMP_FILE"
