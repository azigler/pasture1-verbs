#30:columnize   this none this rxd

":columnize(@list_of_strings) -- prints the given list in a number of columns wide enough to accomodate longest entry. But no more than 4 columns.";
longest = $list_utils:longest(args);
for d in ({4, 3, 2, 1})
  if (79 / d >= length(longest))
    return $string_utils:columnize_suspended(0, args, d);
  endif
endfor
