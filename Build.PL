use Module::Build;

my $builder = Module::Build->new(

  module_name       => 'Egg::Plugin::Blosxom',
  dist_version_from => 'lib/Egg/Plugin/Blosxom.pm',
  dist_author       => 'Masatoshi Mizuno E<lt>lusheE<64>cpan.orgE<gt>',
  license           => 'perl',

  requires => {
    'Egg::Release'         => 1.2001,
    'Jcode'                => 0,
    'HTTP::Request::Common'=> 0,
    'LWP::Simple'          => 0,
    'LWP::UserAgent'       => 0,
    'Text::Tags'           => 0.04,
    'List::Uniq'           => 0.10,
    'Text::Hatena'         => 0.20,
    'Test::More'           => 0,
    'Test::Pod'            => 0,
    'Test::Perl::Critic'   => 0,
    'Test::Pod::Coverage'  => 0,
    },

  );

$builder->create_build_script();
