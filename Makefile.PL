use inc::Module::Install;

name         'Egg-Plugin-Blosxom';
all_from     'lib/Egg/Plugin/Blosxom.pm';
version_from 'lib/Egg/Plugin/Blosxom.pm';
author       'Masatoshi Mizuno E<lt>lusheE<64>cpan.orgE<gt>';
license      'perl';

requires 'Egg::Release' => 1.2001;
requires 'Jcode';
requires 'HTTP::Request::Common';
requires 'LWP::Simple';
requires 'LWP::UserAgent';
requires 'Text::Tags'   => 0.04;
requires 'List::Uniq'   => 0.10;
requires 'Text::Hatena' => 0.20;

build_requires 'Test::More';
build_requires 'Test::Pod';
build_requires 'Test::Perl::Critic';
build_requires 'Test::Pod::Coverage';

use_test_base;
auto_include;
WriteAll;
