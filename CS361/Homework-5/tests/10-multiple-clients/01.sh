#!/bin/bash
#
rm -f read expected

PORT=$@

# Create 5K file
LARGE_RANDOM_DATA=`dd if=/dev/urandom count=10 bs=1M 2>/dev/null | base64 >file`
SMALL_RANDOM_DATA=`dd if=/dev/urandom count=2 bs=1k 2>/dev/null | base64 >file2`

# Start a big download, limited to 1M

curl --limit-rate 1M -s http://127.0.0.1:$PORT/file >/dev/null &
curl --limit-rate 1M -s http://127.0.0.1:$PORT/file >actual1 &
curl --limit-rate 1M -s http://127.0.0.1:$PORT/file >/dev/null &
curl --limit-rate 1M -s http://127.0.0.1:$PORT/file >/dev/null &
curl --limit-rate 1M -s http://127.0.0.1:$PORT/file >/dev/null &
curl --limit-rate 1M -s http://127.0.0.1:$PORT/file >/dev/null &

sleep 1

# Start a small download, as fast as possible
START=$(date +%s%N | cut -b1-13 | sed s/N/000/g)
curl -s http://127.0.0.1:$PORT/file2 2>/dev/null >actual6
END=$(date +%s%N | cut -b1-13 | sed s/N/000/g)

# Wait for all transfers to end
wait

# Make sure downloaded correctly every time
if ! diff file2 actual6 ; then
    exit 1
fi

if ! diff file actual1 ; then
    exit 1
fi

# Small download should have taken less than 1 second
if [ $((END-START)) -gt "1000" ]; then
    printf "Finished in $((END-START))ms\n"
    printf "Should have taken less than 1 sec (1000ms)\n"
    exit 1
fi
exit 0
