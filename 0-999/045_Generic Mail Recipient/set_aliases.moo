#45:set_aliases   this none this rxd

"For changing mailing list aliases, we check to make sure that none of the aliases match existing mailing list aliases.  Aliases containing spaces are not used in addresses and so are not subject to this restriction ($mail_agent:match will not match on them, however, so they only match if used in the immediate room, e.g., with match_object() or somesuch).";
"  => E_PERM   if you don't own this";
{newaliases} = args;
if (caller != this && !$perm_utils:controls(caller_perms(), this))
  return E_PERM;
elseif (this.location != $mail_agent)
  "... we don't care...";
  return pass(@args);
elseif (length(newaliases) > $mail_agent.max_list_aliases)
  return E_QUOTA;
else
  for a in (aliases = newaliases)
    if (index(a, " "))
      "... we don't care...";
    elseif (rp = $mail_agent:reserved_pattern(a))
      player:tell("Mailing list name \"", a, "\" uses a reserved pattern: ", rp[1]);
      aliases = setremove(aliases, a);
    elseif (valid(p = $mail_agent:match(a, #-1)) && (p != this && a in p.aliases))
      player:tell("Mailing list name \"", a, "\" in use on ", p.name, "(", p, ")");
      aliases = setremove(aliases, a);
    endif
  endfor
  return pass(aliases) && newaliases == aliases;
endif
