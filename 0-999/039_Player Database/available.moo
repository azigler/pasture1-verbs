#39:available   this none this rxd

":available(name,who) => 1 if a name is available for use, or the object id of whoever is currently using it, or 0 if the name is otherwise forbidden.";
"If $player_db is not .frozen and :available returns 1, then $player:set_name will succeed.";
{name, ?target = valid(caller) ? caller | player} = args;
if (name in this.stupid_names || name in this.reserved)
  return 0;
elseif (target in $wiz_utils.rename_restricted)
  return 0;
elseif (!name || index(name, " ") || index(name, "\\") || index(name, "\"") || index(name, "	"))
  return 0;
elseif (index("*#()", name[1]))
  return 0;
elseif (match(name, "(#[0-9]+)"))
  return 0;
elseif (valid(who = this:find_exact(name)) && is_player(who))
  return who;
elseif ($object_utils:has_callable_verb($local, "legal_name") && !$local:legal_name(name, target))
  return 0;
else
  return 1;
endif
