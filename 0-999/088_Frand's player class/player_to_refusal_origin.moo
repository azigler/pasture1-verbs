#88:player_to_refusal_origin   this none this rxd

"'player_to_refusal_origin (<player>)' -> <origin> - Convert a player to a unique identifier called the player's 'refusal origin'. For most players, it's just their object number. For guests, it is a hash of the site they are connecting from. Converting an origin to an origin is a safe no-op--the code relies on this.";
set_task_perms(caller_perms());
{who} = args;
if (typeof(who) == OBJ && valid(who) && parent(who) == `$local.guest ! E_PROPNF, E_INVIND => $guest')
  return who:connection_name_hash("xx");
else
  return who;
endif
