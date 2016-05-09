#!/bin/bash
#
# find random hosts with an open port
# and dump the banner
#
# requires /dev/tcp support
#
# only dependency is a bash shell
#
# usage:
#    $ PORT=22 ./$0
#

PORT=${PORT:-80}

# get a random valid octet
_oct() {
    _n=$RANDOM; let "_n %= 256"
    [ $_n -eq 127 ] && _oct; [ $_n -eq 172 ] && _oct; [ $_n -eq 192 ] && _oct; [ $_n -eq 10  ] && _oct
}

# get four octets to create a random valid ip address
_gen() {
    _oct;_1=$_n;_oct;_2=$_n;_oct;_3=$_n;_oct;_4=$_n
    _h="$_1.$_2.$_3.$_4"
}

# sigalarm
_alm() {
    _t=$1; shift;
    bash -c "$@" &
    _p=$!
    {
      sleep $_t
      kill $_p 2> /dev/null
    } &
    wait $_p 2> /dev/null
    return $?
}

# grab the banner
_pop() {
    echo "$_h:${PORT}"
    _alm 1 "exec 3<>/dev/tcp/${_h}/${PORT};echo -e \"HEAD / HTTP/1.0\r\n\r\n\" >&3;cat <&3"
}

# main loop
while [ true ]
do
    _gen
    _alm .5 "(>/dev/tcp/${_h}/${PORT}) 2>/dev/null" && _pop

done

