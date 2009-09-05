use strict;
use warnings;
use Test::Declare;
use lib './t/lib';
use Mock::Component;

Mock::Component->install_components(qw/Model/);

plan tests => blocks;

describe 'component tests' => run {
    test 'check model' => run {
        my $c = Mock::Component->new;
        is $c->model('MyModel')->foo, 'bar';
    };
};

