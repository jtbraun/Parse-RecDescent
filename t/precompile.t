use strict;
use warnings;
use Parse::RecDescent;
use Test::More tests => 7;

local $^W;

my $grammar = <<'EOGRAMMAR';
TOP: <leftop: element /,/ element>(s?) ';' { $item[1] }
element: 'punctuation' {
    $thisparser->Extend('element: /!/');
    $return = $item[1];
}
| /\w+/
EOGRAMMAR

my $class = 'TestParser';
my $pm_filename = $class . '.pm';

if (-e $pm_filename) {
    unlink $pm_filename;
}
ok(!-e $pm_filename, "no preexisting precompiled parser");

eval {
    Parse::RecDescent->Precompile($grammar,
                                  $class);
};
ok(!$@, 'created a precompiled parser: '. $@);
ok(-f $pm_filename, "found precompiled parser");

eval "use $class;";
ok(!$@, q{use'd a precompiled parser: }.$@);

unlink $pm_filename;
ok(!-e $pm_filename, "deleted precompiled parser");

my $result = eval qq{
    my \$text = "one, two, three, four,
punctuation, !, five, six, seven ;";

    use $class;
    my \$parser = $class->new();
    \$parser->TOP(\$text);
};
ok(!$@, 'ran a precompiled parser');
is_deeply($result,
          [qw(one two three four punctuation
              ! five six seven)],
          "correct result from precompiled parser");

