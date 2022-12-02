#57:@corify   any as any rd

"Usage:  @corify <object> as <propname>";
"Adds <object> to the core, as $<propname>";
"Reminds the wizard to write an :init_for_core verb, if there isn't one already.";
if (!player.wizard)
  player:tell("Sorry, the core is wizardly territory.");
  return;
endif
if (dobj == $failed_match)
  dobj = player:my_match_object(dobjstr);
endif
if ($command_utils:object_match_failed(dobj, dobjstr))
  return;
endif
if (!iobjstr)
  player:tell("Usage:  @corify <object> as <propname>");
  return;
elseif (iobjstr[1] == "$")
  iobjstr = iobjstr[2..$];
endif
try
  add_property(#0, iobjstr, dobj, {player, "r"});
except e (ANY)
  return player:tell(e[1], ":", e[2]);
endtry
if (!("init_for_core" in verbs(dobj)))
  player:tell(dobj:titlec(), " has no :init_for_core verb.  Strongly consider adding one before doing anything else.");
else
  player:tell("Corified ", $string_utils:nn(dobj), " as $", iobjstr, ".");
endif
