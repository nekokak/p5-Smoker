package Mock::Model::MyModelObj;
use Smoker;
use base 'Smoker::Model';

__PACKAGE__->mk_classdata(config => +{foo => 'bar'});

sub model_init {
    my $class = shift;
    bless {}, $class;
} 

1;

