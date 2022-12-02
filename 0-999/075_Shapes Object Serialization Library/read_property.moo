#75:read_property   this none this xd

{o, p, ?options = []} = args;
try
  px = properties(o);
except (E_TYPE, E_INVARG)
  r = ["Meta" -> ["id" -> o, "status" -> "invalid"]];
  return r;
endtry
try
  pn = px[p];
except (E_TYPE, E_RANGE)
  r = ["Meta" -> ["id" -> p, "status" -> "invalid"]];
  return r;
endtry
set_task_perms(caller_perms());
try
  pi = property_info(o, pn);
  pv = o.(pn);
  s = index(pi[2], "w") || this:_controls_property(caller_perms(), o, pn) ? "rw" | "r";
except (E_TYPE, E_INVARG, E_PROPNF)
  r = ["Meta" -> ["id" -> p, "status" -> "invalid"]];
  return r;
except (E_PERM)
  r = ["Meta" -> ["id" -> p, "status" -> "denied"]];
  return r;
endtry
m = ["id" -> p];
m["status"] = index(s, "w") ? "writable" | "readable";
r = ["Meta" -> m, "Property" -> ["owner" -> pi[1], "perms" -> pi[2], "name" -> pn, "value" -> pv]];
return r;
