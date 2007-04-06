package Egg::Plugin::Blosxom;
#
# Copyright (C) 2007 Bee Flag, Corp, All Rights Reserved.
# Masatoshi Mizuno E<lt>lusheE<64>cpan.orgE<gt>
#
# $Id: Blosxom.pm 91 2007-04-06 16:40:12Z lushe $
#
use strict;
use warnings;
use UNIVERSAL::require;

our $VERSION = '0.01';

sub setup {
	my($e)= @_;
	my $basename= $e->namespace. '::Blosxom';
	my $libdir  = $e->path('lib', "/Blosxom");
	for (<$libdir/*>) {  ## no critic
		m{([^/]+)\.pm$} || next;
		my $name= $1;
		my $b_class= "$basename\::$name";
		$b_class->require or Egg::Error->throw($@);
		$b_class->_setup($e);
		$e->global->{"EGG_BLOSXOM_". uc($name)}= $b_class;
	}
	$e->next::method;
}
sub blosxom {
	my $e= shift;
	my $name= uc(shift) || Egg::Error->throw('I want Blog name.');
	$e->{"EGG_BLOSXOM_$name"} ||= do {
		my $b_class= $e->global->{"EGG_BLOSXOM_$name"}
		   || Egg::Error->throw(qq{ '$name' blosxom is not found. });
		$b_class->new($e);
	  };
}

1;

__END__

=head1 NAME

Egg::Plugin::Blosxom - Plugin to use ModBlosxom for Egg.

=head1 SYNOPSIS

Controller.

  package MYPROJECT;
  use strict;
  use Egg qw/ Blosxom /;

Dispatch.

  __PACKAGE__->run_modes(
    .....
    ..
    blog => \&blosxom_blog,
    );
  
  sub blosxom_blog {
    my($self, $e)= @_;
    $e->blosxom('blog')->execute;
  }

=head1 DESCRIPTION

ModBlosxom to modulate 'blosxom' is used. 
Moreover, the plugin module also uses the one for ModBlosxom.

Please obtain 'ModBlosxom' from the following distribution site.

http://www.donzoko.net/cgi-bin/blosxom/blosxom.cgi
http://trac.33rpm.jp/browser

Please refer to the following site for blosxom for basic information.

http://www.blosxom.com/
http://blosxom.info/

Flavor is necessary.
It might be good to obtain 'blosxom starter kit'.

http://hail2u.net/archives/bsk.html

* When execute is called, all operation is left to ModBlosxom about behavior.
  $e-E<gt>finished is set after modblosxom-E<gt>run.

=head1 SETUP

1. The Blosxom base module is generated with the helper of the project.

  cd /path/to/MYPROJECT/bin
  
  perl myproject_helper.pl P:Blosxom Blog

2. Obtained ModBlosxom and plug-in are set up under the control of
  '/path/to/MYPROJECT/lib'.

3. Controller and edit of dispatch.

4. Arrangement of Flavor and setting of write enable.

5. Confirmation and correction of Blosxom configuration.

6. Setting and reactivation of WEB server.

7. Operation is confirmed by a browser.

* The setup might be a little confusing.

* In addition, please refer to the SETUP file under the control of/eg and the
  directory structure of the sample project for details.

=head1 METHODS

=head2 blosxom ([BLOG_NAME])

The specified ModBlosxom context is returned.

=head2 setup

It is a method that calls from Egg by the automatic operation. The start 
preparation is done.

=head1 SEE ALSO

L<http://www.blosxom.com/>
L<http://www.donzoko.net/cgi-bin/blosxom/blosxom.cgi>
L<http://trac.33rpm.jp/browser>
L<http://hail2u.net/archives/bsk.html>
L<http://blosxom.info/>
L<Egg::Release>,

=head1 AUTHOR

Masatoshi Mizuno E<lt>lusheE<64>cpan.orgE<gt>

=head1 COPYRIGHT

Copyright (C) 2007 by Bee Flag, Corp. E<lt>L<http://egg.bomcity.com/>E<gt>, All Rights Reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.

=cut

