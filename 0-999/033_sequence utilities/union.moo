#33:union   this none this rxd

":union(seq1,seq2,...)        => union of all sequences...";
if ({} in args)
  args = $list_utils:setremove_all(args, {});
endif
if (length(args) <= 1)
  return args ? args[1] | {};
endif
return this:_union(@args);
