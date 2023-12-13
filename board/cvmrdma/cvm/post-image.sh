#!/usr/bin/env bash
set -xu

BOARD_DIR="$(dirname $0)"

support/scripts/genimage.sh -c ${BOARD_DIR}/genimage.cfg || exit

qemu-img convert -O qcow2 ${BINARIES_DIR}/disk.img ${BINARIES_DIR}/disk.qcow2

exit $?