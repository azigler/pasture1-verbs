#132:broadcast   this none this xd

":broadcast(message, audience): Tell all members of audience a message.";
{msg, ?audience = $logger.default_log_audience} = args;
plrs = connected_players();
for p in (plrs)
  if (audience == 4 && !p.wizard || (audience == 3 && !p.programmer) || (audience == 2 && !$object_utils:isa(p, $builder)))
    plrs = setremove(plrs, p);
  endif
endfor
if (plrs)
  for p in (plrs)
    p:tell(msg);
  endfor
endif
"Last modified Mon Mar 12 04:26:30 2018 CDT by Jason Perino (#91@ThetaCore).";
