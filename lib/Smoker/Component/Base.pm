package Smoker::Component::Base;
use Smoker;
use Sub::Install;
use UNIVERSAL::require;
use Carp;

sub install_to_component { die 'this method is abstract!!' }

sub install_method {
    my ($class, $component, $method_name, $code) = @_;

    Sub::Install::reinstall_sub({
      code => $code,
      into => $component,
      as   => $method_name,
    });
}

sub load_class {
    my ($class, $module) = @_;
    $module->require or Carp::croak $@;
}

1;

