package Mock::Config;
use base 'Smoker::Config';
__PACKAGE__->config_dir_map(
    +{
        testing => './t/assets/config/',
    }
);
__PACKAGE__->env('testing');

1;
