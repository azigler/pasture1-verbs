#6:set_name   this none this rxd

"set_name(newname) attempts to change this.name to newname";
"  => E_PERM   if you don't own this";
"  => E_INVARG if the name is already taken or prohibited for some reason";
"  => E_NACC   if the player database is not taking new names right now.";
"  => E_ARGS   if the name is too long (controlled by $login.max_player_name)";
"  => E_QUOTA  if the player is not allowed to change eir name.";
if (!($perm_utils:controls(caller_perms(), this) || this == caller))
  return E_PERM;
elseif (!is_player(this))
  "we don't worry about the names of player classes.";
  set_task_perms(caller_perms());
  return pass(@args);
elseif ($player_db.frozen)
  return E_NACC;
elseif (length(name = args[1]) > $login.max_player_name)
  return E_ARGS;
elseif (!($player_db:available(name, this) in {this, 1}))
  return E_INVARG;
else
  old = this.name;
  this.name = name;
  if (name != old && !(old in this.aliases))
    $player_db:delete(old);
  endif
  $player_db:insert(name, this);
  return 1;
endif
