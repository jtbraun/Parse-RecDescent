#!/opt/perl/bin/perl 
use strict;
use warnings;
use Parse::RecDescent;
use Test::More tests => 4;

my $grammar = <<'END_OF_GRAMMAR';
    foo:             item(s) eotext { $return = $item[1] }
    foo_with_skip:   <skip: qr/(?mxs: \s+ |\# .*?$)*/>
                     item(s) eotext { $return = $item[1] }
    item:            name value { [ @item[1,2] ] }
    name:            'whatever' | 'another'
    value:           /\S+/
    eotext:          /\s*\z/
END_OF_GRAMMAR

my $text = <<'END_OF_TEXT';
whatever value

# some spaces, newlines and a comment too!

another value

END_OF_TEXT

local $Parse::RecDescent::skip = qr/(?mxs: \s+ |\# .*?$)*/;
my $parser = Parse::RecDescent->new($grammar);
ok($parser, 'got a parser');

my $inskip = $parser->foo_with_skip($text);
ok($inskip, 'foo_with_skip()');

{
   my $outskip = $parser->foo($text);
   ok($outskip, 'foo() with regex $P::RD::skip');
}

{
   my $outskip = $parser->foo($text);
   ok($outskip, 'foo() with string $P::RD::skip');
}
