#47:who   any none none rxd

if (dobjstr)
  if (!(recips = this:parse_recipients({}, args)))
    "parse_recipients has already complained about anything it doesn't like";
    return;
  endif
elseif (caller != player)
  return E_PERM;
elseif (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
  return;
else
  recips = this.recipients[who];
endif
resolve = $mail_agent:resolve_addr(recips, player);
if (resolve[1])
  player:tell("Bogus addresses:  ", $string_utils:english_list(resolve[1]));
else
  player:tell(dobjstr ? "Mail to " + $mail_agent:name_list(@recips) + " actually goes to " | "Your mail will actually go to ", $mail_agent:name_list(@resolve[2]));
endif
