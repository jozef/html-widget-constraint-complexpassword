#!/usr/bin/perl

use strict;
use warnings;

use Test::More;# 'no_plan';
BEGIN { plan tests => 6 };

BEGIN {
	use_ok ( 'HTML::Widget::Constraint::ComplexPassword', qw{
		$MIN_LENGTH
		$SPECIAL_CHARACTERS
	}) or exit;
}

is($MIN_LENGTH, 8, 'check minlength changes')
	or diag('update the pods if this default value changes.');
is($SPECIAL_CHARACTERS, '/[]=+-*(){}% ^&.;:|~?!#$\'"<>\\A', 'check special characters changes')
	or diag('update the pods if this default value changes.');

my $constraint = HTML::Widget::Constraint::ComplexPassword->new();
isa_ok($constraint, 'HTML::Widget::Constraint') or exit;
isa_ok($constraint, 'HTML::Widget::Constraint::ComplexPassword') or exit;
can_ok($constraint, 'validate');





