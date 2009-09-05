use strict;
use warnings;
use Test::Declare;
use lib './t/lib';
use Mock::Component;
use Smoker::Component::Response;

plan tests => blocks;

describe 'component tests' => run {
    test 'check response' => run {
        my $c = Mock::Component->new;
        Smoker::Component::Response->install_to_component(ref($c));
        can_ok $c, 'res';
        $c->res->status(404);
        is $c->res->status, '404';

        my $cc = Mock::Component->new;
        Smoker::Component::Response->install_to_component(ref($cc));
        can_ok $cc, 'res';
        is $cc->res->status, '200';
        is $c->res->status, '404';
    };
};

