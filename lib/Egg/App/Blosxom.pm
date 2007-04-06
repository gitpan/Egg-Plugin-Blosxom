package Egg::App::Blosxom;
#
# Copyright (C) 2007 Bee Flag, Corp, All Rights Reserved.
# Masatoshi Mizuno E<lt>lusheE<64>cpan.orgE<gt>
#
# $Id: Blosxom.pm 91 2007-04-06 16:40:12Z lushe $
#
use strict;
use warnings;
use base qw/ModBlosxom Egg::Base/;

our $VERSION = '0.01';

sub _setup {
	my($class, $e)= @_;
	my $conf= $class->config;

	$conf->{$_} || Egg::Error->throw(qq{ I want setup blosxom '$_', })
	  for qw{ basedir datadir url plugin_state_dir };

	$conf->{$_} and $conf->{$_}=~s{/+$} [] for qw{
	  url basedir datadir plugin_dir blosxom_plugin_dir plugin_state_dir
	  writeback_dir
	  };

	$conf->{blosxom_uri}= $conf->{url}=~m{^https?\://[^/]+(/.+)} ? $1: "";
	$conf->{plugin_dir}       ||= "$conf->{basedir}/ModBlosxom/plugin";
	$conf->{plugin_state_dir} ||= "$conf->{basedir}/plugins/states";
	$conf->{file_extension}   ||= 'txt';  $conf->{file_extension}=~s{\.} []g;
	$conf->{default_flavour}  ||= 'html';
	$conf->{css_paths}        ||= ["$conf->{blosxom_uri}/style-sites.css"];
	$conf->{flavour_alias}    ||= {};
}
sub new {
	my($class, $e)= @_;
	my $blosxom= $class->SUPER::new;
	$blosxom->e($e);
	$blosxom;
}
sub execute {
	my($blosxom)= @_;
	$blosxom->settings( $blosxom->config );
	$blosxom->run;
	my $status;
	if ($status= $blosxom->{header}->{'-status'}) {
		($status)= $status=~m{^(\d+)};
	}
	$blosxom->e->finished($status || 200);
}
sub _split_path_info {
	my($b)= @_; my $conf= $b->config;
	my $blosxom_uri= $conf->{blosxom_uri} || "";
	my $path_info= $b->cgi->path_info() || $b->cgi->param('path') || '';
	$path_info=~s{^$blosxom_uri} [];
	$path_info=~s{([^\.]+)$} [($conf->{flavour_alias}{$1} || $1)]e;
	split m{/}, $path_info;
}

1;

__END__

=head1 NAME

Egg::App::Blosxom - Wrapper to make ModBlosxom available with Egg.

=head1 SYNOPSIS

  package MYPROJECT::Blosxom::Blog;
  use strict;
  use base qw/ Egg::App::Blosxom /;

=head1 DESCRIPTION

This module makes the thing called from Egg::Plugin::Blosxom assumption.

This module chiefly operates 'PATH_INFO' for Egg.

Please confirm the value of 'url' of the configuration without fail and correct
it to an appropriate content.

It corresponds to the alias of 'flavor'.
Please set 'Flavour_alias' suitably by the HASH reference.

=head1 METHODS

=head2 execute

'settings' it and 'run' are called to the ModBlosxom context.

Afterwards, the response status that ModBlosxom returned is set in $e-E<gt>finished.

=head1 SEE ALSO

L<http://www.blosxom.com/>
L<http://www.donzoko.net/cgi-bin/blosxom/blosxom.cgi>
L<http://trac.33rpm.jp/browser>
L<http://hail2u.net/archives/bsk.html>
L<http://blosxom.info/>
L<Egg::Plugin::Blosxom>
L<Egg::Plugin::Blosxom>
L<Egg::Helper::P::Blosxom>
L<Egg::Release>,

=head1 AUTHOR

Masatoshi Mizuno E<lt>lusheE<64>cpan.orgE<gt>

=head1 COPYRIGHT

Copyright (C) 2007 by Bee Flag, Corp. E<lt>L<http://egg.bomcity.com/>E<gt>, All Rights Reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.

=cut
