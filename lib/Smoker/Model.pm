package Smoker::Model;
use Smoker;
use base 'Class::Data::Inheritable';

__PACKAGE__->mk_classdata('config');

sub model_init { die 'this method is abstract!!' }

1;

