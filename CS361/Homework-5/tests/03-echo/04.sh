#!/bin/bash

PORT=$@

REQUEST=$'GET /echo HTTP/1.1\r
Host: localhost:9999\r
Connection: keep-alive\r
sec-ch-ua: "Not?A_Brand";v="8", "Chromium";v="108", "Google Chrome";v="108"\r
sec-ch-ua-mobile: ?0\r
sec-ch-ua-platform: "Linux"\r
DNT: 1\r
Upgrade-Insecure-Requests: 1\r
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36\r
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9\r
Sec-Fetch-Site: none\r
Sec-Fetch-Mode: navigate\r
Sec-Fetch-User: ?1\r
Sec-Fetch-Dest: document\r
Accept-Encoding: gzip, deflate, br\r
Accept-Language: en-US,en;q=0.9,pt;q=0.8\r
Cookie: _ga=GA1.1.149590090.1676066969\r\n\r\n'

printf "$REQUEST" | nc -N 127.0.0.1 $PORT
