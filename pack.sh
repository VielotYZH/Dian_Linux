#!/bin/bash
# Copyright (C) 2021 Pengyu Liu (SeedClass 2018)

os_name=${1:-lpyos}
cd $os_name
find . | cpio -H newc -o | xz -9 --check=crc32 > ../initrd.img
cd -
