package Dist::Zilla::PluginBundle::Prereqs;

# VERSION
# ABSTRACT: Useful Prereqs modules in a Dist::Zilla bundle

use sanity;
use Moose;

with 'Dist::Zilla::Role::PluginBundle::Merged';
 
sub configure { shift->add_merged( qw[ AutoPrereqs MinimumPerl MinimumPrereqs PrereqsClean ] ); }

__PACKAGE__->meta->make_immutable;
42;

__END__

=begin wikidoc

= SYNOPSIS
 
   ; Instead of this...
   [AutoPrereqs]
   skip = ^Foo|Bar$
   [MinimumPerl]
   [MinimumPrereqs]
   minimum_year = 2008
   [PrereqsClean]
   minimum_perl = 5.8.8
   removal_level = 2

   ; ...use this
   [@Prereqs]
   skip = ^Foo|Bar$
   minimum_year = 2008
   minimum_perl = 5.8.8
   removal_level = 2
   
   ; and potentially put some manual entries afterwards...
   [Prereqs]
   ; ...
   [RemovePrereqs]
   ; ...
   [RemovePrereqsMatching]
   ; ...
   [Conflicts]
   ; ...

= DESCRIPTION
 
This is a handy [Dist::Zilla] plugin bundle that ties together several useful Prereq
plugins:

* [Dist::Zilla::Plugin::AutoPrereqs|AutoPrereqs]
* [Dist::Zilla::Plugin::MinimumPerl|MinimumPerl]
* [Dist::Zilla::Plugin::MinimumPrereqs|MinimumPrereqs]
* [Dist::Zilla::Plugin::PrereqsClean|PrereqsClean]

This also delegates the ordering pitfalls, so you don't have to worry about that.  All
of the options from those plugins are directly supported from within the bundle, via
[Dist::Zilla::Role::PluginBundle::Merged|PluginBundle::Merged].

= SEE ALSO

"Manual entry" Dist::Zilla Prereq plugins: [Dist::Zilla::Plugin::Prereqs|Prereqs], [Dist::Zilla::Plugin::RemovePrereqs|RemovePrereqs],
[Dist::Zilla::Plugin::RemovePrereqsMatching|RemovePrereqsMatching], [Dist::Zilla::Plugin::Conflicts|Conflicts]

=end wikidoc
