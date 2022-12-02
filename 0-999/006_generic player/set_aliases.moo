#6:set_aliases   this none this rxd

"set_aliases(alias_list)";
"For changing player aliases, we check to make sure that none of the aliases match existing player names/aliases.  Aliases containing spaces are not entered in the $player_db and so are not subject to this restriction ($string_utils:match_player will not match on them, however, so they only match if used in the immediate room, e.g., with match_object() or somesuch).";
"Also we make sure that the .name is included in the .alias list.  In any situation where .name and .aliases are both being changed, do the name change first.";
"  => 1        if successful, and aliases changed from previous setting.";
"  => 0        if resulting work didn't change aliases from previous.";
"  => E_PERM   if you don't own this";
"  => E_NACC   if the player database is not taking new aliases right now.";
"  => E_TYPE   if alias_list is not a list";
"  => E_INVARG if any element of alias_list is not a string";
if (!($perm_utils:controls(caller_perms(), this) || this == caller))
  return E_PERM;
elseif (!is_player(this))
  "we don't worry about the names of player classes.";
  return pass(@args);
elseif ($player_db.frozen)
  return E_NACC;
elseif (typeof(aliases = args[1]) != LIST)
  return E_TYPE;
elseif (length(aliases = setadd(aliases, this.name)) > ($object_utils:has_property($local, "max_player_aliases") ? $local.max_player_aliases | $maxint) && length(aliases) >= length(this.aliases))
  return E_INVARG;
else
  for a in (aliases)
    if (typeof(a) != STR)
      return E_INVARG;
    endif
    if (!(index(a, " ") || index(a, "	")) && !($player_db:available(a, this) in {this, 1}))
      aliases = setremove(aliases, a);
    endif
  endfor
  old = this.aliases;
  this.aliases = aliases;
  for a in (old)
    if (!(a in aliases))
      $player_db:delete2(a, this);
    endif
  endfor
  for a in (aliases)
    if (!(index(a, " ") || index(a, "	")))
      $player_db:insert(a, this);
    endif
  endfor
  return this.aliases != old;
endif
