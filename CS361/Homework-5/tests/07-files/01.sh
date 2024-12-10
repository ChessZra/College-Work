#!/bin/bash

PORT=$@

REQUEST=$'GET /tests/07-files/index.html HTTP/1.1\r\n\r\n'

printf "$REQUEST" | nc -N 127.0.0.1 $PORT
