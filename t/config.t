use strict;
use warnings;
use Test::Declare;
use lib './t/lib';
use Mock::Config;

plan tests => blocks;

describe 'config tests' => run {
    test 'check config_dir_map' => run {
        is_deeply +Mock::Config->config_dir_map, +{
            testing => './t/assets/config/'
        };
    };
    test 'get test config data' => run {
        is_deeply +Mock::Config->get('test'), +{ foo => 'bar' };
        is_deeply +Mock::Config->get('test'), +{ foo => 'bar' };
        is_deeply +Mock::Config->get('test'), +{ foo => 'bar' };
        is_deeply +Mock::Config->get('test'), +{ foo => 'bar' };
    };
    test 'config local cache check' => run {
        is_deeply +Mock::Config->__config_cache->{test}, +{ foo => 'bar' };
    };
};

