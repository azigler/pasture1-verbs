#59:total_lines   this none this xd

"$code_utils:total_lines(OBJ who) => Returns an integer representing the total number of lines of code in verbs owned by <who>. If <who> is not provided, this just prints out the total number of lines of code in all verbs.";
"Verb created by Saeed on 12/10/2021.";
{?who = 0} = args;
total_lines = 0;
who != 0 && !is_player(who) && raise(E_INVARG);
for o in [#0..max_object()]
  if (!valid(o))
    continue;
  endif
  for v in (verbs(o))
    if (who != 0 && verb_info(o, v)[1] != who)
      continue;
    endif
    total_lines = total_lines + length(this:rmll(verb_code(o, v)));
    yin(0, 1000);
  endfor
  yin(0, 1000);
endfor
return total_lines;
"Last modified Sat Dec  3 18:49:52 2022 UTC by Saeed (#128).";
