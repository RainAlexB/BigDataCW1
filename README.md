# BigDataCW1

MySQL to NoSQL Project </br>
MySQL -> Neo4J </br>
MySQL -> Cassandra </br>


To execute any sql files make sure to replace `USE rb105` in the file with `USE <your_username>`
#### Load to Neo4J
Make sure the csvs in `neo4j/CSVs/` are in the import repository of your neo4j installation
and execute
```
./bin/neo4j-admin import --nodes import/nodes/album.csv --nodes import/nodes/artist.csv --nodes import/nodes/customer.csv --nodes import/nodes/employee.csv --nodes import/nodes/genre.csv --nodes import/nodes/invoice.csv --nodes import/nodes/mediatype.csv --nodes import/nodes/playlist.csv --nodes import/nodes/track.csv --relationships import/rels/added.csv --relationships import/rels/billed.csv --relationships import/rels/documents.csv --relationships import/rels/has_track.csv --relationships import/rels/is_genre_of.csv --relationships import/rels/is_mediatype_of.csv --relationships import/rels/performed_on.csv --relationships import/rels/reports_to.csv --relationships import/rels/supported.csv 

```

### Load to Cassandra
1. Import `cassandra/Chinook.cql`
2. Log into Cassandra and switch to keyspace
3. For each table execute:
   ```
   COPY table(column1, column2, ...) FROM '~/table.txt' WITH DELIMITER='\t';
   ```
   
   If table data is in a csv, remove the `WITH DELIMITER='\t'` option.
