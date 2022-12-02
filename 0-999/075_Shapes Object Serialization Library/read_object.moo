#75:read_object   this none this xd

{o, ?options = []} = args;
ticks_left() < 2000 || seconds_left() < 2 && suspend(0);
if (`valid(o) ! E_TYPE')
  pcount = length(properties(o));
  vcount = length(verbs(o));
  set_task_perms(caller_perms());
  r = ["Attributes" -> []];
  v = parents(o);
  m = ["id" -> "parents"];
  m["status"] = this:_controls(caller_perms(), o) ? "writable" | "readable";
  r["Attributes"]["parents"] = ["Meta" -> m, "Value" -> ["value" -> v]];
  if (typeof(o) == OBJ)
    v = is_player(o);
    m = ["id" -> "player"];
    m["status"] = `caller_perms().wizard ! E_INVIND' ? "writable" | "readable";
    r["Attributes"]["player"] = ["Meta" -> m, "Value" -> ["value" -> v]];
  endif
  r["Values"] = [];
  for a in (this:_values(o))
    this:_suspend_if_necessary();
    r["Values"][a] = this:read_value(o, a, options);
  endfor
  r["Properties"] = {};
  for p in [1..pcount]
    this:_suspend_if_necessary();
    r["Properties"] = {@r["Properties"], this:read_property(o, p)};
  endfor
  r["Verbs"] = {};
  for v in [1..vcount]
    this:_suspend_if_necessary();
    r["Verbs"] = {@r["Verbs"], this:read_verb(o, v)};
  endfor
  if (p = o.w || this:_controls(caller_perms(), o))
    status = "writable";
  elseif (o.r)
    status = "readable";
  else
    status = "";
  endif
  if (typeof(o) == OBJ)
    r["Meta"] = ["id" -> toint(o), "status" -> status];
  else
    r["Meta"] = ["status" -> status];
  endif
  return r;
else
  if (typeof(o) == OBJ)
    r = ["Meta" -> ["id" -> toint(o), "status" -> "invalid"]];
  else
    r = ["Meta" -> ["status" -> "invalid"]];
  endif
  return r;
endif
