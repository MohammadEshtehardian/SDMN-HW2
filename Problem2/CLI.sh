#!/bin/bash
chroot chroot-jail"$1"/ bash -c "chmod +x ./start.sh; ./start.sh; bash"