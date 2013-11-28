etalab_marches_publics
======================

Etude de données marchés publics
2010 la données est trop pourrie pour être même inspectée.

sed 's/\"/“/g'  initial_data/siren.csv > initial_data/siren_quoted.csv
curl http://localhost:9200/etalab_siren_2012/_search -d'
{
  "query" : {
    "fuzzy_like_this" : {
       "fields" : ["name", "commercial_name"],
       "like_text" : "ID ACT DEVELOPPEMENT",
       "max_query_terms" : 12
    }
  }
}'