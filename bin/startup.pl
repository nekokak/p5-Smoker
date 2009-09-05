#!/usr/bin/perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Smoker::Web::Handler;

Smoker::Web::Handler->new->run;

