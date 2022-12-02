#8:is_openable_by   this none this rxd

return this.open_key == 0 || $lock_utils:eval_key(this.open_key, args[1]);
