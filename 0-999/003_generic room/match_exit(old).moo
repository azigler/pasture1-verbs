#3:match_exit(old)   this none this rxd

what = args[1];
if (what)
  yes = $failed_match;
  for e in (this.exits)
    if (valid(e) && what in {e.name, @e.aliases})
      if (yes == $failed_match)
        yes = e;
      elseif (yes != e)
        return $ambiguous_match;
      endif
    endif
  endfor
  return yes;
else
  return $nothing;
endif
