
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Useful Prereqs modules in a Dist::Zilla bundle",
  "AUTHOR" => "Brendan Byrd <BBYRD\@CPAN.org>",
  "BUILD_REQUIRES" => {
    "Test::DZil" => 0,
    "Test::Most" => 0,
    "YAML::Tiny" => 0
  },
  "CONFIGURE_REQUIRES" => {},
  "DISTNAME" => "Dist-Zilla-PluginBundle-Prereqs",
  "EXE_FILES" => [],
  "LICENSE" => "artistic_2",
  "NAME" => "Dist::Zilla::PluginBundle::Prereqs",
  "PREREQ_PM" => {
    "Dist::Zilla::Role::MetaCPANInterfacer" => 0,
    "Dist::Zilla::Role::PluginBundle::Merged" => 0,
    "Dist::Zilla::Role::PrereqSource" => 0,
    "List::AllUtils" => 0,
    "Module::CoreList" => "2.69",
    "Moose" => 0,
    "MooseX::Types" => 0,
    "sanity" => 0
  },
  "VERSION" => "0.91",
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



