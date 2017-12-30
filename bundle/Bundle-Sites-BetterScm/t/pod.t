use strict;
use warnings;

use Test::More;
eval { require Test::Pod; };
plan skip_all => "Test::Pod 1.14 required for testing POD" if $@;
Test::Pod::all_pod_files_ok();
