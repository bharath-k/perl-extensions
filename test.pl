#! /opt/perl5/bin/perl
use ExtUtils::testlib;
use example;
use Devel::Peek;
use Data::Dumper;

my %opts = ();
my $example_inst = example->new(\%opts);

print "-----------example::get_service------------\n";
print Dumper($example_inst->get_service());

print "\n-----------example::get_service_array------------\n";
print Dumper($example_inst->get_service_array());

print "\n-----------example::fillup_service------------\n";
print Dumper($example_inst->fillup_service(0));

print "\n-----------example::fillup_service_array------------\n";
print Dumper($example_inst->fillup_service_array(0));
