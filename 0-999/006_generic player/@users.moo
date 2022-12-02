#6:@users   none none none rxd

"Prints a count and compact list of the currently-connected players, sorted into columns.";
cp = connected_players();
linelen = player:linelen() || 79;
player:tell("There are " + tostr(length(cp)) + " players connected:");
dudes = $list_utils:map_prop(cp, "name");
dudes = $list_utils:sort_suspended($login.current_lag, dudes);
player:tell_lines($string_utils:columnize(dudes, 4, linelen));
