#!/bin/bash

COMMAND='/sbin/fdisk'
DEVICE='/dev/vda'

echo "d
2
n
p
2


t
2
8e
w
" | $COMMAND $DEVICE


