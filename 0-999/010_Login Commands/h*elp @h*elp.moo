#10:"h*elp @h*elp"   any none any rxd

if (caller != #0 && caller != this)
  return E_PERM;
else
  msg = this.help_message;
  for line in (typeof(msg) == LIST ? msg | {msg})
    if (typeof(line) == STR)
      notify(player, line);
    endif
  endfor
  return 0;
endif
