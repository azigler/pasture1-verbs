#75:write_property   this none this xd

{o, p, r, ?options = []} = args;
error1 = error2 = 0;
try
  px = properties(o);
except (E_TYPE, E_INVARG)
  error1 = 1;
endtry
try
  pn = px[p];
except (E_VARNF)
except (E_TYPE, E_RANGE)
  error2 = 1;
endtry
set_task_perms(caller_perms());
old = this:read_property(o, p);
if (`old["Property"] ! E_RANGE' == `r["Property"] ! E_RANGE')
  return old;
endif
if (error1)
  r["Error"] = ["diagnostic" -> "object reference is invalid"];
  return r;
elseif (error2)
  r["Error"] = ["diagnostic" -> "property is invalid"];
  return r;
endif
try
  r1 = r["Property"];
  set_property_info(o, pn, {`r1["owner"] ! E_RANGE => caller_perms()', r1["perms"], r1["name"]});
  o.(r1["name"]) = r1["value"];
except (E_RANGE)
  r["Error"] = ["diagnostic" -> "bad message format"];
  return r;
except (E_INVIND, E_INVARG)
  r["Error"] = ["diagnostic" -> "object reference is invalid"];
  return r;
except (E_PERM)
  r["Error"] = ["diagnostic" -> "permission denied"];
  return r;
except (E_TYPE)
  r["Error"] = ["diagnostic" -> "data type is invalid"];
  return r;
endtry
return this:read_property(o, p);
