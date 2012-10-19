
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Useful Prereqs modules in a Dist::Zilla bundle",
  "AUTHOR" => "Brendan Byrd <BBYRD\@CPAN.org>",
  "BUILD_REQUIRES" => {
    "Test::CheckDeps" => "0.002",
    "Test::DZil" => "4.200002",
    "Test::Most" => "0.01",
    "Test::UseAllModules" => "0.10",
    "YAML::Tiny" => "1.23"
  },
  "CONFIGURE_REQUIRES" => {},
  "DISTNAME" => "Dist-Zilla-PluginBundle-Prereqs",
  "EXE_FILES" => [],
  "LICENSE" => "artistic_2",
  "NAME" => "Dist::Zilla::PluginBundle::Prereqs",
  "PREREQ_PM" => {
    "Dist::Zilla::Plugin::MinimumPerl" => "1.003",
    "Dist::Zilla::Role::MetaCPANInterfacer" => "0.90",
    "Dist::Zilla::Role::PluginBundle::Merged" => "0.90",
    "Dist::Zilla::Role::PrereqSource" => "2.100880",
    "List::AllUtils" => "0.01",
    "Module::CoreList" => "2.69",
    "Moose" => "0.34",
    "MooseX::Types" => "0.06",
    "sanity" => "0.91"
  },
  "VERSION" => "0.92",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



