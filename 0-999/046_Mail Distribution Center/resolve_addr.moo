#46:resolve_addr   this none this rxd

"resolve(name,from,seen,prevrcpts,prevnotifs) => {rcpts,notifs} or E_INVARG";
"resolve(list,from,seen,prevrcpts,prevnotifs) => {bogus,rcpts,notifs}";
"Given either an address (i.e., objectid) or a list of such, traces down all .mail_forward lists and .mail_notify to determine where a message should actually go and who should be told about it.  Both forms take previous lists of recipients/notifications and add only those addresses that weren't there before.  `seen' is the stack of addresses we are currently resolving (for detecting loops).  The first form returns E_INVARG if `name' is invalid.  The second form returns all invalid addresses in the `bogus' list but still does the appropriate search on the remaining addresses.";
{recip, from, ?seen = {}, ?prevrcpts = {}, ?prevnotifs = {}} = args;
sofar = {prevrcpts, prevnotifs};
if (typeof(recip) == LIST)
  bogus = {};
  for r in (recip)
    result = this:resolve_addr(r, from, seen, @sofar);
    if (result)
      sofar = result;
    else
      bogus = setadd(bogus, r);
    endif
  endfor
  return {bogus, @sofar};
else
  fwd = include_recip = 0;
  if (recip == $nothing || recip in seen)
    return sofar;
  elseif (!valid(recip) || (!(is_player(recip) || $object_utils:isa(recip, $mail_recipient)) || typeof(fwd = recip:mail_forward(from)) != LIST))
    "recip is a non-player non-mailing-list/folder or forwarding is screwed.";
    if (typeof(fwd) == STR)
      player:tell(fwd);
    endif
    return E_INVARG;
  elseif (is_player(recip) && `recip:refuses_action(from, "mail") ! E_VERBNF')
    player:tell(recip:mail_refused_msg());
    return E_INVARG;
  elseif (fwd)
    if (r = recip in fwd)
      include_recip = 1;
      fwd = listdelete(fwd, r);
    endif
    result = this:resolve_addr(fwd, recip, setadd(seen, recip), @sofar);
    if (bogus = result[1])
      player:tell(recip.name, "(", recip, ")'s .mail_forward list includes the following bogus entr", length(bogus) > 1 ? "ies:  " | "y:  ", $string_utils:english_list(bogus));
    endif
    sofar = result[2..3];
  else
    include_recip = 1;
  endif
  if (ticks_left() < 1000 || seconds_left() < 2)
    suspend(0);
  endif
  biffs = sofar[2];
  for n in (this:mail_notify(recip, from))
    if (valid(n))
      if (i = $list_utils:iassoc_suspended(n, biffs))
        biffs[i] = setadd(biffs[i], recip);
      else
        biffs = {{n, recip}, @biffs};
      endif
    endif
    if (ticks_left() < 1000 || seconds_left() < 2)
      suspend(0);
    endif
  endfor
  return {include_recip ? setadd(sofar[1], recip) | sofar[1], biffs};
endif
