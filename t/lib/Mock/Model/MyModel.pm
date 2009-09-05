package Mock::Model::MyModel;
use Smoker;
use base 'Smoker::Model';

sub model_init { __PACKAGE__ } 
sub foo { 'bar' }

1;

