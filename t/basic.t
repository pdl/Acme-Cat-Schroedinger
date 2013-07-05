#!perl
use strict;
use warnings;
use Test::More;
use Acme::Cat::Schroedinger;

sub kitty {
	Acme::Cat::Schroedinger->new(@_);
}

my $cat = kitty;

ok (!ref (kitty.''), "Stringification works");

ok (ref ($cat), 'Cat is an object');

my $nvm = $cat.'dog';
ok (!ref ($cat), "stringification modifies the cat");

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
