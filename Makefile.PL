use strict;
use warnings;
use ExtUtils::MakeMaker 6.62;

WriteMakefile(
    NAME             => 'Parse::RecDescent',
    AUTHOR           => [
        'Damian Conway <DCONWAY@CPAN.org>',
        'Jeremy T. Braun <JTBRAUN@CPAN.org>',
    ],
    VERSION_FROM     => 'lib/Parse/RecDescent.pm',
    ABSTRACT_FROM    => 'lib/Parse/RecDescent.pm',
    PL_FILES         => {},
    BUILD_REQUIRES   => {
        'ExtUtils::MakeMaker' => 6.5702,
    },
    CONFIGURE_REQUIRES   => {
        'ExtUtils::MakeMaker' => 6.5702,
    },
    PREREQ_PM        => {
        'Text::Balanced' => 1.95,
        'Test::More'     => 0,
    },
    dist             => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean            => { FILES => 'Parse-RecDescent-* RD_TRACE' },
);
