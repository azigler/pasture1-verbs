#89:"`* -* to*"   any any any rxd

"Say something out loud, directed at someone or something.";
"Usage:";
"  `target message";
"Example:";
"  Munchkin is talking to Kenneth, who's in the same room with him.  He types:";
"      `kenneth What is the frequency?";
"  The room sees:";
"       Munchkin [to Kenneth]: What is the frequency?";
name = verb[2..$];
who = player.location:match_object(name);
if ($command_utils:object_match_failed(who, name))
  return;
endif
player.location:announce_all(player.name, " [to ", who.name, "]: ", argstr);
