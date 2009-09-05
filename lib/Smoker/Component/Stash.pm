package Smoker::Component::Stash;
use Smoker;
use base 'Smoker::Component::Base';

sub install_to_component {
    my ($class, $component) = @_;

    $class->install_method($component, 'stash' => sub : lvalue {
        my $c = shift;
        $c->{__stash} ||= +{};
    });
}

1;
