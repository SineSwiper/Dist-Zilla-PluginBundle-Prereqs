package Dist::Zilla::PluginBundle::Prereqs;

our $VERSION = '0.9'; # VERSION
# ABSTRACT: Useful Prereqs modules in a Dist::Zilla bundle

use sanity;
use Moose;

with 'Dist::Zilla::Role::PluginBundle::Merged';
 
sub configure { shift->add_merged( qw[ AutoPrereqs MinimumPerl MinimumPrereqs PrereqsClean ] ); }

__PACKAGE__->meta->make_immutable;
42;



=pod

=encoding utf-8

=head1 NAME

Dist::Zilla::PluginBundle::Prereqs - Useful Prereqs modules in a Dist::Zilla bundle

=head1 SYNOPSIS

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

=head1 DESCRIPTION

This is a handy L<Dist::Zilla> plugin bundle that ties together several useful Prereq
plugins:

=over

=item *

L<Dist::Zilla::Plugin::AutoPrereqs|AutoPrereqs>

=item *

L<Dist::Zilla::Plugin::MinimumPerl|MinimumPerl>

=item *

L<Dist::Zilla::Plugin::MinimumPrereqs|MinimumPrereqs>

=item *

L<Dist::Zilla::Plugin::PrereqsClean|PrereqsClean>

=back

This also delegates the ordering pitfalls, so you don't have to worry about that.  All
of the options from those plugins are directly supported from within the bundle, via
L<Dist::Zilla::Role::PluginBundle::Merged|PluginBundle::Merged>.

=head1 SEE ALSO

"Manual entry" Dist::Zilla Prereq plugins: L<Dist::Zilla::Plugin::Prereqs|Prereqs>, L<Dist::Zilla::Plugin::RemovePrereqs|RemovePrereqs>,
L<Dist::Zilla::Plugin::RemovePrereqsMatching|RemovePrereqsMatching>, L<Dist::Zilla::Plugin::Conflicts|Conflicts>

=head1 AVAILABILITY

The project homepage is L<https://github.com/SineSwiper/Dist-Zilla-PluginBundle-Prereqs/wiki>.

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you, or see L<https://metacpan.org/module/Dist::Zilla::Plugin::PrereqsClean/>.

=head1 AUTHOR

Brendan Byrd <BBYRD@CPAN.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2012 by Brendan Byrd.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut


__END__

