#!perl
use strict;
use warnings;
use Test::More;
use Acme::Cat::Schroedinger;
use Data::Dumper;

sub kitty {
	Acme::Cat::Schroedinger->new(@_);
}

my $cat = kitty;

ok (!ref (kitty.''), "Stringification works");

ok (ref ($cat), 'Cat is an object');

my $nvm = $cat.'dog';
ok (!ref ($cat), "stringification modifies the cat") or diag Dumper [$cat];

$cat = kitty;

eval {
	$nvm = $cat->[0];
};
if ($@) {
	fail ($@);
}
else {
	pass('Can call as arrayref');
	ok (!defined $nvm, 'empty arrayref');
}

eval {
	$nvm = ${&kitty};
};
if ($@) {
	fail ($@);
}
else {
	pass('Can call as scalar ref');
}

eval {
	$nvm = {%{&kitty}};
};
if ($@) {
	fail ($@);
}
else {
	pass('Can call as hash ref');
	ok (!keys %$nvm ,'empty hashref');
}

# write more tests!

done_testing;
