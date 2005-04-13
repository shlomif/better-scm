#!/bin/bash
file="include.mak"

(
    echo "IMAGES_PRE1 = " \
        $(cd src && 
            find . -regex '.*\.\(tar\.gz\|zip\|patch\|css\|html\|txt\|pl\|dtd\|xsl\|xml\|png\)' | 
            grep -v '/\.svn' | 
            grep -v '^\.svn' | 
            sed 's!^./!!'
         )
) > "$file"
