#62:enterfunc   this none this rxd

"Copied from The Coat Closet (#11):enterfunc by Haakon (#2) Mon May  8 10:41:38 1995 PDT";
who = args[1];
if ($limbo:acceptable(who))
  move(who, $limbo);
else
  pass(who);
endif
