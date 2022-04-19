#!/bin/bash

verb=$1
endpoint=$2
params=$3

print_usage() {
    local message=$'Usage: ./api.sh [HTTP_VERB] [ENDPOINT] [PARAMS].\nEg: ./api.sh post https://localhost:5001 \'{"email":"test@test.com","password":"Test@123"}\' (without spaces) '
    echo "$message"
}


if [[ -z "$verb" || -z "$endpoint" ]]
then
    func_result="$(print_usage)"
    echo $func_result
    exit
fi

curl --insecure -X $verb $endpoint -H 'accept: */*' -H "Content-Type: application/json" -d $params

exit
