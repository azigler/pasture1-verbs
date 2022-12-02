#75:_write_parents   this none this xd

{o, r} = args;
set_task_perms(caller_perms());
try
  v = r["Value"]["value"];
  parents(o) != v && chparents(o, v);
except (E_RANGE)
  r["Error"] = ["diagnostic" -> "bad message format"];
  return r;
except (E_INVARG)
  r["Error"] = ["diagnostic" -> "argument is invalid"];
  return r;
except (E_TYPE)
  r["Error"] = ["diagnostic" -> "data type is invalid"];
  return r;
except (E_PERM)
  r["Error"] = ["diagnostic" -> "permission denied"];
  return r;
endtry
v = parents(o);
m = ["id" -> "parents"];
m["status"] = this:_controls(caller_perms(), o) ? "writable" | "readable";
return ["Meta" -> m, "Value" -> ["value" -> v]];
