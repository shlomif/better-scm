#!/bin/sh

RSYNC="rsync --progress --verbose --rsh=ssh -r"

make
cd /var/www/html/better-scm
echo "Uploading to Berlios"
echo
# scp * shlomif@shell.berlios.de:/home/groups/fc-solve/htdocs/
$RSYNC * shlomif@shell.berlios.de:/home/groups/better-scm/htdocs/

