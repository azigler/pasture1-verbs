#75:write_object   this none this xd

{o, r, ?options = []} = args;
ticks_left() < 2000 || seconds_left() < 2 && suspend(0);
if (`valid(o) ! E_TYPE')
  properties = properties(o);
  verbs = verbs(o);
  set_task_perms(caller_perms());
  try
    r["Attributes"];
    r["Values"];
    r["Properties"];
    r["Verbs"];
    errors = 0;
    parents = `r["Attributes"]["parents"]["Value"]["value"] ! E_RANGE => parents(o)';
    if (parents(o) != parents)
      x = this:_write_parents(o, ["Value" -> ["value" -> {}]]);
      errors = errors + ("Error" in mapkeys(x));
    endif
    location = `r["Values"]["location"]["Value"]["value"] ! E_RANGE => o.location';
    if (o.location != location)
      x = this:write_value(o, "location", ["Value" -> ["value" -> $nothing]]);
      errors = errors + ("Error" in mapkeys(x));
    endif
    owner = `r["Values"]["owner"]["Value"]["value"] ! E_RANGE => o.owner';
    if ("owner" in mapkeys(r["Values"]))
      r["Values"]["owner"] = this:write_value(o, "owner", r["Values"]["owner"]);
      errors = errors + ("Error" in mapkeys(r["Values"]["owner"]));
    endif
    if ("parents" in mapkeys(r["Attributes"]))
      r["Attributes"]["parents"] = this:_write_parents(o, r["Attributes"]["parents"]);
      errors = errors + ("Error" in mapkeys(r["Attributes"]["parents"]));
    endif
    if ("player" in mapkeys(r["Attributes"]))
      r["Attributes"]["player"] = this:_write_player(o, r["Attributes"]["player"]);
      errors = errors + ("Error" in mapkeys(r["Attributes"]["player"]));
    endif
    if ("location" in mapkeys(r["Values"]))
      r["Values"]["location"] = this:write_value(o, "location", r["Values"]["location"]);
      errors = errors + ("Error" in mapkeys(r["Values"]["location"]));
    endif
    if ((lp1 = length(properties)) < (lp2 = length(r["Properties"])))
      for p in [lp1 + 1..lp2]
        this:_suspend_if_necessary();
        `add_property(o, tostr("___", p, "___"), 0, {owner, ""}) ! E_PERM';
      endfor
    else
      for p in [lp2 + 1..lp1]
        this:_suspend_if_necessary();
        delete_property(o, properties[p]);
      endfor
    endif
    if ((lv1 = length(verbs)) < (lv2 = length(r["Verbs"])))
      for v in [lv1 + 1..lv2]
        this:_suspend_if_necessary();
        `add_verb(o, {owner, "", tostr("___", v, "___")}, {"this", "none", "this"}) ! E_PERM';
      endfor
    else
      for v in [lv2 + 1..lv1]
        this:_suspend_if_necessary();
        delete_verb(o, lv2 + 1);
      endfor
    endif
    for p in [1..length(r["Properties"])]
      this:_suspend_if_necessary();
      r["Properties"][p] = this:write_property(o, p, r["Properties"][p]);
      if ("Error" in mapkeys(r["Properties"][p]))
        if (lp1 < lp2 && r["Properties"][p]["Error"]["diagnostic"] == "property is invalid")
          r["Properties"][p]["Error"]["diagnostic"] = "permission denied";
        endif
        errors = errors + 1;
      endif
    endfor
    for v in [1..length(r["Verbs"])]
      this:_suspend_if_necessary();
      r["Verbs"][v] = this:write_verb(o, v, r["Verbs"][v], `options["verbs"] ! E_RANGE => []');
      if ("Error" in mapkeys(r["Verbs"][v]))
        if (lv1 < lv2 && r["Verbs"][v]["Error"]["diagnostic"] == "verb is invalid")
          r["Verbs"][v]["Error"]["diagnostic"] = "permission denied";
        endif
        errors = errors + 1;
      endif
    endfor
    values = setremove(setremove(mapkeys(r["Values"]), "location"), "owner");
    for a in (values)
      this:_suspend_if_necessary();
      r["Values"][a] = this:write_value(o, a, r["Values"][a], options);
      errors = errors + ("Error" in mapkeys(r["Values"][a]));
    endfor
    if (errors < 1)
      r = this:read_object(o);
    else
      r["Meta"] = ["id" -> toint(o), "status" -> "unknown"];
      r["Error"] = ["diagnostic" -> "errors in sub-operations"];
    endif
    return r;
  except (E_RANGE, E_TYPE)
    r["Error"] = ["diagnostic" -> "bad message format"];
    return r;
  except (E_PERM)
    r["Error"] = ["diagnostic" -> "permission denied"];
    return r;
  endtry
else
  r["Error"] = ["diagnostic" -> "object reference is invalid"];
  return r;
endif
