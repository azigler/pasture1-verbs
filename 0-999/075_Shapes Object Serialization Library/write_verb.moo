#75:write_verb   this none this xd

{o, v, r, ?options = []} = args;
error1 = error2 = 0;
try
  vx = verbs(o);
except (E_TYPE, E_INVARG)
  error1 = 1;
endtry
try
  vn = vx[v];
except (E_VARNF)
except (E_TYPE, E_RANGE)
  error2 = 1;
endtry
set_task_perms(caller_perms());
old = this:read_verb(o, v);
if (`old["Verb"] ! E_RANGE' == `r["Verb"] ! E_RANGE')
  return old;
endif
if (error1)
  r["Error"] = ["diagnostic" -> "object reference is invalid"];
  return r;
elseif (error2)
  r["Error"] = ["diagnostic" -> "verb is invalid"];
  return r;
endif
try
  r1 = r["Verb"];
  set_verb_info(o, v, {`r1["owner"] ! E_RANGE => caller_perms()', r1["perms"], r1["names"]});
  set_verb_args(o, v, {r1["dobj"], r1["prep"], r1["iobj"]});
  vc = `r1["code"] ! E_RANGE => {}';
  if (vc != E_RANGE)
    if (set_verb_code(o, v, vc))
      r["Error"] = ["diagnostic" -> "compilation errors"];
      return r;
    endif
  endif
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
return this:read_verb(o, v);
