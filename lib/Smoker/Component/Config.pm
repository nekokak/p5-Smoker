package Smoker::Component::Config;
use Smoker;
use base 'Smoker::Component::Base';

sub install_to_component {
    my ($class, $component) = @_;

    $class->install_method($component, 'config' => sub {
        my $c = shift;
        $c->{__config} or do {
            (my $conf_package = ref $c) =~ s/::(.+)/::Config/;
            $class->load_class($conf_package);
            $c->{__config} = $conf_package;
        };
    });
}

1;
