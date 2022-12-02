#58:@dump   any any any rd

"@dump something [with [id=...] [noprops] [noverbs] [create]]";
"This spills out all properties and verbs on an object, calling suspend at appropriate intervals.";
"   id=#nnn -- specifies an idnumber to use in place of the object's actual id (for porting to another MOO)";
"   noprops -- don't show properties.";
"   noverbs -- don't show verbs.";
"   create  -- indicates that a @create command should be generated and all of the verbs be introduced with @verb rather than @args; the default assumption is that the object already exists and you're just doing this to have a look at it.";
set_task_perms(player);
dobj = player:my_match_object(dobjstr);
if ($command_utils:object_match_failed(dobj, dobjstr))
  return;
endif
if (prepstr && prepstr != "with")
  player:notify(tostr("Usage:  ", verb, " something [with [id=...] [noprops] [noverbs] [create]]"));
  return;
endif
targname = tostr(dobj);
options = {"props", "verbs"};
create = 0;
if (iobjstr)
  for o in ($string_utils:explode(iobjstr))
    if (index(o, "id=") == 1)
      targname = o[4..$];
    elseif (o in {"noprops", "noverbs"})
      options = setremove(options, o[3..$]);
    elseif (o in {"create"})
      create = 1;
    else
      player:notify(tostr("`", o, "' not understood as valid option."));
      player:notify(tostr("Usage:  ", verb, " something [with [id=...] [noprops] [noverbs] [create]]"));
      return;
    endif
  endfor
endif
$ansi_utils:add_noansi();
if (create)
  player:notify($code_utils:dump_preamble(dobj));
endif
if ("props" in options)
  player:notify_lines_suspended($code_utils:dump_properties(dobj, create, targname));
endif
if (!("verbs" in options))
  player:notify("\"***finished***");
  return;
endif
player:notify("");
player:notify_lines_suspended($code_utils:dump_verbs(dobj, create, targname));
player:notify("\"***finished***");
$ansi_utils:remove_noansi();
