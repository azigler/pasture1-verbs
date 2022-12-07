#130:"chat @chat"   any any any rx

text = argstr;
for user in (connected_players())
  user:tell(player:title() + " says to the whole MOO, \"" + text + "\"");
  user != player && user:add_replay_entry({"general", "chat"}, player:title() + " says to the whole MOO, \"" + text + "\"");
endfor
player:add_replay_entry({"general", "chat"}, "You say to the whole MOO, \"" + text + "\"");
"Last modified Wed Dec  7 17:00:57 2022 UTC by caranov (#133).";
