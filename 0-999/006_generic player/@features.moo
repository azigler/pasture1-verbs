#6:@features   any (for/about) any rxd

"Usage:  @features [<name>] for <player>";
"List the feature objects matching <name> used by <player>.";
if (!iobjstr)
  player:tell("Usage: @features [<name>] for <player>");
  return;
elseif ($command_utils:player_match_failed(whose = $string_utils:match_player(iobjstr), iobjstr))
  return;
endif
features = {};
for feature in (whose.features)
  if (!valid(feature))
    whose:remove_feature(feature);
  elseif (!dobjstr || (dobjstr in feature.aliases || ((pref = $string_utils:find_prefix(dobjstr, feature.aliases)) || pref == $ambiguous_match)))
    features = listappend(features, feature);
  endif
endfor
if (features)
  len = max(length("Feature"), length(tostr(max_object()))) + 1;
  player:tell($string_utils:left("Feature", len), "Name");
  player:tell($string_utils:left("-------", len), "----");
  for feature in (features)
    player:tell($string_utils:left(tostr(feature), len), feature.name);
  endfor
  player:tell($string_utils:left("-------", len), "----");
  cstr = tostr(length(features)) + " feature" + (length(features) > 1 ? "s" | "") + " found";
  if (whose != this)
    cstr = cstr + " on " + whose.name + " (" + tostr(whose) + ")";
  endif
  if (dobjstr)
    cstr = cstr + " matching \"" + dobjstr + "\"";
  endif
  cstr = cstr + ".";
  player:tell(cstr);
elseif (dobjstr)
  player:tell("No features found on ", whose.name, " (", whose, ") matching \"", dobjstr, "\".");
else
  player:tell("No features found on ", whose.name, " (", whose, ").");
endif
