#!/bin/bash

docker run -p 127.0.0.1:9292:9292 --rm --name datarator datarator/datarator:edge &
sleep 1 # should be enough for server start
MSG="Hello"
CURL_RES=`curl -H "content-type: application/json" -X POST -d '{"template":"csv","document":"foo_document","count":"1","columns":[{"name":"greeting","type":"const", "options":{"value":"'$MSG'"}}]}' http://127.0.0.1:9292/api/schemas | grep $MSG`
docker kill datarator
[[ $CURL_RES == $MSG ]] || exit 1
