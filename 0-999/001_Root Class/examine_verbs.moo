#1:examine_verbs   this none this rxd

"Return a list of strings to be told to the player.  Standard format says \"Obvious verbs:\" followed by a series of lines explaining syntax for each usable verb.";
if (caller != this)
  return E_PERM;
endif
who = args[1];
name = dobjstr;
vrbs = {};
commands_ok = `this:examine_commands_ok(who) ! ANY => 0';
dull_classes = {$root_class, $room, $player, $prog, $builder};
what = this;
hidden_verbs = this:hidden_verbs(who);
while (what != $nothing)
  $command_utils:suspend_if_needed(0);
  if (!(what in dull_classes))
    for i in [1..length(verbs(what))]
      $command_utils:suspend_if_needed(0);
      info = verb_info(what, i);
      syntax = verb_args(what, i);
      if (this:examine_verb_ok(what, i, info, syntax, commands_ok, hidden_verbs))
        {dobj, prep, iobj} = syntax;
        if (syntax == {"any", "any", "any"})
          prep = "none";
        endif
        if (prep != "none")
          for x in ($string_utils:explode(prep, "/"))
            if (length(x) <= length(prep))
              prep = x;
            endif
          endfor
        endif
        "This is the correct way to handle verbs ending in *";
        vname = info[3];
        while (j = index(vname, "* "))
          vname = tostr(vname[1..j - 1], "<anything>", vname[j + 1..$]);
        endwhile
        if (vname[$] == "*")
          vname = vname[1..$ - 1] + "<anything>";
        endif
        vname = strsub(vname, " ", "/");
        rest = "";
        if (prep != "none")
          rest = " " + (prep == "any" ? "<anything>" | prep);
          if (iobj != "none")
            rest = tostr(rest, " ", iobj == "this" ? name | "<anything>");
          endif
        endif
        if (dobj != "none")
          rest = tostr(" ", dobj == "this" ? name | "<anything>", rest);
        endif
        vrbs = setadd(vrbs, "  " + vname + rest);
      endif
    endfor
  endif
  what = parent(what);
endwhile
if ($code_utils:verb_or_property(this, "help_msg"))
  vrbs = {@vrbs, tostr("  help ", dobjstr)};
endif
return vrbs && {"Obvious verbs:", @vrbs};
