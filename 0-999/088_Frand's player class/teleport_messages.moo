#88:teleport_messages   this none this rxd

"Send teleport messages. There's a slight complication in that the source and dest need not be valid objects.";
{thing, source, dest, pmsg, smsg, dmsg, tmsg} = args;
if (pmsg)
  "The player's own message.";
  player:tell(pmsg);
endif
if (smsg)
  `source:room_announce_all_but({thing, player}, smsg) ! E_VERBNF, E_INVIND';
endif
if (dmsg)
  `dest:room_announce_all_but({thing, player}, dmsg) ! E_VERBNF, E_INVIND';
endif
if (tmsg)
  "A message to the victim being teleported.";
  thing:tell(tmsg);
endif
