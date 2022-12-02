#75:read_verb   this none this xd

{o, v} = args;
try
  vx = verbs(o);
except (E_TYPE, E_INVARG)
  r = ["Meta" -> ["id" -> o, "status" -> "invalid"]];
  return r;
endtry
try
  vn = vx[v];
except (E_TYPE, E_RANGE)
  r = ["Meta" -> ["id" -> v, "status" -> "invalid"]];
  return r;
endtry
set_task_perms(caller_perms());
try
  vi = verb_info(o, v);
  va = verb_args(o, v);
  vc = verb_code(o, v);
  p = index(vi[2], "w") || this:_controls_verb(caller_perms(), o, v) ? "rw" | "r";
except (E_TYPE, E_INVARG, E_VERBNF)
  r = ["Meta" -> ["id" -> v, "status" -> "invalid"]];
  return r;
except (E_PERM)
  r = ["Meta" -> ["id" -> v, "status" -> "denied"]];
  return r;
endtry
m = ["id" -> v];
m["status"] = index(p, "w") ? "writable" | "readable";
r = ["Meta" -> m, "Verb" -> ["owner" -> vi[1], "perms" -> vi[2], "names" -> vi[3], "dobj" -> va[1], "prep" -> va[2], "iobj" -> va[3], "code" -> vc]];
return r;
