#33:intersection   this none this rxd

":intersection(seq1,seq2,...) => intersection of all sequences...";
if ((U = {$minint}) in args)
  args = $list_utils:setremove_all(args, U);
endif
if (length(args) <= 1)
  return args ? args[1] | U;
endif
return this:complement(this:_union(@$list_utils:map_arg(this, "complement", args)));
