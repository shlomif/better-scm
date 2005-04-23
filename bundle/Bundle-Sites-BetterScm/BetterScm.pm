package Bundle::Sites::BetterScm;

$VERSION = '0.2.0';

1;

__END__

=head1 NAME

Bundle::Sites::BetterScm - A bundle to install external CPAN modules used by 
the Better-SCM site

=head1 SYNOPSIS

Perl one liner using CPAN.pm:

  perl -MCPAN -e 'install Bundle::Sites::BetterScm'

Use of CPAN.pm in interactive mode:

  $> perl -MCPAN -e shell
  cpan> install Bundle::Sites::BetterScm
  cpan> quit

Just like the manual installation of perl modules, the user may
need root access during this process to insure write permission 
is allowed within the intstallation directory.


=head1 CONTENTS

CGI

Class::Accessor

Data::Dumper

File::Basename

File::Find::Rule

HTML::Widgets::NavMenu

Template

XML::CompareML

=head1 DESCRIPTION

This bundle installs modules needed by the Better SCM site:

L<http://better-scm.berlios.de/source/>

=head1 AUTHOR

Shlomi Fish E<lt>F<shlomif@iglu.org.il>E<gt>

=cut
