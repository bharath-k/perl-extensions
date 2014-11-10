use ExtUtils::MakeMaker;
WriteMakefile(
  NAME    => 'example',
  LIBS    => ['-lm'],
  OBJECT  => 'example.o example_wrap.o'
);
