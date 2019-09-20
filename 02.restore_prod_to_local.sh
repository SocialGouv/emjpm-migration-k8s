export PGUSER=postgres
export PGPASSWORD=test
DB=emjpm
HASURA_USER=hasura
METABASE_USER=metabase

DUMP_FILE=$1

# restore production dump wihtout owner and privileges
pg_restore -h localhost -p 5434 --no-owner --no-privileges -e -Fc -d emjpm -U postgres ./dumps/$DUMP_FILE

# change owner
NEW_OWNER=emjpm
SCHEMA=public
# changement de propriétaire pour les tables
for tbl in `psql -h localhost -p 5434 -U $PGUSER -qAt -c "select tablename from pg_tables where schemaname = '$SCHEMA';" $DB` ; do  psql -h localhost -p 5434 -U $PGUSER -c "alter table \"$tbl\" owner to $NEW_OWNER" $DB ; done
# changement de propriétaire pour les sequences
for tbl in `psql -h localhost -p 5434 -U $PGUSER -qAt -c "select sequence_name from information_schema.sequences where sequence_schema = '$SCHEMA';" $DB` ; do  psql -h localhost -p 5434 -U $PGUSER -c "alter table \"$tbl\" owner to $NEW_OWNER" $DB ; done
# changement de propriétaire pour les views
for tbl in `psql -h localhost -p 5434 -U $PGUSER -qAt -c "select table_name from information_schema.views where table_schema = '$SCHEMA';" $DB` ; do  psql -h localhost -p 5434 -U $PGUSER -c "alter table \"$tbl\" owner to $NEW_OWNER" $DB ; done

# give back hasura privileges
psql -h localhost -p 5434 -c "GRANT ALL ON ALL TABLES IN SCHEMA public TO $HASURA_USER" -U $PGUSER $DB
psql -h localhost -p 5434 -c "GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO $HASURA_USER" -U $PGUSER $DB

# give back metabase privileges
psql -h localhost -p 5434 -c "GRANT SELECT ON ALL TABLES IN SCHEMA public TO $METABASE_USER" -U $PGUSER $DB

