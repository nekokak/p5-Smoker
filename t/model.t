use strict;
use warnings;
use Test::Declare;
use lib './t/lib';
use Mock::Component;

Mock::Component->install_components(qw/Model/);

plan tests => blocks;

describe 'component tests' => run {
    test 'check method' => run {
        my $c = Mock::Component->new;
        can_ok $c, 'model' ;
        is $c->model('MyModel'), 'Mock::Model::MyModel';
        is $c->model('MyModel')->foo, 'bar';
    };
    test 'check method' => run {
        my $c = Mock::Component->new;
        can_ok $c, 'model' ;
        is ref $c->model('MyModelObj'), 'Mock::Model::MyModelObj';
        is_deeply $c->model('MyModelObj')->config, +{foo => 'bar'};
    };
};

