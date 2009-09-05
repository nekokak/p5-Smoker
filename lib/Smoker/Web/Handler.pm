package Smoker::Web::Handler;
use Smoker;
use base 'Class::Accessor::Fast';
use HTTP::Engine;
use HTTP::Engine::Middleware;
use UNIVERSAL::require;
use Smoker::Component::Request;
use Smoker::Component::Response;
use Smoker::Component::View;
use Smoker::Web::Dispatcher;

__PACKAGE__->mk_accessors(qw/context/);

sub web_component { die 'this method is abstract' }
sub base_name {};
sub config {
    my $self = shift;
    my $conf = $self->base_name . '::Config';
    $conf->use or die $@;
    $conf;
}

sub init_context {
    my $self = shift;
    $self->context(
        $self->web_component->new
    );
}

sub init_request {
    my ($self, $req) = @_;
    warn 'install request';
    Smoker::Component::Request->install_to_component($self->web_component, $req);
}

sub init_response {
    my $self = shift;
    Smoker::Component::Response->install_to_component($self->web_component);
}

sub init_view {
    my $self = shift;
    Smoker::Component::View->install_to_component($self->web_component);
}

sub default_view { 'TT' }

sub new {
    my $class = shift;

    my $self = bless {}, $class;

    my $middlewares = HTTP::Engine::Middleware->new({ method_class => 'HTTP::Engine::Request' });
    $middlewares->install(@{ $self->config->get_middleware_setting });

    my $interface = $self->config->get('http_engine')->{interface};
    $interface->{request_handler} = $middlewares->handler($self->request_handler);
    $self->{http_engine} = HTTP::Engine->new(interface => $interface);

    $self;
}

sub run { $_[0]->{http_engine}->run }

sub request_handler {
    my $self = shift;
    sub { $self->handler(@_) }
}

sub handler {
    my ($self, $req) = @_;

    $self->init_context;
    $self->init_request($req);
    $self->init_response;
    $self->init_view;

    my $rule = Smoker::Web::Dispatcher->dispatch($self->base_name, $self->context->req);
    $rule->{controller_class}->use;
    if ( $@ ) {
        warn $@;
        return $self->not_found;
    }

    my $method = $rule->{method};
    if ( $rule->{controller_class}->can($method) ) {

        my $res = $rule->{controller_class}->$method($self->context);
        unless (ref($res) eq'HTTP::Engine::Response') {

            my $view_class;
            unless ($self->context->{view_class}) {
                $view_class = $self->context->view($self->default_view);
            } else {
                $view_class = $self->context->view;
            }

            return $view_class->process($rule->{controller}, $rule->{action});

        } else {
            return $res;
        }

    } else {
        warn "method $method is not defined to @{[ $rule->{controller_class} ]}";
        return $self->not_found;
    }
}

sub not_found {
    my $self = shift;
    $self->context->res->status(404);
    $self->context->res->body('NOT FOUND');
}

1;

