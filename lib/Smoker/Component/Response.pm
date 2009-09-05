package Smoker::Component::Response;
use Smoker;
use base 'Smoker::Component::Base';
use HTTP::Engine::Response;

sub install_to_component {
    my ($class, $component) = @_;

    my $res = HTTP::Engine::Response->new;
    $class->install_method($component, 'res' => sub {
        my $c = shift;
        $c->{__res} ||= $res;
    });
}

1;

