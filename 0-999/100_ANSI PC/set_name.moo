#100:set_name   this none this rxd

"This makes sure that people don't have color codes in their name. They shouldn't, anyway since it makes it hard to identify them (especially if they use black.)";
if (!($perm_utils:controls(caller_perms(), this) || caller == this))
  return E_PERM;
elseif (!is_player(this))
  "we don't worry about the names of player classes.";
  return pass(@args);
elseif ((name = args[1]) != $ansi_utils:delete(name))
  player:notify("Sorry, you can't have color codes in your name. It messes up the db listings and people might not know how to address you if you didn't have your normal name as an alias. You can make a :title, though.");
  return E_INVARG;
else
  return pass(@args);
endif
