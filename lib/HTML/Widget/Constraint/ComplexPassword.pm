package HTML::Widget::Constraint::ComplexPassword;

=head1 NAME

HTML::Widget::Constraint::ComplexPassword - HTML::Widget form constraint that checks if the field is a complex password.

=head1 SYNOPSIS

	use HTML::Widget;
	
	my $widget = HTML::Widget->new('widget')->method('get')->action('/');
	
	...
	
	#constraints
	$widget->constraint(Length      => @columns)
		->min($HTML::Widget::Constraint::ComplexPassword::MIN_LENGTH)
		->message('Must be at least '.$HTML::Widget::Constraint::HP_Password::MIN_LENGTH.' characters long');
	$widget->constraint(HP_Password => @columns)
		->message('Must contain at least '.$HTML::Widget::Constraint::HP_Password::MIN_LENGTH.' and include one upper and one lower case character. Must contain at least one Special Character - "'
			.$HTML::Widget::Constraint::ComplexPassword::SPECIAL_CHARACTERS.'"');
	
	#or this will be enought but then the error text is too long
	$widget->constraint(HP_Password => @columns)
		->message('Must be at lease Must contain at least one upper and one lower case character. Must contain at least one Special Character - "'
			.$HTML::Widget::Constraint::ComplexPassword::SPECIAL_CHARACTERS.'"');

=head1 DESCRIPTION

A constraint for L<HTML::Widget> to check if the password is complex enought. Password must have
at least MIN_LENGTH characters count, one lower case character is required, one upper case character
is required and either number or one of SPECIAL_CHARACTERS is needed.

=head1 EXPORTS 

	our $MIN_LENGTH = 8;
	our $SPECIAL_CHARACTERS = '/[]=+-*(){}% ^&.;:|~?!#$';

=head2 TIPS

If you want to force different password lenght then do:

	use HTML::Widget::Constraint::ComplexPassword;
	$HTML::Widget::Constraint::HP_Password::MIN_LENGTH = 10;

If you need just numbers and no other special characters then remove characters from the
SPECIAL_CHARACTERS list:

	use HTML::Widget::Constraint::ComplexPassword;
	$HTML::Widget::Constraint::ComplexPassword::SPECIAL_CHARACTERS = '';

=cut

use warnings;
use strict;
use base 'HTML::Widget::Constraint';

our $VERSION = '0.01';

use Exporter 'import';
our @EXPORT_OK    = qw(
	$MIN_LENGTH
	$SPECIAL_CHARACTERS
);

our $MIN_LENGTH = 8;
our $SPECIAL_CHARACTERS = '/[]=+-*(){}% ^&.;:|~?!#$\'"<>\\A';

sub validate {
    my $self  = shift;
    my $value = shift;

    return 0 if not defined $value;

	#must have some length
    return 0 if length($value) < $MIN_LENGTH;
	
	#must have one upper case character
	return 0 if not $value =~ m{[A-Z]};

	#must have one lower case character
	return 0 if not $value =~ m{[a-z]};

	#must have one special character or number
	my $char;
	while ($char = chop($value)) {
		last if (index($SPECIAL_CHARACTERS, $char) != -1);
	}
	return 0 if (
		($char ne '')              #special char
		and
		($value !~ m{[0-9]})       #number
	);

    return 1;
}


__END__

=head1 SEE ALSO

L<HTML::Widget>

=head1 AUTHOR

Jozef Kutej, E<lt>jozef@kutej.net<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Jozef Kutej

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut



