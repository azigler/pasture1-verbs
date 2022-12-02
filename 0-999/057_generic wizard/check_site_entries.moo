#57:check_site_entries   this none this rxd

"Called by @[un]<color>list to check existence of the target site.";
"=> {done okay, LIST of sites to remove}";
if (caller != this)
  return E_PERM;
endif
{undo, which, target, is_literal, entrylist} = args;
rm = {};
confirm = 0;
if (is_literal)
  for s in (entrylist)
    if ((i = index(s, target + ".")) == 1)
      "... target is a prefix of s, s should probably go...";
      rm = {@rm, s};
    elseif (index(target + ".", s + ".") != 1)
      "... s is not a prefix of target...";
    elseif (undo)
      player:notify(tostr("You will need to un", which, " subnet ", s, " as well."));
    elseif (confirm)
      player:notify(tostr("...Subnet ", s, " already ", which, "ed..."));
    else
      player:notify(tostr("Subnet ", s, " already ", which, "ed."));
      if (!(confirm = $command_utils:yes_or_no(tostr(which, " ", target, " anyway?"))))
        return {0, {}};
      endif
    endif
  endfor
else
  for s in (entrylist)
    if ((i = rindex(s, "." + target)) && i == length(s) - length(target))
      "... target is a suffix of s, s should probably go...";
      rm = {@rm, s};
    elseif (!(i = rindex("." + target, "." + s)) || i < length(target) - length(s) + 1)
      "... s is not a suffix of target...";
    elseif (undo)
      player:notify(tostr("You will need to un", which, " domain `", s, "' as well."));
    elseif (confirm)
      player:notify(tostr("...Domain `", s, "' already ", which, "ed..."));
    else
      player:notify(tostr("Domain `", s, "' already ", which, "ed."));
      if (!(confirm = $command_utils:yes_or_no(tostr(which, " ", target, " anyway?"))))
        return {0, {}};
      endif
    endif
  endfor
endif
return {1, rm};
