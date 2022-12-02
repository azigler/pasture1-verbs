#17:display_seq_headers   this none this rxd

":display_seq_headers(msg_seq[,cur])";
if (!this:ok(caller, caller_perms()))
  return E_PERM;
endif
player:tell("       WHEN    BY        WHO                 EMAIL-ADDRESS");
pass(@args);
