use strict;
use warnings;
use Test::Declare;
use lib './t/lib';
use Mock::Component;

Mock::Component->install_components(qw/View/);

plan tests => blocks;

describe 'component tests' => run {
    test 'check view' => run {
        my $c = Mock::Component->new;
        can_ok $c, 'view';
    };
};

