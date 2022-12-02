#27:"exclusive_or xor"   this none this rxd

"Usage:  exclusive_or(set, set, ...)";
"Return the set of all elements that are in exactly one of the input sets";
"For two sets, this is the equivalent of (A u B) - (A n B).";
if (!args)
  return {};
endif
{set, @rest} = args;
so_far = set;
for l in (rest)
  for x in (l)
    if (x in so_far)
      set = setremove(set, x);
    else
      set = setadd(set, x);
    endif
  endfor
  so_far = {@so_far, @l};
endfor
return set;
