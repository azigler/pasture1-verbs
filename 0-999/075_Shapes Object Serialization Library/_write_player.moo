#75:_write_player   this none this xd

{o, r} = args;
set_task_perms(caller_perms());
try
  v = r["Value"]["value"];
  is_player(o) != v && set_player_flag(o, v);
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
v = is_player(o);
m = ["id" -> "player"];
m["status"] = `caller_perms().wizard ! E_INVIND' ? "writable" | "readable";
return ["Meta" -> m, "Value" -> ["value" -> v]];
