#!perl -T
use strict;
use warnings;

use Test::More;

require './Makefile.PL';
my %module = get_module_info();

my $module = $module{ NAME };

if( $^O ne 'MSWin32' ) {
    plan skip_all => "This module only works on Windows";
    exit;
};

plan tests => 1;

require_ok( $module );

diag( sprintf "Testing %s %s, Perl %s", $module, $module->VERSION, $] );

for (sort grep /\.pm\z/, keys %INC) {
   s/\.pm\z//;
   s!/!::!g;
   eval { diag(join(' ', $_, $_->VERSION || '<unknown>')) };
}
