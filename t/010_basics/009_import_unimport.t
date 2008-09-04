#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 42;


my @moose_exports = qw(
    extends with 
    has 
    before after around
    override
    augment
    super inner
    make_immutable
);

{
    package Foo;

    eval 'use Moose';
    die $@ if $@;
}

can_ok('Foo', $_) for @moose_exports;

{
    package Foo;

    eval 'no Moose';
    die $@ if $@;
}

ok(!Foo->can($_), '... Foo can no longer do ' . $_) for @moose_exports;

# and check the type constraints as well

my @moose_type_constraint_exports = qw(
    type subtype as where message 
    coerce from via 
    enum
    find_type_constraint
);

{
    package Bar;

    eval 'use Moose::Util::TypeConstraints';
    die $@ if $@;
}

can_ok('Bar', $_) for @moose_type_constraint_exports;

{
    package Bar;

    eval 'no Moose::Util::TypeConstraints';
    die $@ if $@;
}

ok(!Bar->can($_), '... Bar can no longer do ' . $_) for @moose_type_constraint_exports;

