#1:is_unlocked_for   this none this rxd

return this.key == 0 || $lock_utils:eval_key(this.key, args[1]);
