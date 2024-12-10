#!/bin/bash

PORT=$@

nc -z -v 127.0.0.1 $PORT 2>&1 | sed "s/${PORT}/XXX/g"
