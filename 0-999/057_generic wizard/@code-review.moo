#57:@code-review   any none none xd

if (!player.wizard || player != this)
  return $command_utils:do_huh();
endif
if (!args)
  return player:Tell("Usage: ", verb, " <player>");
endif
plyr = $string_utils:match_player(argstr);
if ($command_utils:player_match_failed(plyr, argstr))
  return;
endif
start = ftime(1);
totals = ["lines" -> 0, "verbs" -> 0, "objects" -> {}];
for o in [#0..max_object()]
  if (!valid(o) || length(verbs(o)) == 0)
    continue;
  endif
  lines = verbs = 0;
  " TODO: Make this denote programmed/unprogrammed verbs.";
  if (verbs(o))
    for v in (verbs(o))
      if (verb_info(o, v)[1] == plyr)
        verbs = verbs + 1;
        lines = lines + $code_utils:rmll(verb_code(o, v)):length();
        yin();
      endif
    endfor
    if (lines && verbs)
      totals["lines"] = totals["lines"] + lines;
      totals["verbs"] = totals["verbs"] + verbs;
      totals["objects"] = totals["objects"]:add({o, lines, verbs});
      yin();
    endif
  endif
endfor
l = "--------------------";
breakdown = {{"Object", "Lines of Code", "Number of Verbs"}};
for x in (totals["objects"])
  breakdown = breakdown:append({$string_utils:nn(x[1]), tostr(x[2]), tostr(x[3])});
  yin();
endfor
breakdown = $string_utils:fit_to_screen(breakdown, 2, 1);
player:tell("Code review for ", plyr:nn(), ":");
player:tell(l);
player:tell("Total Lines of Code: ", totals["lines"]);
player:tell("Total Number of Owned Verbs: ", totals["verbs"]);
player:tell(l);
player:tell("Object Breakdown:");
player:tell(l);
player:tell_lines_suspended(breakdown);
player:tell(l);
finished = ftime(1) - start;
player:tell("Done.  [finished in ", floatstr(finished, 4), " seconds]");
"Last modified Wed Dec  7 17:45:04 2022 UTC by Saeed (#128).";
