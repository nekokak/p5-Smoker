use strict;
use warnings;
use Test::Declare;
use lib './t/lib';
use Mock::Component;

Mock::Component->install_components(qw/Stash/);

plan tests => blocks;

describe 'component tests' => run {
    test 'check method' => run {
        my $c = Mock::Component->new;
        can_ok $c, 'stash' ;
        $c->stash->{foo} = 'bar';
        is $c->stash->{foo}, 'bar';
    };
    test 'check stash value' => run {
        my $c = Mock::Component->new;
        is $c->stash->{foo}, undef;
    };
};

