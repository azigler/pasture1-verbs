#6:@sw*eep   none none none rd

buggers = 1;
found_listener = 0;
here = this.location;
for thing in (setremove(here.contents, this))
  tellwhere = $object_utils:has_verb(thing, "tell");
  notifywhere = $object_utils:has_verb(thing, "notify");
  if (thing in connected_players())
    this:notify(tostr(thing.name, " (", thing, ") is listening."));
    found_listener = 1;
  elseif ($object_utils:has_callable_verb(thing, "sweep_msg") && typeof(msg = thing:sweep_msg()) == STR)
    this:notify(tostr(thing.name, " (", thing, ") ", msg, "."));
    found_listener = 1;
  elseif (tellwhere && ((owner = verb_info(tellwhere[1], "tell")[1]) != this && !owner.wizard))
    this:notify(tostr(thing.name, " (", thing, ") has been taught to listen by ", owner.name, " (", owner, ")"));
    found_listener = 1;
  elseif (notifywhere && ((owner = verb_info(notifywhere[1], "notify")[1]) != this && !owner.wizard))
    this:notify(tostr(thing.name, " (", thing, ") has been taught to listen by ", owner.name, " (", owner, ")"));
    found_listener = 1;
  endif
endfor
buggers = {};
for v in ({"announce", "announce_all", "announce_all_but", "say", "emote", "huh", "here_huh", "huh2", "whisper", "here_explain_syntax"})
  vwhere = $object_utils:has_verb(here, v);
  if (vwhere && ((owner = verb_info(vwhere[1], v)[1]) != this && !owner.wizard))
    buggers = setadd(buggers, owner);
  endif
endfor
if (buggers != {})
  if ($object_utils:has_verb(here, "sweep_msg") && typeof(msg = here:sweep_msg()) == STR)
    this:notify(tostr(here.name, " (", here, ") ", msg, "."));
  else
    this:notify(tostr(here.name, " (", here, ") may have been bugged by ", $string_utils:english_list($list_utils:map_prop(buggers, "name")), "."));
  endif
elseif (!found_listener)
  this:notify("Communications look secure.");
endif
