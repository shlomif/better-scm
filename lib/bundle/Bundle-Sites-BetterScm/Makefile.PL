use ExtUtils::MakeMaker;
WriteMakefile(
              NAME	   => 'Bundle::Sites::BetterScm',
              VERSION_FROM => 'BetterScm.pm',
              'dist'       => {
                               COMPRESS => 'gzip -9f',
                               SUFFIX   => '.gz',
                               DIST_DEFAULT => 'all tardist',
                              },
             );
