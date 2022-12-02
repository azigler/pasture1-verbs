#75:write_value   this none this xd

{o, a, r, ?options = []} = args;
set_task_perms(caller_perms());
mk = mapkeys(r);
if (!("Meta" in mk) && !("Value" in mk))
  r["Error"] = ["diagnostic" -> "bad message format"];
  return r;
endif
old = this:read_value(o, a, options);
if (`old["Value"] ! E_RANGE' == `r["Value"] ! E_RANGE')
  return old;
endif
try
  mk = mapkeys(r["Value"]);
  if (a in {"name", "owner", "location", "programmer", "wizard", "r", "w", "f", "a"})
    if ("clear" in mk)
      r["Error"] = ["diagnostic" -> "clear is not applicable"];
      return r;
    endif
    if ("owner" in mk)
      r["Error"] = ["diagnostic" -> "owner is not applicable"];
      return r;
    endif
    if ("perms" in mk)
      r["Error"] = ["diagnostic" -> "perms is not applicable"];
      return r;
    endif
  endif
  c = `r["Value"]["clear"] ! E_RANGE';
  if (c)
    clear_property(o, a);
  else
    v = r["Value"]["value"];
    if (a == "location")
      o.location != v && move(o, v);
    else
      o.(a) = v;
    endif
  endif
  if ("owner" in mk || "perms" in mk)
    set_property_info(o, a, {`r["Value"]["owner"] ! E_RANGE => caller_perms()', r["Value"]["perms"]});
  endif
except (E_RANGE)
  r["Error"] = ["diagnostic" -> "bad message format"];
  return r;
except (E_INVIND)
  r["Error"] = ["diagnostic" -> "object reference is invalid"];
  return r;
except (E_PROPNF)
  r["Error"] = ["diagnostic" -> "value is invalid"];
  return r;
except (E_PERM)
  r["Error"] = ["diagnostic" -> "permission denied"];
  return r;
except (E_TYPE)
  r["Error"] = ["diagnostic" -> "data type is invalid"];
  return r;
except (E_NACC)
  r["Error"] = ["diagnostic" -> "move refused by destination"];
  return r;
except (E_RECMOVE)
  r["Error"] = ["diagnostic" -> "recursive move"];
  return r;
endtry
return this:read_value(o, a, options);
