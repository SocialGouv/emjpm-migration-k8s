DUMP_FILE=$1
POD_NAME='emjpm-postgres-prod-0'

echo ""
echo ""
echo ""
echo "3. PUSH dumps/$DUMP_FILE TO the k8s"
echo ""
echo "kubectl cp ./dumps/$DUMP_FILE $POD_NAME:/tmp"
echo ""
echo ""
echo ""
echo "5. CONNECT TO YOUR POD"
echo ""
echo "kubectl exec -it $POD_NAME sh"
echo ""
echo ""
echo ""
echo "6. SUR LE POD"
echo ""
echo "cd /tmp"
echo "pg_restore -h localhost --no-owner --no-privileges -e -Fc -d emjpm -U postgres $DUMP_FILE"
echo ""
echo "RESTORE PRIVILEGES => '02.restore_prod_to_local.sh'"



