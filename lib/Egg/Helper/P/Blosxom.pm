package Egg::Helper::P::Blosxom;
#
# Copyright 2007 Bee Flag, Corp. All Rights Reserved.
# Masatoshi Mizuno E<lt>lusheE<64>cpan.orgE<gt>
#
# $Id: Blosxom.pm 91 2007-04-06 16:40:12Z lushe $
#
use strict;
use warnings;
use base qw/Egg::Component/;
use Egg::App::Blosxom;

our $VERSION = '0.01';

sub new {
	my $self= shift->SUPER::new();
	my $g= $self->global;
	return $self->help_disp if ($g->{help} || ! $g->{any_name});

	$g->{any_name}=~/\:/
	   and Egg::Error->throw(q/It is a package name of an illegal format./);
	my $part= $self->check_module_name
	   ($g->{any_name}, $self->project_name, 'Blosxom');

	$self->setup_global_rc;
	$self->setup_document_code;
	$g->{created}   = __PACKAGE__. " v$VERSION";
	$g->{lib_dir}   = "$g->{project_root}/lib";
	$g->{in_name}   = lc($g->{any_name});
	$g->{blog_name} = join('-' , @$part);
	$g->{blog_distname}   = join('::', @$part);
	$g->{blog_filename}   = join('/' , @$part). '.pm';
	$g->{blog_namespace}  = join('_' , @{$part}[2..$#{$part}]);
	$g->{blog_new_version}= 0.01;
	$g->{blosxom_app_version}= Egg::App::Blosxom->VERSION;

	-e "$g->{lib_dir}/$g->{blog_filename}"
	  and die "It already exists : $g->{lib_dir}/$g->{blog_filename}";

	$g->{number}= $self->get_testfile_new_number("$g->{project_root}/t")
	    || die 'The number of test file cannot be acquired.';

	$self->{add_info}= "";
	chdir($g->{project_root});
	eval {
		my @list= $self->parse_yaml(join '', <DATA>);
		$self->save_file($g, $_) for @list;

		$self->create_dir($_) for (
		  "$g->{project_root}/lib/ModBlosxom/plugin",
		  );

##		$self->distclean_execute_make;
	  };
	chdir($g->{start_dir});

	if (my $err= $@) {
		unlink("$g->{lib_dir}/$g->{blog_filename}");
		die $err;
	} else {
		print <<END_OF_INFO;
... done.$self->{add_info}

Please edit dispatch and Controller.

* $g->{project_root}/lib/$g->{project_name}.pm

  use Egg qw/ Blosxom /;

* $g->{project_root}/lib/$g->{project_name}/D.pm

  __PACKAGE__->run_modes(
    ...
    
    );
  
  sub blosxom_$g->{in_name} {
    my(\$self, \$e)= \@_;
    \$e->blosxom('$g->{in_name}')->execute;
  }

* See also example : $g->{project_root}/etc/blosxom/*.example

  Good luck !!

END_OF_INFO
	}
}
sub output_manifest {
	my($self)= @_;
	$self->{add_info}= <<END_OF_INFO;

----------------------------------------------------------------
  !! MANIFEST was not able to be adjusted. !!
  !! Sorry to trouble you, but please edit MANIFEST later !!
----------------------------------------------------------------
END_OF_INFO
}
sub help_disp {
	my($self)= @_;
	my $pname= lc($self->project_name);
	print <<END_OF_HELP;
# usage: perl $pname\_helper.pl P:Blosxom [NEW_BLOG_NAME]

END_OF_HELP
}

1;

=head1 NAME

Egg::Helper::P::Blosxom - blosxom like Blog system base module is generated for Egg::Helper.

=head1 SYNOPSIS

  cd /path/to/myproject/bin

  # Help is displayed.
  perl ./myproject_helper.pl P:Blosxom -h
  
  # A new dispatch module is generated.
  perl ./myproject_helper.pl P:Blosxom NewBlog

=head1 DESCRIPTION

=over 4

=item METHODS... new, help_disp, output_manifest,

=back

=head1 SEE ALSO

L<Egg::Plugin::Blosxom>
L<Egg::Helper>,
L<Egg::Release>,

=head1 AUTHOR

Masatoshi Mizuno, E<lt>lusheE<64>cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 Bee Flag, Corp. E<lt>L<http://egg.bomcity.com/>E<gt>, All Rights Reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.

=cut

__DATA__
---
filename: lib/<# blog_filename #>
value: |
  package <# blog_distname #>;
  #
  # Copyright (C) <# headcopy #>, All Rights Reserved.
  # <# author #>
  #
  # <# revision #>
  #
  use strict;
  use warnings;
  use base qw/ Egg::App::Blosxom /;
  
  our $VERSION= '<# blog_new_version #>';
  
  my $basedir= '<# project_root #>/htdocs/<# in_name #>';
  
  __PACKAGE__->config(
  
    blog_title          => '<# project_name #>',
    blog_description    => 'Egg::App::Blosxom v<# blosxom_app_version #>',
    basedir             => "$basedir",
    datadir             => "$basedir/entries",
    url                 => 'http://mydomain.name/<# in_name #>',
    depth               => 0,
    num_entries         => 15,
    file_extension      => 'txt',
    show_future_entries => 0,
    default_flavour     => 'html',
    flavour_alias       => { edit => 'wikieditish' },
  
    plugin_dir          => "<# project_root #>/lib/ModBlosxom/plugin",
    blosxom_plugin_dir  => "$basedir/plugins",
    plugin_state_dir    => "$basedir/plugins/states",
    spam_keywords       => [],
  
    entries_index_datafile => "$basedir/plugins/states/entries_index.dat",
    css_paths              => [qw{ /<# in_name #>/style-sites.css }],
    archives_monthname     => [qw{ 1月 2月 3月 4月 5月 6月 7月 8月 9月 10月 11月 12月 }],
    entry_title_title_sep  => '::',
  
    categories_story_count_commulative => 1,
    categories_output_format           => 'ul',
    categories_root_name               => "全てのエントリー",
    categories_aliases                 => { test => 'てすと' },
    categories_sep                     => '::',
  
    writeback_dir                     => "$basedir/plugins/states/writebacks",
    writeback_file_extension          => "wb",
    writeback_fields                  => [qw(title name blog_name url comment excerpt)],
    writeback_block_invalid_header_cm => 0,
    writeback_block_invalid_header_tb => 0,
    writeback_block_ascii_only        => 1,
    writeback_conv_charset            => 0,
    writeback_charset                 => 'utf8',
  
    wikieditish_preserve_lastmodified => 0,
    wikieditish_require_password      => 1,
    wikieditish_blog_password         => "XXXXX",
    wikieditish_restrict_by_ip        => 0,
    wikieditish_ips                   => [qw(127.0.0.1 192.168.0.1)],
    wikieditish_file_extension        => 'txt',
  
    );
  
  1;
  
  __DATA__
  
---
filename: etc/blosxom/<# in_name #>_dispatch.example
value: |
  package <# project_name #>::D;
  use strict;
  use warnings;
  
  __PACKAGE__->run_modes(
    ...
    <# in_name #> => \&blosxom_<# in_name #>,
    );
  
  sub blosxom_<# in_name #> {
    my($self, $e)= @_;
    $self->blosxom('<# in_name #>')->execute;
  }
  
  1;
---
filename: etc/blosxom/<# in_name #>_rewrite.example
value: |
  
  * A case of lighttpd.
  
  $HTTP["host"] == "website.domain.name" {
    server.document-root = "<# project_name #>/htdocs"
    url.rewrite-once = (
      "^/(<# in_name #>/.+?\.)(css|js|icon|gif|png|jpe?g)" => "/$1$2",
      "^/(<# in_name #>/entries/.*?\.html)(\#.*)?"         => "/$1$2",
      "^/(<# in_name #>/.*)"     => "/dispatch.fcgi/$1",
      "^/([^\.]+)?([\?\#].*)?$"  => "/dispatch.fcgi/$1$2$3",
      )
    ...
    ....
    ..... Establishment of FCGI.
    }
  
  
  * A case of mod_perl2
  
  <VirtualHost 192.168.0.1:80>
    DocumentRoot  <# project_name #>/htdocs
    ServerName    website.domain.name
    PerlModule    mod_perl2
    PerlModule    <# project_name #>
  
    <LocationMatch "^/<# in_name #>/.+?\.(css|js|icon|gif|png|jpe?g)">
    </LocationMatch>
  
    <LocationMatch "^/<# in_name #>/entries/.*?\.html">
    </LocationMatch>
  
    <LocationMatch "^/<# in_name #>">
      SetHandler          perl-script
      PerlResponseHandler <# project_name #>
    </LocationMatch>
  
    <LocationMatch "^[^\.]+$">
      SetHandler          perl-script
      PerlResponseHandler <# project_name #>
    </LocationMatch>
  
  </VirtualHost>
  
---
filename: t/<# number #>_<# blog_name #>.t
value: |
  
  use strict;
  use Test::More tests => 1;
  BEGIN { use_ok('<# blog_distname #>') };
  
