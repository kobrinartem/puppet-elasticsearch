
good_json = '{
  "template" : "logstash-*",
  "settings" : {
    "index.refresh_interval" : "5s",
    "analysis" : {
      "analyzer" : {
        "default" : {
          "type" : "standard",
          "stopwords" : "_none_"
        }
      }
    }
  },
  "mappings" : {
    "_default_" : {
       "_all" : {"enabled" : true},
       "dynamic_templates" : [ {
         "string_fields" : {
           "match" : "*",
           "match_mapping_type" : "string",
           "mapping" : {
             "type" : "multi_field",
               "fields" : {
                 "{name}" : {"type": "string", "index" : "analyzed", "omit_norms" : true },
                 "raw" : {"type": "string", "index" : "not_analyzed", "ignore_above" : 256}
               }
           }
         }
       } ],
       "properties" : {
         "@version": { "type": "string", "index": "not_analyzed" },
         "geoip"  : {
           "type" : "object",
             "dynamic": true,
             "path": "full",
             "properties" : {
               "location" : { "type" : "geo_point" }
             }
         }
       }
    }
  }
}
'

bad_json = '{
  "settings" : {
    "index.refresh_interval" : "5s",
    "analysis" : {
      "analyzer" : {
        "default" : {
          "type" : "standard",
          "stopwords" : "_none_"
        }
      }
    }
  },
  "mappings" : {
    "_default_" : {
       "_all" : {"enabled" : true},
       "dynamic_templates" : [ {
         "string_fields" : {
           "match" : "*",
           "match_mapping_type" : "string",
           "mapping" : {
             "type" : "multi_field",
               "fields" : {
                 "{name}" : {"type": "string", "index" : "analyzed", "omit_norms" : true },
                 "raw" : {"type": "string", "index" : "not_analyzed", "ignore_above" : 256}
               }
           }
         }
       } ],
       "properties" : {
         "@version": { "type": "string", "index": "not_analyzed" },
         "geoip"  : {
           "type" : "object",
             "dynamic": true,
             "path": "full",
             "properties" : {
               "location" : { "type" : "geo_point" }
             }
         }
       }
    }
  }
}
'

