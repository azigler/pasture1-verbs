#88:"oself_port_msg self_arrive_msg oplayer_port_msg player_arrive_msg victim_port_msg othing_port_msg thing_arrive_msg object_port_msg"   this none this rxd

"This verb returns messages that go to other players. It does pronoun substitutions; if your name is not included in the final string, it adds the name in front.";
msg = this.(verb);
if (!msg)
  msg = $frand_class.(verb);
endif
if (length(args) >= 3)
  msg = this:msg_sub(msg, @args);
endif
if (!$string_utils:index_delimited(msg, player.name))
  msg = player.name + " " + msg;
endif
return msg;
