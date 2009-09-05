package Smoker::Component::View;
use Smoker;
use base 'Smoker::Component::Base';

sub install_to_component {
    my ($class, $component) = @_;

    $class->install_method($component, 'view' => sub {
        my ($c, $view_name) = @_;

        if ($view_name) {
            $c->{view_class} = $view_name;
        } else {
            die 'view_class not found!' unless $c->{view_class};
            $view_name = $c->{view_class};
        }

        $c->{_view}->{$view_name} or do {
            my $view_class = 'Smoker::View::' . $view_name;
            $class->load_class($view_class);
            $c->{_view}->{$view_name} = $view_class->new($c);
        }
    });
}

1;
