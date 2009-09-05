package Smoker::View::TT;
use Smoker;
use base 'Smoker::View';
use Template;
use File::Spec;
use Template::Stash::EscapeHTML;
use HTML::Entities;

sub new {
    my ($class, $c) = @_;

    my $self = bless {
        c => $c,
    }, $class;
    my $conf = $c->config->get('view');

    $self->{tt} = Template->new(
        ABSOLUTE     => 1,
        RELATIVE     => 1,
        ENCODING     => 'utf-8',
        STASH        => Template::Stash::EscapeHTML->new,
        FILTERS      => +{
            html_unescape => sub { HTML::Entities::decode_entities(shift) },
        },
        COMPILE_DIR  => '/tmp/' . $ENV{USER} . "/",
        INCLUDE_PATH => [ '.', File::Spec->catfile($conf->{tmpl}->{path}) ],
        %{ $conf->{tmpl}->{options} || {} },
    );
    $self;
}

sub render {
    my ($self, $template) = @_;
    my $c  = $self->{c};

    if ($self->{load_template}) {
        $template = $self->{load_template};
    }

    $self->{tt}->process(
        $template,
        {
            %{ $c->stash },
            c => $c,
        },
        \my $output,
    ) or die $@;

    $output;
}

sub process {
    my ($self, $controller, $action) = @_;
    $self->{c}->res->body(
        $self->render($self->guess_filename($controller, $action))
    );
    $self->{c}->res->status(200);
    $self->{c}->res;
}

sub guess_filename {
    my ($self, $controller, $action) = @_;
    "$controller/$action.html";
}

1;

