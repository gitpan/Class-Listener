package Class::Listener;

use 5.006;
use strict;
use warnings;

use Class::Maker;

our $VERSION = '0.01.01';

our $DEBUG = 0;

    Class::Maker::class
    {
        public =>
        {
            hash  => [qw( events )],
        },
    };

    sub signal : method
    {
        my $this = shift;

        my $event = shift;

            if( exists $this->events->{$event} )
            {
                return $this->events->{$event}->( $this, $event, @_ );
            }
            else
            {
                warn "D: ", $event." - unimplemented event called\n" if $DEBUG;
            }

    return undef;
    }

1;
__END__

=head1 NAME

Class::Listener - executes callbacks on events

=head1 SYNOPSIS

  use Class::Listener;

  {
    package My::Listener;

    @ISA = qw(Class::Listener);
  }

  my $l = My::Listener->new( events => { eventname => sub { } );

  $l->Class::Listener::signal( 'eventname', @args );

=head1 DESCRIPTION

This class has a callback hash. It executes the subs via the signal method.

=head2 METHODS

=head3 signal( $eventname, @args )

=over 4

=item $eventname

a key in thte C<events> callback hash.

=item @args

This array is forwarded to the callback.

=back

[Note] signal returns the resulting return value of the callback.

=head2 EXPORT

None by default.


=head1 AUTHOR

Murat Uenalan, E<lt>muenalan@cpan.orgE<gt>

=head1 SEE ALSO

L<Class::Proxy>.

=cut
