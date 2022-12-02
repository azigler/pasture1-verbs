#49:"com*pile save"   none any any rd

pas = {{}, {}};
if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
  return;
elseif (!args)
  object = this.objects[who];
  vname = this.verbnames[who];
  if (typeof(vname) == LIST)
    vargs = listdelete(vname, 1);
    vname = vname[1];
  else
    vargs = {};
  endif
  changeverb = 0;
elseif (args[1] != "as" || (length(args) < 2 || (!(spec = $code_utils:parse_verbref(args[2])) || (typeof(pas = $code_utils:parse_argspec(@args[3..$])) != LIST || pas[2]))))
  if (typeof(pas) != LIST)
    player:tell(pas);
  elseif (pas[2])
    player:tell("I don't understand \"", $string_utils:from_list(pas[2], " "), "\"");
  endif
  player:tell("Usage: ", verb, " [as <object>:<verb>]");
  return;
elseif ($command_utils:object_match_failed(object = player:my_match_object(spec[1], this:get_room(player)), spec[1]))
  return;
else
  vname = spec[2];
  vargs = pas[1] && {@pas[1], "none", "none"}[1..3];
  if (vargs)
    vargs[2] = $code_utils:full_prep(vargs[2]) || vargs[2];
  endif
  changeverb = 1;
endif
if (vargs)
  vnum = $code_utils:find_verb_named(object, vname);
  while (vnum && this:fetch_verb_args(object, vnum) != vargs)
    vnum = $code_utils:find_verb_named(object, vname, vnum + 1);
  endwhile
  if (!vnum)
    player:tell("There is no ", object, ":", vname, " verb with args (", $string_utils:from_list(vargs, " "), ").");
    if (!changeverb)
      player:tell("Use 'compile as ...' to write your code to another verb.");
    endif
    return;
  endif
  objverbname = tostr(object, ":", vname, " (", $string_utils:from_list(vargs, " "), ")");
else
  vnum = 0;
  objverbname = tostr(object, ":", $code_utils:toint(vname) == E_TYPE ? vname | this:verb_name(object, vname));
endif
"...";
"...perform eval_subs on verb code if necessary...";
"...";
if (player.eval_subs && player:edit_option("eval_subs"))
  verbcode = {};
  for x in (this:text(who))
    verbcode = {@verbcode, $code_utils:substitute(x, player.eval_subs)};
  endfor
else
  verbcode = this:text(who);
endif
"...";
"...write it out...";
"...";
if (result = this:set_verb_code(object, vnum ? vnum | vname, verbcode))
  player:tell(objverbname, " not compiled because:");
  for x in (result)
    player:tell("  ", x);
  endfor
elseif (typeof(result) == ERR)
  player:tell({result, "You do not have write permission on " + objverbname + ".", "The verb " + objverbname + " does not exist (!?!)", "The object " + tostr(object) + " does not exist (!?!)"}[1 + (result in {E_PERM, E_VERBNF, E_INVARG})]);
  if (!changeverb)
    player:tell("Do 'compile as <object>:<verb>' to write your code to another verb.");
  endif
  changeverb = 0;
else
  player:tell(objverbname, verbcode ? " successfully compiled." | " verbcode removed.");
  this:set_changed(who, 0);
  if ($code_utils:update_last_modified(object, vnum || vname))
    player:notify("** Time-stamping failed.");
  endif
endif
if (changeverb)
  this.objects[who] = object;
  this.verbnames[who] = vargs ? {vname, @vargs} | vname;
endif
