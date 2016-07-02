#!/bin/bash

PVRESIZE='/sbin/pvresize'
LVRESIZE='/sbin/lvresize -rl +100%FREE'
GROW_FS='/sbin/xfs_growfs'
PHYSICAL_VOLUME=' /dev/vda2'
LOGICAL_VOLUME='/dev/vg0/root'

$PVRESIZE $PHYSICAL_VOLUME

$LVRESIZE $LOGICAL_VOLUME

$GROW_FS /
