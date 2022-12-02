#88:"@spellm*essages @spellp*roperties"   any any any rd

"@spellproperties <object>";
"@spellmessages <object>";
"Spell checks the string properties of an object, or the subset of said properties which are suffixed _msg, respectively.";
set_task_perms(player);
if (!dobjstr)
  player:notify(tostr("Usage: ", verb, " <object>"));
  return;
elseif ($command_utils:object_match_failed(dobj = player:my_match_object(dobjstr), dobjstr))
  return;
elseif (typeof(props = $object_utils:all_properties(dobj)) == ERR)
  player:notify("Permission denied to read properties on that object.");
  return;
endif
props = setremove(props, "messages");
if (verb[1..7] == "@spellm")
  spell = {};
  for prop in (props)
    if (index(prop, "_msg") == length(prop) - 3 && index(prop, "_msg"))
      spell = {@spell, prop};
    endif
  endfor
  props = spell;
endif
if (props == {})
  player:notify(tostr("No ", verb[1..7] == "@spellm" ? "messages" | "properties", " found to spellcheck on ", dobj, "."));
  return;
endif
for data in (props)
  if (typeof(dd = `dobj.(data) ! ANY') == LIST)
    text = {};
    for linenum in (dd)
      text = listappend(text, linenum);
    endfor
  elseif (typeof(dd) == OBJ || typeof(dd) == INT || typeof(dd) == ERR || typeof(dd) == FLOAT)
    text = "";
  elseif (typeof(dd) == STR)
    text = dd;
  endif
  if (typeof(text) == STR)
    text = {text};
  endif
  linenumber = 0;
  for thisline in (text)
    $command_utils:suspend_if_needed(0);
    linenumber = linenumber + 1;
    if (typeof(thisline) != LIST && typeof(thisline) != OBJ && typeof(thisline) != INT && typeof(thisline) != FLOAT && typeof(thisline) != ERR)
      i = $string_utils:strip_chars(thisline, "!@#$%^&*()_+1234567890={}[]<>?:;,./|\"~'");
      if (i)
        i = $string_utils:words(i);
        for ii in [1..length(i)]
          $command_utils:suspend_if_needed(0);
          if (!$spell:valid(i[ii]))
            if (rindex(i[ii], "s") == length(i[ii]) && $spell:valid(i[ii][1..$ - 1]))
              msg = "Possible match: " + i[ii];
            elseif (rindex(i[ii], "'s") == length(i[ii]) - 1 && $spell:valid(i[ii][1..$ - 2]))
              msg = "Possible match: " + i[ii];
            else
              msg = "Unknown word: " + i[ii];
            endif
            if (length(text) == 1)
              foo = ": ";
            else
              foo = " (line " + tostr(linenumber) + "): ";
            endif
            player:notify(tostr(dobj, ".", data, foo, msg));
          endif
        endfor
      endif
    endif
  endfor
endfor
player:notify(tostr("Done spellchecking ", dobj, "."));
