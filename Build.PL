use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Parse::RecDescent',
    license             => 'perl',
    dist_author         => [
        'Damian Conway <DCONWAY@CPAN.org>',
        'Jeremy T. Braun <JTBRAUN@CPAN.org>',
    ],
    dist_version_from   => 'lib/Parse/RecDescent.pm',
    requires => {
        'Text::Balanced' => 1.95,
        'Test::More'     => 0,
    },
    add_to_cleanup      => [ 'Parse-RecDescent-*' ],
);

$builder->create_build_script();
