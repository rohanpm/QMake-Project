package QMake::Project::LazyValue;
use strict;
use warnings;

our $VERSION = '0.80';
our @CARP_NOT = qw( QMake::Project );

use overload
    q{""} => \&_resolved,
    q{0+} => \&_resolved,
    q{bool} => \&_resolved,
    q{cmp} => \&_cmp,
    q{<=>} => \&_num_cmp,
;

sub new
{
    my ($class, %args) = @_;

    return bless \%args, $class;
}

sub _resolved
{
    my ($self) = @_;

    my $resolved;
    if (exists $self->{ _resolved }) {
        $resolved = $self->{ _resolved };
    } else {
        $self->{ project }->_resolve( );
        $resolved = $self->{ project }{ _resolved }{ $self->{ type } }{ $self->{ key } };
        $self->{ _resolved } = $resolved;
    }

    # Variables are typically arrayrefs, though they may have only 1 value.
    # Tests are typically plain scalars, no dereferencing required.
    #
    # However, we actually do not rely on the above; we support both cases (arrayref
    # or scalar) without checking what type we expect.
    #
    if (defined($resolved) && ref($resolved) eq 'ARRAY') {
        return wantarray ? @{ $resolved } : $resolved->[0];
    }

    # If there was an error, and we wantarray, make sure we return ()
    # rather than (undef)
    if (wantarray && !defined($resolved)) {
        return ();
    }

    return $resolved;
}

sub _cmp
{
    my ($self, $other) = @_;

    return "$self" cmp "$other";
}

sub _num_cmp
{
    my ($self, $other) = @_;

    return 0+$self <=> 0+$other;
}

1;

=head1 NAME

QMake::Project::LazyValue - evaluate qmake values on-demand

=head1 DESCRIPTION

This package implements the lazy evaluation of values from a qmake project.
It is an implementation detail; callers do not use this class directly.

=cut
