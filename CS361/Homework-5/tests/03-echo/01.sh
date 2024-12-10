#!/bin/bash

PORT=$@

REQUEST=$'GET /echo HTTP/1.1\r
Header1: Value1\r
Header2: Value2\r
Header3: Value3\r
Header4: Value4\r
Header5: Value5\r
Header6: Value6\r\n\r\n'

printf "$REQUEST" | nc -N 127.0.0.1 $PORT
