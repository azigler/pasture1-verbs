#90:@paste   any any any rx

"Usage: @paste <prefix> <suffix>";
"Announce a series of entered lines to the room the player is in.";
"Before the lines are quoted, player.paste_header is run through";
"$string_utils:pronoun_sub(), and if the result contains the player's";
"name, it is used as a header.  Otherwise player.name centered in a";
"line of dashes is used.";
"A footer comes afterwards, likewise derived from player.paste_footer.";
"<prefix> and <suffix> are placed before and after each line.";
"";
"This verb is, as one might guess, designed for pasting text to MOO using";
"GnuEmacs or a windowing system.  You should remember that after you";
"have pasted the lines in, you must type . on a line by itself, or you'll";
"sit around waiting for $command_utils:read_lines() to finish _forever_.";
{?prefix = "", ?suffix = ""} = args;
lines = $command_utils:read_lines();
header = $string_utils:pronoun_sub_secure($code_utils:verb_or_property(player, "paste_header"), "") || $string_utils:center(player.name, 75, "-");
to_tell = {header};
for line in (lines)
  to_tell = listappend(to_tell, prefix + line + suffix);
endfor
to_tell = listappend(to_tell, $string_utils:pronoun_sub_secure($code_utils:verb_or_property(player, "paste_footer"), "") || $string_utils:center("finished", 75, "-"));
for thing in (player.location.contents)
  $command_utils:suspend_if_needed(0);
  thing:tell_lines(to_tell);
endfor
player:tell("Done @pasting.");
