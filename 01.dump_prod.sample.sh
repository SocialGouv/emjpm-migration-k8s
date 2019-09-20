DUMP_FILE=$1
DATABASE=emjpm_prod
PGUSER=api

echo ""
echo ""
echo ""
echo ""
echo ""

echo "1. OPEN SSH TUNNEL"
echo ""
echo "ssh -L 1111:localhost:5434 user@000.000.000.000"

echo ""
echo ""
echo "2. DUMP DATABASE"
echo ""
echo "pg_dump -h localhost -p 1111 $DATABASE -U $PGUSER -Fc -c -W > ./dumps/$DUMP_FILE"