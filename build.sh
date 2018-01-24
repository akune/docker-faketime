#!/bin/bash
git clone https://github.com/wolfcw/libfaketime.git libfaketime
cd libfaketime; git pull; cd -
docker build . --squash -t faketime
docker images faketime
echo "Un-faked container date: "
docker run --rm -it faketime sh -c 'date'
echo "Faked absolute container date with ENV: "
docker run --rm -it faketime sh -c 'LD_PRELOAD=/usr/local/lib/faketime/libfaketime.so.1 FAKETIME="2000-01-01 00:00:00" date'
echo "Faked relative container date with file: "
docker run --rm -it faketime sh -c 'echo "-900d" > /etc/faketimerc; LD_PRELOAD=/usr/local/lib/faketime/libfaketime.so.1 date'
