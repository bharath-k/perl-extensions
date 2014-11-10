#! /opt/perl5/bin/perl
use ExtUtils::testlib;
use example;
use Devel::Peek;
use Data::Dumper;

print "-----------example::get_service------------\n";
print Dumper(example::get_service());

print "\n-----------example::get_service_array------------\n";
print Dumper(example::get_service_array());

print "\n-----------example::fillup_service------------\n";
print Dumper(example::fillup_service(0));

print "\n-----------example::fillup_service_array------------\n";
print Dumper(example::fillup_service_array(0));
