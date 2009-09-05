package Smoker::Web::Dispatcher;
use Smoker;
use HTTPx::Dispatcher;
use String::CamelCase qw//;

connect ''                     => { controller => 'root', action => 'index' };
connect ':controller/'         => { action => 'index' };
connect ':controller/:action';
connect ':action'              => { controller => 'root', };

sub dispatch {
    my ( $class, $base_class, $req ) = @_;

    my $rule = $class->match($req);
    $rule->{controller_class} = $base_class . '::Web::C::' . String::CamelCase::camelize($rule->{controller});
    $rule->{controller_class} =~ s!/!::!g;
    $rule->{method} = 'dispatch_' . $rule->{action};
    $rule;
}

1;

