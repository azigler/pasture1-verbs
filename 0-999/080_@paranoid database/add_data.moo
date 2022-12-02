#80:add_data   this none this rxd

{who, newdata} = args;
if (is_player(who) && caller_perms().wizard)
  "if ($perm_utils:controls(caller_perms(), who) && is_player(who))";
  d = tostr(who, "pdata");
  l = tostr(who, "lines");
  this:ensure_props_exist(who, d, l);
  data = this.(d);
  lines = this.(l);
  "Icky G7 code copied straight out of $player:tell.";
  if ((len = length(this.(d) = {@data, newdata})) * 2 > lines * 3)
    this.(d) = this.(d)[len - lines + 1..len];
  endif
else
  return E_PERM;
endif
