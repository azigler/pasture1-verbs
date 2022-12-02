#14:_repair   this none this rx

c = callers();
if (caller != this && !(length(c) > 1 && c[1][1] == $list_utils && c[1][2] == "map_arg" && c[2][1] == this))
  raise(E_PERM);
endif
$command_utils:suspend_if_needed(0);
biglist = this;
propname = args[1];
if (!propname)
  bestlevel = -1;
  best = {};
  for prop in (properties(biglist))
    $command_utils:suspend_if_needed(0);
    if (index(prop, " ") == 1)
      val = biglist.(prop);
      if (typeof(val[1]) == INT)
        if (bestlevel < val[1])
          bestlevel = val[1];
          best = {prop};
        elseif (bestlevel == val[1])
          best = {@best, prop};
        endif
      endif
    endif
  endfor
  if (!best)
    player:notify("Can't find a root.");
    raise(E_INVARG);
  elseif (length(best) == 1)
    propname = best[1];
  else
    propname = best[1];
    val = biglist.(propname);
    for prop in (best[2..$])
      $command_utils:suspend_if_needed(0);
      val[2] = {@val[2], @biglist.(prop)[2]};
    endfor
    biglist.(propname) = val;
    "Now that the new value is safely stored, delete old values.";
    for prop in (best[2..$])
      $command_utils:suspend_if_needed(0);
      player:notify(tostr("Removing property ", toliteral(prop), ".  Its value, ", toliteral(biglist.(prop)), ", has been merged with property ", toliteral(propname), "."));
      delete_property(biglist, prop);
    endfor
  endif
  maxlevel = biglist.(propname)[1];
  player:notify(tostr("Maximum level is ", maxlevel, "."));
  items = $list_utils:make(maxlevel, {});
  "Arrgh.  Even after finding the root, some nodes might be detached!";
  player:notify("Checking for orphans...");
  for prop in (properties(biglist))
    $command_utils:suspend_if_needed(0);
    if (prop && prop[1] == " ")
      val = biglist.(prop);
      if (typeof(val) == LIST && typeof(level = val[1]) == INT && level < maxlevel)
        items[level + 1] = {@items[level + 1], prop};
      endif
    endif
  endfor
  for prop in (properties(biglist))
    $command_utils:suspend_if_needed(0);
    if (prop && prop[1] == " ")
      val = biglist.(prop);
      if (typeof(val) == LIST && typeof(level = val[1]) == INT && level > 0)
        for item in (val[2])
          items[level] = setremove(items[level], item[1]);
        endfor
      endif
    endif
  endfor
  player:notify(tostr("Orphans: ", toliteral(items)));
  backbone_prop = propname;
  level = maxlevel;
  while (level)
    backbone = biglist.(backbone_prop);
    lastkid = backbone_prop;
    for prop in (props = items[level])
      backbone[2] = {@backbone[2], {lastkid = prop, 0, {0, 0}}};
    endfor
    player:notify(tostr("Attaching ", nn = length(props), " propert", nn == 1 ? "y" | "ies", " to property ", toliteral(backbone_prop), "..."));
    biglist.(backbone_prop) = backbone;
    backbone_prop = lastkid;
    level = level - 1;
  endwhile
  player:notify(tostr("Orphans repatriated."));
endif
toplevel = "(top level)";
context = args[2] || toplevel;
"This stuff is just paranoia in case something unexpected is in the data structure.  Normally there should be no blowouts here. --Minnie";
if (typeof(propname) != STR)
  player:notify(tostr("Context=", context, " Prop Name=", toliteral(propname), " -- bad property name."));
  raise(E_INVARG);
endif
val = biglist.(propname);
if (typeof(val) != LIST)
  player:notify(tostr("Context=", context, " Prop Name=", toliteral(propname), " -- contents invalid."));
  raise(E_INVARG);
endif
if (typeof(level = val[1]) != INT)
  player:notify(tostr("Context=", context, " Prop Name=", toliteral(propname), " -- contents invalid (bad first argument)."));
  raise(E_INVARG);
endif
"This is where the real work starts. --Minnie";
"First check that the properties referred to really exist.  This must be done for all levels.";
for item in (val[2])
  try
    biglist.(item[1]);
  except (E_PROPNF)
    player:notify(tostr("Item ", toliteral(item), " is invalid in property ", toliteral(propname), ".  It is being removed."));
    val[2] = setremove(val[2], item);
    continue item;
  endtry
endfor
"Next, only for upper levels, check that the message count for inferior levels is correct, but only after recursing into those levels and making repairs.";
if (level > 0)
  new = $list_utils:map_arg(this, verb, $list_utils:slice(val[2]), propname);
  if (val[2] != new)
    player:notify(tostr("Changing ", toliteral(val[2]), " to ", toliteral(new), "."));
    val[2] = new;
  endif
  "Now that everything is correct, count size of inferiors.";
endif
"Bravely stuff the result back into place.";
biglist.(propname) = val;
"The result will be of the form:                               ";
"  {propname, inferior_msgcount, {first_msgnum, first_time}}  ";
if (level == 0)
  "Count the messages for message count.";
  "Use first message number and time for first_msgnum and first_time.";
  result = {propname, length(val[2]), val[2][1][2..3]};
else
  "Use message count that is sum of inferior counts.";
  "Just propagate first node's first_msgnum and first_time upward literally.";
  n = 0;
  for subnode in (val[2])
    n = n + subnode[2];
  endfor
  result = {propname, n, val[2][1][3]};
endif
if (context == toplevel)
  if (result != biglist.messages)
    biglist.messages = result;
    player:notify(tostr("Property ", biglist, ".messages updated."));
  endif
  player:tell(biglist.messages[2], " messages repaired in ", $mail_agent:name(biglist), ".");
endif
return result;
"Last modified Thu Feb 15 23:13:44 1996 MST by Minnie (#123).";
