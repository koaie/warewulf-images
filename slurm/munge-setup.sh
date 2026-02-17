#!/bin/bash

export MUNGEUSER=1001
groupadd -g $MUNGEUSER munge
useradd -m -c "MUNGE Uid 'N' Gid Emporium" -d /var/lib/munge \ 
    -u $MUNGEUSER -g munge -s /sbin/nologin munge

dnf -y update && dnf -y install --allowerasing munge
dnf clean all

chown -R munge: /etc/munge/ /var/log/munge/ /var/lib/munge/ /run/munge/
chmod 0700 /etc/munge/ /var/log/munge/ /var/lib/munge/
chmod 0711 /run/munge/