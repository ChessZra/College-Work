#!/bin/bash

# request is malformed and should get 400

PORT=$@


REQUEST=$'GET /echo HTTP/1.1\r
Header1: Value1\r
Header2: Value2\r
Header3: Value3\r
Header4: Value4\r
Header5: Valu'


printf "$REQUEST" | nc -N 127.0.0.1 $PORT 2>/dev/null
