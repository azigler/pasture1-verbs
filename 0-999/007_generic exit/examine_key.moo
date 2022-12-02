#7:examine_key   this none this rxd

"examine_key(examiner)";
"return a list of strings to be told to the player, indicating what the key on this type of object means, and what this object's key is set to.";
"the default will only tell the key to a wizard or this object's owner.";
who = args[1];
if (caller == this && $perm_utils:controls(who, this) && this.key != 0)
  return {tostr(this:title(), " will only transport objects matching this key:"), tostr("  ", $lock_utils:unparse_key(this.key))};
endif
