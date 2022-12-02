#81:can_peek   this none this rxd

"Is args[1] permitted to examine args[2]'s quota information?";
return $perm_utils:controls(args[1], args[2]);
