package ExampleProject::config;
#
# $Id$
#
use strict;

my $C= {

# Project Title.
title=> 'ExampleProject',

# Project root directory. (Absolutely path only)
root => '/path/to/Egg-Plugin-Blosxom/eg/ExampleProject',

# Directory configuration.
#  static    => 'htdocs',
#  static_uri=> '/',

# Character code for processing.
#  character_in         => 'euc',  # euc or sjis or utf8
#  disable_encode_query => 0,

# Template.
#  template_default_name=> 'index',
#  template_extension=> '.tt',
template_path=> [qw( /path/to/Egg-Plugin-Blosxom/eg/ExampleProject/root /path/to/Egg-Plugin-Blosxom/eg/ExampleProject/comp )],

# Default content type and language.
#  content_type    => 'text/html; charset=euc-jp',
#  content_language=> 'ja',

# Upper bound of request directory hierarchy.
#  max_snip_deep=> 5,

# Accessor to stash. * Do not overwrite a regular method.
#  accessor_names=> [qw/hoge/],

# Cookie default setup.
#  cookie => {
#    domain  => 'mydomain',
#    path    => '/',
#    expires => 0,
#    secure  => 0,
#    },

# Model configuration.
#  MODEL=> [
#    [ DBI => {
#          dsn=> 'dbi:[DBD]:dbname=[DB];host=localhost;port=5432',
#          user    => '[USERNAME]',
#          password=> '[PASSWORD]',
#          options => { AutoCommit=> 1, RaiseError=> 0 },
#        },
#      ],
#    ],

# View configuration.
  VIEW=> [
    [ Template => {
#
#   * Please refer to document of HTML::Template
#   http://search.cpan.org/dist/HTML-Template/
#
        path=> [
          '/path/to/Egg-Plugin-Blosxom/eg/ExampleProject/root',
          '/path/to/Egg-Plugin-Blosxom/eg/ExampleProject/comp',
          ],
        global_vars=> 1,
        die_on_bad_params=> 0,
      # cache=> 1,
        },
      ],
#   [ Mason => {
#
#   * Please refer to document of HTML::Mason.
#   http://search.cpan.org/dist/HTML::Mason/
#   http://www.masonhq.com/
#
#       comp_root=> [
#         [ main   => '/path/to/Egg-Plugin-Blosxom/eg/ExampleProject/root' ],
#         [ private=> '/path/to/Egg-Plugin-Blosxom/eg/ExampleProject/comp' ],
#         ],
#        data_dir=> '/path/to/Egg-Plugin-Blosxom/eg/ExampleProject/tmp',
#       },
#     ],
    ],

#  * For ErrorDocument plugin.
#  plugin_error_document=> {
#    template_name=> 'error/document.tt',
#    },

  };
sub out { $C }

1;
