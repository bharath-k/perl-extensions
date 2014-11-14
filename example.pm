package example;
use strict;
use warnings;
use Exporter qw(import);
use _example;

our @EXPORT_OK = qw(get_service get_service_array fillup_service fillup_service_array);

# To overcome the fact that there is no easy way to pass exceptions back to
# perl from the perl C extension, we have this wrapper package. The example
# package needs to be instantiated before invoking any of the methods.

sub new {
    my $class = shift @_;
    my $options = shift @_;
    my $self = (defined $options) ? ( bless $options, $class ) : ( bless {}, $class );
    $self->{'error'} = undef;
    return $self;
}

sub get_service {
    my $self = shift @_;
    return _example::get_service();
}

sub get_service_array {
    my $self = shift @_;
    return _example::get_service_array();
}

sub fillup_service {
    my $self = shift @_;
    my $intValue = shift @_;
    my ($retcode, $service) = _example::fillup_service($intValue);
    if($retcode != 0) {
        # obtain and set the error string.
        $self->{'error'} = "Something went wrong";
        # Ideally we should have a method that takes in the error code and
        # returns error string e.g. _example::Error2String($retcode);
    }
    else {
        # Clear error if successful.
        $self->{'error'} = undef;
    }
    return $service;
}

sub fillup_service_array {
    my $self = shift @_;
    my $intValue = shift @_;
    my ($retcode, $services) = _example::fillup_service_array($intValue);
    if($retcode != 0) {
        $self->{'error'} = "Something went wrong";
        # Ideally we should have a method that takes in the error code and
        # returns error string e.g. _example::Error2String($retcode);
    }
    else {
        # Clear error if successful.
        $self->{'error'} = undef;
    }
    return $services;
}

1;