#50:init_for_core   this none this rxd

if (caller_perms().wizard)
  pass(@args);
  this:kill_all_sessions();
  if (this == $generic_editor)
    this.help = $help_db["editor"];
  endif
  if ($object_utils:defines_verb(this, "is_not_banned"))
    delete_verb(this, "is_not_banned");
  endif
endif
