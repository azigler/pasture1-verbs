#6:@last-c*onnection   any none none rxd

"@last-c           reports when and from where you last connected.";
"@last-c all       adds the 10 most recent places you connected from.";
"@last-c confunc   is like `@last-c' but is silent on first login.";
opts = {"all", "confunc"};
i = 0;
if (caller != this)
  return E_PERM;
elseif (args && (length(args) > 1 || !(i = $string_utils:find_prefix(args[1], opts))))
  this:notify(tostr("Usage:  ", verb, " [all]"));
  return;
endif
opt_all = i && opts[i] == "all";
opt_confunc = i && opts[i] == "confunc";
if (!(prev = this.previous_connection))
  this:notify("Something was broken when you logged in; tell a wizard.");
elseif (prev[1] == 0)
  opt_confunc || this:notify("Your previous connection was before we started keeping track.");
elseif (prev[1] > time())
  this:notify("This is your first time connected.");
else
  this:notify(tostr("Last connected ", this:ctime(prev[1]), " from ", prev[2]));
  if (opt_all)
    this:notify("Previous connections have been from the following sites:");
    for l in (this.all_connect_places)
      this:notify("   " + l);
    endfor
  endif
endif
