#!/bin/bash
file="include.mak"

(
    echo "IMAGES_PRE1 = " $(cd src && find . -regex '.*\.\(tar\.gz\|zip\|patch\|css\|ng\|html\|txt\)' | grep -v '/\.svn' | grep -v '^\.svn' | sed 's!^./!!')
) > "$file"
