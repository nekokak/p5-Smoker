package Smoker::Config;
use Smoker;
use base qw(Class::Data::Inheritable);
use Data::Visitor::Encode;
use Path::Class;
use YAML::Syck;

__PACKAGE__->mk_classdata('config_dir_map' => +{});
__PACKAGE__->mk_classdata('__config_cache' => +{});
__PACKAGE__->mk_classdata('env');

sub get {
    my ($class, $domain) = @_;

    $class->env(($ENV{SHODOW_CONFIG_NAME}||'product')) unless $class->env;
    $class->__config_cache->{$domain} or do {
        $class->__config_cache->{$domain} = $class->_get($domain);
    };
}

sub _get {
    my ($class, $domain) = @_;

    my $data = YAML::Syck::LoadFile(file($class->config_dir_map->{$class->env}, "$domain.yaml")->stringify);
    my $config = $data->{$class->env} || $data->{common};
    return Data::Visitor::Encode->new->decode('utf-8', $config);
}

sub get_middleware_setting {
    my $class = shift;

    my @middleware_conf;
    for my $row (@{$class->get('http_engine')->{middleware}}) {
        push @middleware_conf, $row->{module};
        push @middleware_conf, $row->{option};
    }
    return \@middleware_conf;
}

1;

