#6:set_pagelength   this none this rxd

"Set pagelength. Must be an integer >= 5, or 0 to turn pagelength off.";
"Returns E_PERM if you shouldn't be doing this, E_INVARG if it's too low, otherwise, what it got set to.";
if (caller != this && !$perm_utils:controls(caller_perms(), this))
  return E_PERM;
elseif ((len = args[1]) < 5 && len != 0)
  return E_INVARG;
else
  if ((this.pagelen = len) == 0)
    if (lb = this.linebuffer)
      "queued text remains";
      this:notify_lines(lb);
      clear_property(this, "linebuffer");
    endif
  endif
  return len;
endif
