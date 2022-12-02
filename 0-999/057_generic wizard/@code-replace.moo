#57:@code-replace   none none none rd

if (!player.wizard)
  return E_PERM;
endif
set_task_perms(player);
player:tell("What string are you replacing?");
old = $command_utils:read();
if (old == "")
  return player:tell("You can't replace an empty string.");
endif
player:tell("What string are you replacing it with?");
new = $command_utils:read();
if (new == "")
  return player:tell("You can't replace it with an empty string.");
endif
if ($command_utils:yes_or_no(tostr("You are about to replace ", old, " with ", new, " in all verbs. Are you sure you want to do this? Be very sure.")) == 1)
  player:tell("Working...");
  total = 0;
  for o in [#0..max_object()]
    yin();
    if (!valid(o))
      continue;
    endif
    verbs = verbs(o);
    if (verbs == {})
      continue;
    endif
    for v in (verbs)
      code = verb_code(o, v);
      replaced = 0;
      old_line = new_line = {};
      for l in [1..length(code)]
        yin();
        if (!index(code[l], old))
          continue;
        endif
        old_line = {@old_line, code[l]};
        code[l] = strsub(code[l], old, new);
        new_line = {@new_line, code[l]};
        replaced = replaced + 1;
      endfor
      "Try to compile the new code if it has any replaced lines.";
      if (replaced)
        result = set_verb_code(o, v, code);
        if (typeof(result) == ERR)
          player:tell("Could not compile code for ", $string_utils:nn(o), ":", v, ". ", toliteral(result));
        else
          player:tell("... replaced code in ", o, ":", v, ":");
          for pew in [1..length(old_line)]
            player:tell("   ", old_line[pew]);
            player:tell("   ", new_line[pew]);
          endfor
          total = total + 1;
        endif
      endif
      yin();
    endfor
    yin();
  endfor
  player:tell("Done. ", total, " verbs replaced.");
else
  return player:tell("Aborted.");
endif
