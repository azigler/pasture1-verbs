#100:set_aliases   this none this rxd

"This makes sure that people don't have color codes in their aliases. They shouldn't, anyway since it makes it hard to identify them (especially if they use black.)";
if (!($perm_utils:controls(caller_perms(), this) || caller == this))
  return E_PERM;
elseif (!is_player(this))
  "we don't worry about the names of player classes.";
  return pass(@args);
else
  for name in (aliases = args[1])
    if (name != $ansi_utils:delete(name))
      aliases = setremove(aliases, name);
    endif
  endfor
  if (aliases != args[1])
    player:notify("Sorry, you can't have color codes in your aliases.");
  endif
  return pass(aliases);
endif
