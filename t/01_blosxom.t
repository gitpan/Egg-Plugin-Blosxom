
use Test::More qw/no_plan/;
use Egg::Helper;

eval "use ModBlosxom";

SKIP: {
	skip q{ ModBlosxom required for testing blosxom } if $@;

	my $test = Egg::Helper->run('O:Test');

	skip q{ Not Unix. } unless $test->is_unix;

	my $proot= $test->create_project_root;
	my $files= $test->yaml_load( join '', <DATA> );
	$test->prepare(
	  controller=> { egg=> [qw/-Debug Blosxom/] },
	  create_files=> [$files],
	  );
	$test->create_dir($_) for (
	  "$proot/htdocs/blog/ModBlosxom/plugin",
	  "$proot/htdocs/blog/plugins",
	  "$proot/htdocs/blog/plugins/states",
	  );

	$ENV{PATH_INFO}= '/blog';

	my $e= $test->egg_virtual;  $e->prepare_component;

	$e->debug_report_output;

	ok my $cache= $test->catch_stdout
	   ( sub { $e->blosxom('blog')->execute } );

	like $$cache, qr{\b[Cc]ontent-[Tt]ype: text/html\;?};
	like $$cache, qr{<html.*?>.+?</html>}s;
	like $$cache, qr{<title>.+?</title>}s;
	like $$cache, qr{<h1>.+?</h1>}s;
	like $$cache, qr{<a href=\"http\://www.blosxom.com/\">}s;
  };

__DATA__
---
filename: lib/<# project_name #>/Blosxom/Blog.pm
value: |
  package <# project_name #>::Blosxom::Blog;
  use strict;
  use warnings;
  use base qw/ Egg::App::Blosxom /;
  my $basedir= '<# project_root #>/htdocs/blog';
  __PACKAGE__->config(
    blog_title          => '<# project_name #>',
    blog_description    => 'Egg::App::Blosxom v'. Egg::App::Blosxom->VERSION,
    basedir             => "$basedir",
    datadir             => "$basedir/entries",
    url                 => 'http://127.0.0.1/blog',
    depth               => 0,
    num_entries         => 15,
    file_extension      => 'txt',
    default_flavour     => 'html',
    show_future_entries => 0,
    plugin_dir          => "$basedir/ModBlosxom/plugin",
    blosxom_plugin_dir  => "$basedir/plugins",
    plugin_state_dir    => "$basedir/plugins/states",
    );
  
  1;
