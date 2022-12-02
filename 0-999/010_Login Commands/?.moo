#10:?   any none any rxd

if (caller != #0 && caller != this)
  return E_PERM;
else
  clist = {};
  for j in ({this, @$object_utils:ancestors(this)})
    for i in [1..length(verbs(j))]
      if (verb_args(j, i) == {"any", "none", "any"} && index((info = verb_info(j, i))[2], "x"))
        vname = $string_utils:explode(info[3])[1];
        star = index(vname + "*", "*");
        clist = {@clist, $string_utils:uppercase(vname[1..star - 1]) + strsub(vname[star..$], "*", "")};
      endif
    endfor
  endfor
  notify(player, "I don't understand that.  Valid commands at this point are");
  notify(player, "   " + $string_utils:english_list(setremove(clist, "?"), "", " or "));
  return 0;
endif
