#1:set_name   this none this rxd

"set_name(newname) attempts to change this.name to newname";
"  => E_PERM   if you don't own this or aren't its parent, or are a player trying to do an end-run around $player_db...";
if (!caller_perms().wizard && (`is_player(this) ! ANY => 0' || (caller_perms() != this.owner && this != caller)))
  return E_PERM;
else
  return typeof(e = `this.name = args[1] ! ANY') != ERR || e;
endif
