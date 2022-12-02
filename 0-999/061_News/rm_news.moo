#61:rm_news   this none this rxd

if (!this:ok_write(caller, caller_perms()))
  raise(E_PERM);
endif
{specs, ?cur = {0, 0}} = args;
seq = this:_parse(specs, @cur);
if (typeof(seq) == STR)
  return seq;
endif
old = this.current_news;
new = $seq_utils:intersection(old, $seq_utils:complement(seq));
if (old == new)
  return "Those messages were not in the news.";
endif
this:set_current_news(new);
return 1;
