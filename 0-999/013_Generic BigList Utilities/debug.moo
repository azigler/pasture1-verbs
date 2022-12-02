#13:debug   this none this rxd

return $perm_utils:controls(caller_perms(), this) ? this:(args[1])(@listdelete(args, 1)) | E_PERM;
