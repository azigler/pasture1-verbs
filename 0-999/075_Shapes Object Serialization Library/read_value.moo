#75:read_value   this none this xd

{o, a, ?options = []} = args;
strip_clear_values = `options["strip_clear_values"] ! E_RANGE';
set_task_perms(caller_perms());
try
  if (a == "location")
    v = o.location;
    p = this:_controls(caller_perms(), o) ? "rw" | "r";
  elseif (a in {"owner", "programmer", "wizard"})
    v = o.(a);
    p = `caller_perms().wizard ! E_INVIND' ? "rw" | "r";
  elseif (a in {"r", "w", "f", "a"})
    v = o.(a);
    p = this:_controls(caller_perms(), o) ? "rw" | "r";
  elseif (a in {"name"})
    v = o.(a);
    p = `caller_perms().wizard ! E_INVIND' || (this:_controls(caller_perms(), o) && !is_player(o)) ? "rw" | "r";
  else
    v = o.(a);
    pi = property_info(o, a);
    p = index(pi[2], "w") || this:_controls_property(caller_perms(), o, a) ? "rw" | "r";
    c = is_clear_property(o, a);
  endif
except (E_INVIND, E_PROPNF)
  r = ["Meta" -> ["id" -> a, "status" -> "invalid"]];
  return r;
except (E_PERM)
  r = ["Meta" -> ["id" -> a, "status" -> "denied"]];
  return r;
endtry
m = ["id" -> a];
m["status"] = index(p, "w") ? "writable" | "readable";
r = ["Meta" -> m, "Value" -> ["value" -> v]];
if (`r["Value"]["clear"] = c ! E_VARNF' && strip_clear_values)
  r["Value"] = mapdelete(r["Value"], "value");
endif
if (`pi ! E_VARNF')
  if ((ppi = this:_parent_property_info(o, a)) && ppi != pi)
    r["Value"]["owner"] = pi[1];
    r["Value"]["perms"] = pi[2];
  endif
endif
return r;
