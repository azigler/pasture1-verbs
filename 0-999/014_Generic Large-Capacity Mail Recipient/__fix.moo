#14:__fix   this none this rxd

if (!this:ok_write(caller, caller_perms()))
  return E_PERM;
endif
{?doit = 0} = args;
msgtree = this.messages;
for n in [1..msgtree[2]]
  msg = this._mgr:find_nth(msgtree, n);
  msg = {@msg[1..2], @$mail_agent:__convert_new(@msg[3..$])};
  if (doit)
    msgtree = this._mgr:set_nth(msgtree, n, msg);
  endif
  if ($command_utils:running_out_of_time())
    suspend(0);
    if (this.messages != msgtree)
      player:notify("urk.  someone played with this folder.");
      return 0;
    endif
  endif
endfor
return 1;
