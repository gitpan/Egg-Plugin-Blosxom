package EggRelease::Blosxom::Blog;
#
# Copyright (C) Bee Flag, Corp, All Rights Reserved.
# Masatoshi Mizuno E<lt>lusheE<64>cpan.orgE<gt>
#
# $Id$
#
use strict;
use warnings;
use base qw/ Egg::App::Blosxom /;

our $VERSION= '0.01';

my $basedir= '/path/to/Egg-Plugin-Blosxom/eg/ExampleProject/htdocs/blog';

__PACKAGE__->config(

  blog_title          => 'EggRelease',
  blog_description    => 'Egg::App::Blosxom v',
  basedir             => "$basedir",
  datadir             => "$basedir/entries",
  url                 => 'http://trac2.bomcity.com/blog',
  depth               => 0,
  num_entries         => 15,
  file_extension      => 'txt',
  default_flavour     => 'html',
  show_future_entries => 0,
  flavour_alias       => { edit => 'wikieditish' },

  plugin_dir          => "/path/to/Egg-Plugin-Blosxom/eg/ExampleProject/lib/ModBlosxom/plugin",
  blosxom_plugin_dir  => "$basedir/plugins",
  plugin_state_dir    => "$basedir/plugins/states",
  spam_keywords       => [],

  entries_index_datafile => "$basedir/plugins/states/entries_index.dat",
  css_paths              => [qw{ /blog/style-sites.css }],
  archives_monthname     => [qw{  }],
  entry_title_title_sep  => '::',

  categories_story_count_commulative => 1,
  categories_output_format           => 'ul',
  categories_root_name               => "All Entries",
  categories_aliases                 => { },
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
