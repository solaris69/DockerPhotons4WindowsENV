#!/bin/bash

regexChkIP=`echo "$2" | sed -r 's/[\.]/\\\./g'`
chkSecondIP=`ifconfig -a | grep "${regexChkIP}" | sed -E "s/.*inet addr:([^\s]*)\s\s+Bcast.*/\1/g"`

if [ "${chkSecondIP}" == "$2" ]; then
  echo "FOUND ==${chkSecondIP}== already assign"
else
mac=$1
IP_ADDRESS=$2
NETMASK=$3
eth_no=0
chkETH=`ifconfig -a | grep "${mac}"`
if [ "$chkETH" != "" ]; then
  eth_no=`ifconfig -a | grep "${mac}" | sed -E "s/^(ens[0-9][0-9]).*/\1/g"`
  echo "Get interface ${eth_no}"
  echo "Updating IP Address ..."
  cat > /etc/systemd/network/10-static-$eth_no.network << PHOTON_NET
[Match]
Name=$eth_no

[Network]
Address=${IP_ADDRESS}/${NETMASK}
#Gateway=${GATEWAY}
#DNS=${DNS}
#Domains=${HOSTNAME}
PHOTON_NET

  echo "Enabling ${eth_no} interface ..."
  ip link set $eth_no up
  echo "Enabling networking ..."
  systemctl restart systemd-networkd.service

chkSecondIP=`ifconfig -a | grep "${regexChkIP}" | sed -E "s/.*inet addr:([^\s]*)\s\s+Bcast.*/\1/g"`
  if [ "${chkSecondIP}" == "${IP_ADDRESS}" ]; then
    echo "FOUND ==${chkSecondIP}== Set STATIC IP successfully :)"
  else
    echo "Fail to configure static IP."
    exit 1
  fi
  
else
  echo "Can't find interface name match MAC-ADDR ${mac}"
  exit 1
fi
fi
