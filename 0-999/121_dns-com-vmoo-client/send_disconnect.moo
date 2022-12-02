#121:send_disconnect   this none this rxd

{who, @args} = args;
if ($perm_utils:controls(caller_perms(), who))
  if (valid(session = $mcp:session_for(who)) && session:handles_package(this))
    return pass(session, @args);
  else
    return E_INVIND;
  endif
endif
