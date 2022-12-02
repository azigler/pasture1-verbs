#46:sends_to   this none this rxd

"sends_to(from,addr,rcpt[,seen]) ==> true iff mail sent to addr passes through rcpt.";
{from, addr, rcpt, ?seen = {}} = args;
if (addr == rcpt)
  return 1;
elseif (!(addr in seen))
  seen = {@seen, addr};
  for a in (typeof(fwd = this:mail_forward(addr, @from ? {} | {from})) == LIST ? fwd | {})
    if (this:sends_to(addr, a, rcpt, seen))
      return 1;
    endif
    $command_utils:suspend_if_needed(0);
  endfor
endif
return 0;
