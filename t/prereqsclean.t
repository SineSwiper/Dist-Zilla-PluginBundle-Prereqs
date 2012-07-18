use sanity;
use Test::More 0.88;
 
use lib 't/lib';
 
use Test::DZil;
use YAML::Tiny;
 
sub build_meta {
   my $tzil = shift;
   $tzil->build;
   YAML::Tiny->new->read($tzil->tempdir->file('build/META.yml'))->[0];
}
 
my $tzil = Builder->from_config(
   { dist_root => 't/dist' },
   { },
);
 
# check found prereqs
my $meta = build_meta($tzil);
 
my %wanted = (
   'Acme::Prereq::A'                    => 0,
   'Acme::Prereq::AnotherNS::B'         => 0,
   'Acme::Prereq::AnotherNS::C'         => 0,
   'Acme::Prereq::AnotherNS::Deeper::B' => 0,
   'Acme::Prereq::AnotherNS::Deeper::C' => 0,
   'Acme::Prereq::B'                    => 0,
   'Acme::Prereq::BigDistro::A'         => '!= 0.00',
   'Acme::Prereq::BigDistro::B'         => 0,
   'Acme::Prereq::BigDistro::Deeper::A' => '0.01',
   'Acme::Prereq::BigDistro::Deeper::B' => 0,
   'Acme::Prereq::None'                 => 0,
   'DZPA::NotInDist'                    => 0,
   'Module::Load'                       => '0.12',
   'Shell'                              => 0,
   'mro'                                => '1.01',
   'strict'                             => 0,
   'warnings'                           => 0,
);
 
is_deeply(
   $meta->{prereqs}{runtime}{requires},
   \%wanted,
   'no PrereqsClean works',
);
 
# Okay, add in the PrereqsClean stuff
for my $rl (0 .. 3) {
   $tzil = Builder->from_config(
      { dist_root => 't/dist' },
      {
         add_files => {
            'source/dist.ini' => simple_ini(
               qw(GatherDir ExecDir),
               [ AutoPrereqs    => { skip => '^DZPA::Skip' } ],
               [ 'Prereqs / RuntimeRequires'
                                => { 'Acme::Prereq::BigDistro::A' => '!= 0.00' } ],
               [ 'PrereqsClean' => { removal_level => $rl } ],
               [ MetaYAML       => { version => 2 } ],
            ),
         },
      },
   );
    
   # check found prereqs
   $meta = build_meta($tzil);
   
   # Keep removing stuff as we go...
   for ($rl) {
      when (0) {
         # only Perl elevation
         
         ### FIXME: Perl ###
         delete $wanted{'mro'};
      }
      when (1) {
         # other core modules
         delete $wanted{'Module::Load'};
      }
   }
   
   is_deeply(
      $meta->{prereqs}{runtime}{requires},
      \%wanted,
      "PrereqsClean @ removal_level $rl",
   );
}
 
done_testing;