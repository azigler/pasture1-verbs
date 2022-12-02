#46:check_names   this none this rxd

"...make sure the list has at least one usable name.";
"...make sure none of the aliases are already taken.";
{object, @aliases} = args;
if (typeof(object) == STR)
  "... legacy; old version of this verb did not take on OBJ argument";
  aliases = args;
endif
ok = 0;
if (length(aliases) > this.max_list_aliases)
  player:tell("Mailing lists may not have more than ", this.max_list_aliases, " aliases.");
  return 0;
endif
for a in (aliases)
  sub1 = strsub(a, "_", "-");
  sub2 = strsub(a, "-", "_");
  if (sub1 == sub2)
    check = 0;
  else
    check = 1;
  endif
  if (index(a, " "))
  elseif (rp = $mail_agent:reserved_pattern(a))
    player:tell("Mailing list name \"", a, "\" uses a reserved pattern: ", rp[1]);
    return 0;
  elseif (valid(p = $mail_agent:match(a, #-1)) && (p != object && a in p.aliases))
    player:tell("Mailing list name \"", a, "\" in use on ", p.name, "(", p, ")");
    return 0;
  elseif (check && (valid(p = $mail_agent:match(sub1, #-1)) && (p != object && sub1 in p.aliases)))
    player:tell("Mailing list name \"", sub1, "\" in use on ", p.name, "(", p, ")");
    return 0;
  elseif (check && (valid(p = $mail_agent:match(sub2, #-1)) && (p != object && sub2 in p.aliases)))
    player:tell("Mailing list name \"", sub2, "\" in use on ", p.name, "(", p, ")");
    return 0;
  else
    ok = 1;
  endif
endfor
return ok;
