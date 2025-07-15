#!/bin/bash

set -x
set -o pipefail

export PATH="$PWD/bin/build-time-helpers:$PWD/node_modules/.bin/:$PATH:/usr/games"
export SKIP_SPELL_CHECK=1

m()
{
    gmake DBTOEPUB="/usr/bin/ruby $(which dbtoepub)" \
        DOCBOOK5_XSL_STYLESHEETS_PATH=/usr/share/xml/docbook/stylesheet/docbook-xsl-ns \
    "$@"
}

if ! ./gen-helpers | perl bin/filter-make.pl ; then
    echo "Error in executing ./gen-helpers.pl" 1>&2
    exit -1
fi

if ! m fastrender ; then
    echo "Error in executing make fastrender." 1>&2
    exit -1
fi

if ! m 2>&1 | perl bin/filter-make.pl ; then
    echo "Error in executing make." 1>&2
    exit -1
fi

if ! m test ; then
    echo "Error in executing make test." 1>&2
    exit -1
fi
