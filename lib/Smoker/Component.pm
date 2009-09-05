package Smoker::Component;
use Smoker;
use base 'Class::Accessor::Fast';
use Carp;
use UNIVERSAL::require;

sub install_components {
    my ($class, @components) = @_;

    for my $component (@components) {
        if ($component =~ /^\+.+/) {
            $component =~ s/^\+//;
        } else {
            $component = 'Smoker::Component::'.$component
        }
        $component->require or Carp::croak $@;
        $component->install_to_component($class);
    }
}

1;

