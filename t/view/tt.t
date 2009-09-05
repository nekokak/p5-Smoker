use strict;
use warnings;
use Test::Declare;
use lib './t/lib';
use Mock::Component;

Mock::Component->install_components(qw/Config Stash View/);

plan tests => blocks;

describe 'component tests' => run {
    test 'check view class' => run {
        my $c = Mock::Component->new;

        dies_ok(sub {$c->view});

        my $view = $c->view('TT');
        isa_ok $view, 'Smoker::View::TT';
        $view = $c->view;
        isa_ok $view, 'Smoker::View::TT';

        is $c->view->guess_filename('foo', 'bar'), 'foo/bar.html';
        my $output = $c->view->render('foo/bar.html');
        chomp $output;
        is $output, 'hello tt';
    };
};

