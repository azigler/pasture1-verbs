#56:explain_syntax   this none this rxd

":explain_syntax(here,verb,args)";
verb = args[2];
for x in ({player, args[1], @valid(dobj) ? {dobj} | {}, @valid(iobj) ? {iobj} | {}})
  what = x;
  while (hv = $object_utils:has_verb(what, verb))
    what = hv[1];
    i = 1;
    while (i = $code_utils:find_verb_named(what, verb, i))
      if (evs = $code_utils:explain_verb_syntax(x, verb, @verb_args(what, i)))
        player:tell("Try this instead:  ", evs);
        return 1;
      endif
      i = i + 1;
    endwhile
    what = parent(what);
  endwhile
endfor
return 0;
