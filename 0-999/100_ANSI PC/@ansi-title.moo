#100:@ansi-title   any any any rd

"Usage:";
"  @ansi-title                 - Displays your current ANSI title settings";
"  @ansi-title <name>          - Displays the title you have set for <name>";
"  @ansi-title <name> is <new> - Sets <new> as the title for <name>";
"  @ansi-title is <new>        - Sets <new> as the title for your current name";
name = dobjstr || this.name;
if (player != this)
  player:tell(E_PERM);
elseif (!argstr)
  if (typeof(this.ansi_title) != LIST)
    player:notify("Your ANSI title seems to be screwed up, resetting it.");
    this:set_ansi_title({});
  elseif (!this.ansi_title)
    player:notify("You don't have any ANSI titles set.");
  else
    player:notify("Current ANSI title substrings:");
    l = player:linelen() - 21;
    for x in (this.ansi_title)
      z = $generic_editor:fill_string($string_utils:english_list(typeof(x[2]) == LIST ? x[2] | {x[2]}), l);
      player:notify(tostr("   ", $string_utils:left(x[1], 15), " - ", z[1]));
      for i in (listdelete(z, 1))
        player:notify("                     " + i);
      endfor
    endfor
    player:notify(tostr("Your current name is set to ", $ansi_utils:ansi_title(player), "."));
  endif
elseif (iobjstr && prepstr != "is")
  player:notify_lines($code_utils:verb_documentation());
elseif (!prepstr)
  if (i = $list_utils:assoc(name, this.ansi_title))
    player:notify(tostr("The substring ", name, " will be replaced with ", i[2], "."));
  else
    player:notify(tostr("There is no set replacement for the substring ", name, "."));
  endif
elseif ($ansi_utils:contains_codes(name))
  player:notify("The replacement string shouldn't contain ANSI codes.");
else
  at = this.ansi_title;
  i = $list_utils:iassoc(name, at);
  if (iobjstr)
    if (i)
      at[i][2] = iobjstr;
    else
      at = listappend(at, {name, iobjstr});
    endif
  elseif (i)
    at = listdelete(at, i);
  endif
  if (typeof(result = this:set_ansi_title(at)) != ERR)
    if (iobjstr)
      player:notify(tostr("Substring ", name, " will be replaced with ", iobjstr, "."));
    else
      player:notify(tostr("Cleared substring ", name, "."));
    endif
  elseif (result == E_NACC)
    player:notify("The replacement string must be the same as the string replaced except for the ANSI strings.");
  else
    player:notify(tostr("Error: ", result));
  endif
endif
