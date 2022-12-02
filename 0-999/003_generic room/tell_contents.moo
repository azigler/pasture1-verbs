#3:tell_contents   this none this rxd

{contents, ctype} = args;
if (!this.dark && contents != {})
  if (ctype == 0)
    player:tell("Contents:");
    for thing in (contents)
      player:tell("  ", thing:title());
    endfor
  elseif (ctype == 1)
    for thing in (contents)
      if (is_player(thing))
        player:tell($string_utils:pronoun_sub(tostr("%N ", $gender_utils:get_conj("is", thing), " here."), thing));
      else
        player:tell("You see ", thing:title(), " here.");
      endif
    endfor
  elseif (ctype == 2)
    player:tell("You see ", $string_utils:title_list(contents), " here.");
  elseif (ctype == 3)
    players = things = {};
    for x in (contents)
      if (is_player(x))
        players = {@players, x};
      else
        things = {@things, x};
      endif
    endfor
    if (things)
      player:tell("You see ", $string_utils:title_list(things), " here.");
    endif
    if (players)
      player:tell($string_utils:title_listc(players), length(players) == 1 ? " " + $gender_utils:get_conj("is", players[1]) | " are", " here.");
    endif
    "ZIG: add exits to room desc -- 12/01/2022";
    if (this.exits == {})
      player:tell("This room has no conventional exits.");
    else
      try
        for exit in (this.exits)
          try
            player:tell(exit.name, " (", exit, ") leads to ", valid(exit.dest) ? exit.dest.name | "???", " (", exit.dest, ") via {", $string_utils:from_list(exit.aliases, ", "), "}.");
          except (ANY)
            player:tell("Bad exit or missing .dest property:  ", $string_utils:nn(exit));
            continue exit;
          endtry
        endfor
      except (E_TYPE)
        player:tell("Bad .exits property. This should be a list of exit objects. Please fix this.");
      endtry
    endif
  endif
endif
