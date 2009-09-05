use strict;
use warnings;
use Test::Declare;
use lib './t/lib';
use Mock::Component;
use Smoker::Component::Request;
use HTTP::Request;

plan tests => blocks;

describe 'component tests' => run {
    test 'check request' => run {
        my $c = Mock::Component->new;
        Smoker::Component::Request->install_to_component(ref($c), HTTP::Request->new( GET => '/Hello' ));
        can_ok $c, 'req';
        is $c->req->uri, '/Hello';

        my $cc = Mock::Component->new;
        Smoker::Component::Request->install_to_component(ref($cc), HTTP::Request->new( GET => '/NEKO' ));
        can_ok $cc, 'req';
        is $cc->req->uri, '/NEKO';
        is $c->req->uri, '/Hello';
    };
};

