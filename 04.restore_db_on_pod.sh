DUMP_FILE=$1


cd /tmp

echo "deconnexion des user"
psql -h localhost -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = 'emjpm' AND pid <> pg_backend_pid()" -U postgres

echo "drop database emjpm"
psql -h localhost -c "DROP DATABASE IF EXISTS emjpm" -U postgres
echo "create database emjpm"
psql -h localhost -c "CREATE DATABASE emjpm" -U postgres

echo "restore dump $DUMP_FILE"
pg_restore -h localhost --if-exists --clean --no-owner --no-privileges -e -Fc -d emjpm -U postgres ./$DUMP_FILE

# change owner
echo "changement de propriétaire pour les tables"
for tbl in `psql -h localhost -U postgres -qAt -c "select tablename from pg_tables where schemaname = 'public';" emjpm` ; do  psql -h localhost -U postgres -c "alter table \"$tbl\" owner to emjpm" emjpm ; done
echo "changement de propriétaire pour les sequences"
for tbl in `psql -h localhost -U postgres -qAt -c "select sequence_name from information_schema.sequences where sequence_schema = 'public';" emjpm` ; do  psql -h localhost -U postgres -c "alter table \"$tbl\" owner to emjpm" emjpm ; done
echo "changement de propriétaire pour les views"
for tbl in `psql -h localhost -U postgres -qAt -c "select table_name from information_schema.views where table_schema = 'public';" emjpm` ; do  psql -h localhost -U postgres -c "alter table \"$tbl\" owner to emjpm" emjpm ; done

echo "give back hasura privileges"
psql -h localhost -c "GRANT ALL ON ALL TABLES IN SCHEMA public TO hasura" -U postgres emjpm
psql -h localhost -c "GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO hasura" -U postgres emjpm

echo "give back metabase privileges"
psql -h localhost -c "GRANT SELECT ON ALL TABLES IN SCHEMA public TO metabase" -U postgres emjpm