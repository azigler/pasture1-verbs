#87:trivial_check   this none this rxd

if (typeof(pwd = args[1]) != STR)
  return "Passwords must be strings.";
elseif (index(pwd, " "))
  return "Passwords may not contain spaces.";
elseif (length(args) == 2)
  if (typeof(who = args[2]) != OBJ || !valid(who) || !is_player(who))
    return "That's not a player.";
  elseif (!$perm_utils:controls(caller_perms(), who))
    return "You can't set the password for that player.";
  elseif ($object_utils:isa(who, $guest))
    return "Sorry, but guest characters are not allowed to change their passwords.";
  endif
endif
