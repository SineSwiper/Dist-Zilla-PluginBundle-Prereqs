use sanity;
use Test::Most;
 
use Test::DZil;
use YAML::Tiny;
 
sub build_meta {
   my $tzil = shift;
   $tzil->build;
   YAML::Tiny->new->read($tzil->tempdir->file('build/META.yml'))->[0];
}
 
my $tzil = Builder->from_config(
   { dist_root => 'corpus/dist' },
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

   'DZPA::NotInDist'  => 0,

   'Module::Metadata' => 0,
   'Module::Load'     => '0.12',
   'Shell'            => 0,

   'mro'              => '1.01',
   'strict'           => 0,
   'warnings'         => 0,
  
   'perl'             => '5.008',
);
 
is_deeply(
   $meta->{prereqs}{runtime}{requires},
   \%wanted,
   'no PrereqsClean works',
);
 
# Okay, add in the PrereqsClean stuff
for my $rl (0 .. 3) {
   $tzil = Builder->from_config(
      { dist_root => 'corpus/dist' },
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
         $wanted{'perl'} = '5.010001';
         delete $wanted{'mro'};
      }
      when (1) {
         # other core modules
         delete $wanted{$_} for (qw{Module::Load strict warnings});
      }
      when (2) {
         # Multiple modules within a distro (split protection)
         delete $wanted{'Acme::Prereq::BigDistro::'.$_} for (qw{B Deeper::A Deeper::B});
         $wanted{'Acme::Prereq::BigDistro'} = '0.01';
      }
      when (3) {
         # Multiple modules within a distro (no split protection)
         delete $wanted{'Acme::Prereq::AnotherNS::'.$_} for (qw{B C Deeper::B Deeper::C});
      }
   }
   
   explain $meta->{prereqs}{runtime}{requires};
   
   is_deeply(
      $meta->{prereqs}{runtime}{requires},
      \%wanted,
      "PrereqsClean @ removal_level $rl",
   );
}
 
done_testing;