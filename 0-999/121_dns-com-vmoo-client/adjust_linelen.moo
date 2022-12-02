#121:adjust_linelen   this none this rxd

{who, linelen} = args;
if (caller != this)
  return E_PERM;
endif
who.linelen = linelen;
