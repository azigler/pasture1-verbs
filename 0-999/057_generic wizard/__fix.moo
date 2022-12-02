#57:__fix   this none this rxd

"...was on $player, now archived here for posterity...";
"Runs the old->new format conversion on every message in this.messages.";
" => 1 if successful";
" => 0 if anything toward happened during a suspension";
"      (e.g., new message received, someone deleted stuff) ";
"      in which case this.messages is left as if this routine were never run.";
if (!$perm_utils:controls(caller_perms(), this))
  return E_PERM;
endif
msgs = {};
i = 1;
for m in (oldmsgs = this.messages)
  msgs = {@msgs, {m[1], $mail_agent:__convert_new(@m[2])}};
  if ($command_utils:running_out_of_time())
    player:notify(tostr("...", i, " ", this));
    suspend(0);
    if (oldmsgs != this.messages)
      return 0;
    endif
  endif
  i = i + 1;
endfor
this.messages = msgs;
return 1;
