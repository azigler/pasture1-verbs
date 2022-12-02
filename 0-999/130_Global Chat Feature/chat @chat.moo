#130:"chat @chat"   any any any rx

text = argstr;
for user in (connected_players())
  user:tell(player:title() + " says to the whole MOO, \"" + text + "\"");
endfor
