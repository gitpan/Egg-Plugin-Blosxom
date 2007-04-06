package ExampleProject;
#
# Copyright (C) Bee Flag, Corp, All Rights Reserved.
# Masatoshi Mizuno E<lt>lusheE<64>cpan.orgE<gt>
#
# $Id$
#
use strict;
use warnings;
use Egg qw/ -Debug Blosxom /;
use ExampleProject::config;

our $VERSION= '0.01';

# __PACKAGE__->__warning_setup();
__PACKAGE__->__egg_setup( ExampleProject::config->out );

1;

__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

ExampleProject - Perl extension for ...

=head1 SYNOPSIS

  use ExampleProject;
  
  ... tansu, ni, gon, gon.

=head1 DESCRIPTION

Stub documentation for ExampleProject, created by Egg::Helper::Project::Build v0.10

Blah blah blah.

=head1 SEE ALSO

L<Egg::Release>,

=head1 AUTHOR

Masatoshi Mizuno E<lt>lusheE<64>cpan.orgE<gt>

=head1 COPYRIGHT

Copyright (C) 2007 by Bee Flag, Corp. E<lt>L<http://egg.bomcity.com/>E<gt>, All Rights Reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.

=cut

