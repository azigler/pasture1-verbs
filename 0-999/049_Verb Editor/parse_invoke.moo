#49:parse_invoke   this none this rxd

":parse_invoke(string,v,?code)";
"  string is the commandline string to parse to obtain the obj:verb to edit";
"  v is the actual command verb used to invoke the editor";
" => {object, verbname, verb_code} or error";
if (caller != this)
  raise(E_PERM);
endif
vref = $string_utils:words(args[1]);
if (!vref || !(spec = $code_utils:parse_verbref(vref[1])))
  player:tell("Usage: ", args[2], " object:verb");
  return;
endif
if (argspec = listdelete(vref, 1))
  if (typeof(pas = $code_utils:parse_argspec(@argspec)) == LIST)
    if (pas[2])
      player:tell("I don't understand \"", $string_utils:from_list(pas[2], " "), "\"");
      return;
    endif
    argspec = {@pas[1], "none", "none"}[1..3];
    argspec[2] = $code_utils:full_prep(argspec[2]) || argspec[2];
  else
    player:tell(pas);
    return;
  endif
endif
if (!$command_utils:object_match_failed(match = player:my_match_object(spec[1], this:get_room(player)), spec[1]))
  ancestors = $object_utils:ancestors(match, 1);
  vname = spec[2];
  for object in (ancestors)
    vnum = $code_utils:find_verb_named(object, vname);
    if (argspec)
      while (vnum && this:fetch_verb_args(object, vnum) != argspec)
        vnum = $code_utils:find_verb_named(object, vname, vnum + 1);
      endwhile
    endif
    if (length(args) > 2)
      code = args[3];
    elseif (vnum)
      code = this:fetch_verb_code(object, vnum);
    else
      code = E_VERBNF;
    endif
    if (typeof(code) != ERR)
      if (object in ancestors != 1)
        player:tell("Object ", ancestors[1], " does not define that verb, but its ancestor ", object, " does.");
      endif
      if (!player:edit_option("local") && $edit_utils:get_option("default_editor", player))
        fork (0)
          $edit_utils:editor(code, tostr("[Edit your code; use ", $edit_utils:get_option("cmd_char", player), "compile' to compile.]"), $edit_utils:get_option("cmd_char", player), 1, {{object, vname}});
        endfork
        kill_task(task_id());
      else
        return {object, argspec ? {vname, @argspec} | vname, code};
      endif
    endif
  endfor
endif
player:tell(code != E_VERBNF ? code | "That object does not define that verb", argspec ? " with those args." | ".");
return 0;
