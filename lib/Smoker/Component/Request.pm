package Smoker::Component::Request;
use Smoker;
use base 'Smoker::Component::Base';

sub install_to_component {
    my ($class, $component, $req) = @_;

    $class->install_method($component, 'req' => sub {
        my $c = shift;
        $c->{req} ||= $req;
    });
}

1;
