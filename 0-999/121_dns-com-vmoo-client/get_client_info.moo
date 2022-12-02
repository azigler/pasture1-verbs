#121:get_client_info   this none this rxd

if (!$perm_utils:controls(caller_perms(), this))
  return E_PERM;
else
  info = {};
  for dude in (args)
    if (i = $list_utils:iassoc(dude, this.client_info, 2))
      ticks_left() < 4000 && suspend(0);
      dudeinf = this.client_info[i];
      session = $mcp:session_for(dudeinf[2]);
      if (valid(session) && session:handles_package(this) && `dudeinf[1] >= dude.last_connect_time - 3 ! ANY')
        info = {@info, dudeinf[2..3]};
      endif
    endif
  endfor
  return info;
endif
