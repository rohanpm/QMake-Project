use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'QMake::Project',
    AUTHOR              => q{Rohan McGovern <rohan@mcgovern.id.au>},
    VERSION_FROM        => 'lib/QMake/Project.pm',
    ABSTRACT_FROM       => 'lib/QMake/Project.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'lgpl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'QMake-Project-*' },
);
