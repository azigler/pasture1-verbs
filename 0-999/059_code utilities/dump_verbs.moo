#59:dump_verbs   this none this rxd

":dump_verbs (object, create_flag): returns the list of strings representing the verb information for this object in @dump format.";
set_task_perms(caller_perms());
{dobj, create, ?targname = tostr(dobj)} = args;
result = {};
v = 1;
while ((info = `verb_info(dobj, v) ! ANY') || info == E_PERM)
  if (`index(info[3], "(old)") ! ANY' && 0)
    "Thought about skipping (old) verbs...";
    player:tell("Skipping ", dobj, ":\"", info[3], "\"...");
  else
    if (typeof(info) == ERR)
      result = {@result, tostr("\"", dobj, ":", v, " --- ", info, "\";")};
    else
      if (i = index(vname = info[3], " "))
        vname = vname[1..i - 1];
      endif
      if (vname[1] != "*")
        vname = strsub(vname, "*", "");
      endif
      args = verb_args(dobj, v);
      prep = args[2] in {"any", "none"} ? args[2] | $code_utils:short_prep(args[2]);
      perms = info[2] != (args == {"this", "none", "this"} ? "rxd" | "rd") ? info[2] || "\"\"" | "";
      if (create)
        if (info[1] == dobj.owner)
          tail = perms ? tostr(" ", perms) | "";
        else
          tail = tostr(" ", perms || info[2], " ", info[1]);
        endif
        result = {@result, tostr("@verb ", targname, ":\"", info[3], "\" ", args[1], " ", prep, " ", args[3], tail)};
      else
        result = {@result, tostr("@args ", targname, ":\"", info[3], "\" ", args[1], " ", prep, " ", args[3])};
        if (info[1] != dobj.owner)
          result = {@result, tostr("@chown ", targname, ":", vname, " ", info[1])};
        endif
        if (perms)
          result = {@result, tostr("@chmod ", targname, ":", vname, " ", perms)};
        endif
      endif
      if (code = verb_code(dobj, v, 1, 1))
        result = {@result, tostr("@program ", targname, ":", vname), @code, ".", ""};
      endif
    endif
  endif
  if (`index(tostr(" ", info[3], " "), " * ") ! ANY')
    "... we have a * verb.  may as well forget trying to list...";
    "... the rest; they're invisible.  set v to something nonstring.";
    v = E_TYPE;
  else
    v = v + 1;
  endif
  $command_utils:suspend_if_needed(0);
endwhile
return result;
