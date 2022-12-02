#62:match   this none this rxd

"Copied from The Coat Closet (#11):match by Lambda (#50) Mon May  8 10:42:01 1995 PDT";
m = pass(@args);
if (m == $failed_match)
  "... it might be a player off in the body bag...";
  m = $string_utils:match_player(args[1]);
  if (valid(m) && !(m.location in {this, $limbo}))
    return $failed_match;
  endif
endif
return m;
