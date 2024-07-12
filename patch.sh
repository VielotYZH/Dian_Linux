#!/bin/bash
# Copyright (C) 2021 Pengyu Liu (SeedClass 2018)

os_name=${1:-lpyos}
feature=${2:-iwlwifi}

mkdir -p $os_name/lib/firmware/
cp -r rtl_nic $os_name/lib/firmware/
[ $feature == "iwlwifi" ] && cp iwlwifi/*.ucode $os_name/lib/firmware/

cat << EOF > $os_name/bin/ifup
#!/bin/bash

device=\${1:-eth0}

ip link set \$device up
EOF
chmod +x $os_name/bin/ifup

cat << EOF > $os_name/bin/ipsetup
#!/bin/bash

device=\${1:-eth0}
ipmask=\${2:-192.168.6.143/24}
gw=\${3:-192.168.6.2}

ip addr add \$ipmask dev \$device
ip route add default via \$gw
EOF
chmod +x $os_name/bin/ipsetup
