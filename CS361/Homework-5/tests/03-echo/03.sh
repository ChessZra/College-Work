#!/bin/bash

PORT=$@

curl -s --user-agent "curl/XXX" http://127.0.0.1:$PORT/echo | sed s/$PORT/XXXXX/g
