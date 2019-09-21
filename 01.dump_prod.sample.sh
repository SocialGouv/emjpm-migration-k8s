DUMP_FILE=$1

VM_EMJPM_USER={ADD_VM_EMJPM_USER}
VM_EMJPM_IP={ADD_VM_EMJPM_IP}

DATABASE=emjpm_prod
PGUSER=api

echo ""
echo ""
echo ""
echo ""
echo ""

echo "1. OPEN SSH TUNNEL"
echo ""
echo "ssh -L 1111:localhost:5434 $VM_EMJPM_USER@"

echo ""
echo ""
echo "2. DUMP DATABASE"
echo ""
echo "pg_dump -h localhost -p 1111 $DATABASE -U $PGUSER -Fc -W > ./dumps/$DUMP_FILE"