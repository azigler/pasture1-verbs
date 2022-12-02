#9:is_readable_by   this none this rxd

key = this.encryption_key;
return key == 0 || $lock_utils:eval_key(key, args[1]);
