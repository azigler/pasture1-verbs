#45:"is_writable_by is_annotatable_by"   this none this rxd

return $perm_utils:controls(who = args[1], this) || `who in this.writers ! E_TYPE';
