use strict;
use warnings;
use Test::Declare;
use lib './t/lib';
use Mock::Component;

Mock::Component->install_components(qw/Config/);

plan tests => blocks;

describe 'component tests' => run {
    test 'check config value' => run {
        my $c = Mock::Component->new;
        is_deeply $c->config->get('test'), +{ foo => 'bar' };
    };
};

