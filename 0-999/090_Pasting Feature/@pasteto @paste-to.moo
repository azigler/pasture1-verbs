#90:"@pasteto @paste-to"   any none none rxd

"Syntax: @paste-to <player>";
"";
"Which will then prompt you for the lines to privately send to <player>. The lines will be surrounded by a default footer and header.";
target = $string_utils:match_player(dobjstr);
$command_utils:player_match_result(target, dobjstr);
if (!valid(target))
  return;
endif
prefix = "";
suffix = "";
lines = $command_utils:read_lines();
to_tell = {$string_utils:center("Private message from " + player.name, 75, "-")};
for line in (lines)
  to_tell = listappend(to_tell, prefix + line + suffix);
endfor
to_tell = listappend(to_tell, $string_utils:center("end message", 75, "-"));
target:tell_lines(to_tell);
player:tell("Done @pasting.");
