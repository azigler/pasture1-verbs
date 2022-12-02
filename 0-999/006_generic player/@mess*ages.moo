#6:@mess*ages   any none none rd

set_task_perms(player);
if (dobjstr == "")
  player:notify(tostr("Usage:  ", verb, " <object>"));
  return;
endif
dobj = player:my_match_object(dobjstr);
if ($command_utils:object_match_failed(dobj, dobjstr))
  return;
endif
found_one = 0;
props = $object_utils:all_properties(dobj);
if (typeof(props) == ERR)
  player:notify("You can't read the messages on that.");
  return;
endif
for pname in (props)
  len = length(pname);
  if (len > 4 && pname[len - 3..len] == "_msg")
    found_one = 1;
    msg = `dobj.(pname) ! ANY';
    if (msg == E_PERM)
      value = "isn't readable by you.";
    elseif (!msg)
      value = "isn't set.";
    elseif (typeof(msg) == LIST)
      value = "is a list.";
    elseif (typeof(msg) != STR)
      value = "is corrupted! **";
    else
      value = "is " + $string_utils:print(msg);
    endif
    player:notify(tostr("@", pname[1..len - 4], " ", dobjstr, " ", value));
  endif
endfor
if (!found_one)
  player:notify("That object doesn't have any messages to set.");
endif
