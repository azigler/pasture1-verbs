#9:decrypt   this none none rd

set_task_perms(player);
try
  dobj.encryption_key = 0;
  player:tell("Decrypted ", dobj.name, ".");
except error (ANY)
  player:tell(error[2], ".");
endtry
