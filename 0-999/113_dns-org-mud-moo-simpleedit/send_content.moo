#113:send_content   this none this rxd

"Usage:  :send_content()";
"";
if ($perm_utils:controls(caller_perms(), args[1]))
  pass(@args);
else
  raise(E_PERM);
endif
