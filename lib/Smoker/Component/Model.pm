package Smoker::Component::Model;
use Smoker;
use base 'Smoker::Component::Base';

sub install_to_component {
    my ($class, $component) = @_;

    $class->install_method($component, 'model' => sub {
        my ($c, $model) = @_;
        $c->{__mode}->{$model} or do {
            (my $model_package = ref $c) =~ s/(::.+)?$//g;
            $model_package .= "::Model::$model";
            $class->load_class($model_package);
            $c->{__model}->{$model} = $model_package->model_init;
        };
    });
}

1;
