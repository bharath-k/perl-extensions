use ExtUtils::MakeMaker;
WriteMakefile(
  NAME    => '_example',
  LIBS    => ['-lm'],
  OBJECT  => 'example.o _example_wrap.o'
);
