#27:"difference_suspended diff_suspended"   this none this rxd

"Usage:  diff_suspended(set 1, set 2, ..., set n)";
"Returns all elements of set 1 that are not in sets 2..n";
"Suspends as needed if the lists are large.";
{set, @rest} = args;
for l in (rest)
  for x in (l)
    set = setremove(set, x);
    $command_utils:suspend_if_needed(0);
  endfor
endfor
return set;
