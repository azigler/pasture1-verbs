#45:set_name   this none this rxd

{name} = args;
if (caller != this && !$perm_utils:controls(caller_perms(), this))
  return E_PERM;
elseif (this.location != $mail_agent)
  "... we don't care...";
  return pass(@args);
elseif (index(name, " "))
  "... we don't care...";
elseif (rp = $mail_agent:reserved_pattern(name))
  player:tell("Mailing list name \"", a, "\" uses a reserved pattern: ", rp[1]);
  return 0;
elseif (valid(p = $mail_agent:match(name, #-1)) && (p != this && name in p.aliases))
  player:tell("Mailing list name \"", name, "\" in use on ", p.name, "(", p, ")");
  return 0;
endif
return pass(name);
