#!/bin/bash

# read config file and initialize variables.
# config file is ...
source ./ovhnotofier.conf

# check default values.
######################################
#                                    #
#                                    #
######################################

## fnctions:

# consumer key initializer:
function get_cons_key() {
    ovh_cons_key=$(curl -XPOST -H"X-Ovh-Applicatio: ${ovh_app_key}" \
                        -H"Content-type: application/json" \
                        "${ovh_api}auth/credential" \
                        -d '{"accessRules":[{"method":"GET", "path":"/*"}], "redirection":"${domain}"}' | jq -r ".consumerKey")
    echo "${ovh_cons_key}"
}

# # generate signature.
# function gen_sign(){
    
# }

