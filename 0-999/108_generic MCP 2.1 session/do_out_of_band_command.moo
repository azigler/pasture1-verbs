#108:do_out_of_band_command   this none this rxd

if (caller != $mcp)
  raise(E_PERM);
else
  set_task_perms(caller_perms());
  if (`player.MCP_snoop ! ANY')
    player:tell("C->S: ", argstr);
  endif
  if (message = $mcp.parser:parse(argstr, @args))
    this:dispatch(@message);
  endif
endif
