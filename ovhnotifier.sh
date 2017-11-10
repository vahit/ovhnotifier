#!/bin/bash

# read config file and initialize variables.
# config file is ...
source ./ovhnotifier.conf

# check default values.
######################################
#                                    #
#                                    #
######################################

## fnctions:

# consumer key initializer:
function get_cons_key() {
    cons_key=$(curl -XPOST -H"X-Ovh-Application: ${ovh_app_key}" \
                        -H"Content-type: application/json" \
                        "${ovh_api}/auth/credential" \
                        -d '{"accessRules":[{"method":"GET", "path":"/*"}]}' | jq -r ".consumerKey")
    echo "${cons_key}"
}
ovh_cons_key=get_cons_key

# get timestamp
function get_timestamp() {
    timestamp=$(curl "${ovh_api}/auth/time")
    echo "${timestamp}"
}

# generate signature.
function gen_sign(){
    method="${1}"
    query="${2}"
    timestamp=get_timestamp
    sigdata="${ovh_app_key}+${ovh_cons_key}+${method}+${ovh_api}+${query}+${timestamp}"
    sig='$1$'$(echo -n $sigdata | sha1sum - | cut -d" " -f1)
    echo "${sig}"
}

