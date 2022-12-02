#21:object_audit_string   this none this rxd

":object_audit_string(object [,prospectus-style])";
{o, ?prospectus = 0} = args;
olen = length(tostr(max_object()));
if (!$recycler:valid(o))
  return tostr(prospectus ? "          " | "", $quota_utils.byte_based ? "    " | "", $string_utils:right(o, olen), " Invalid Object!");
endif
if (prospectus)
  kids = 0;
  for k in (children(o))
    $command_utils:suspend_if_needed(0);
    if (k.owner != o.owner)
      kids = 2;
      break k;
    elseif (kids == 0)
      kids = 1;
    endif
  endfor
  "The verbs() call below might fail, but that's OK";
  "Well, actually it won't cuz we seem to be a wizard.  Since you can get the number of verbs information from @verbs anyway, it seems kind of pointless to hide it here.";
  v = verbs(o);
  if (v)
    vstr = tostr("[", $string_utils:right(length(v), 3), "] ");
  else
    vstr = "      ";
  endif
  if (o.r && o.f)
    r = "f";
  elseif (o.r)
    r = "r";
  elseif (o.f)
    r = "F";
  else
    r = " ";
  endif
  vstr = tostr(" kK"[kids + 1], r, $building_utils:audit_object_category(o), vstr);
else
  vstr = "";
endif
if ($quota_utils.byte_based)
  vstr = tostr(this:size_string(`o.object_size[1] ! ANY => 0'), " ", vstr);
  name_field_len = 26;
else
  name_field_len = 30;
endif
if (valid(o.location))
  loc = (o.location.owner == o.owner ? " " | "*") + "[" + o.location.name + "]";
elseif (typeof(o) == ANON)
  loc = " ";
elseif ($object_utils:has_property(o, "dest") && $object_utils:has_property(o, "source"))
  if (typeof(o.source) != OBJ)
    source = " <non-object> ";
  elseif (!valid(o.source))
    source = "<invalid>";
  else
    source = o.source.name;
    if (o.source.owner != o.owner)
      source = "*" + source;
    endif
  endif
  if (typeof(o.dest) != OBJ)
    destin = " <non-object> ";
  elseif (!valid(o.dest))
    destin = "<invalid>";
  else
    destin = o.dest.name;
    if (o.dest.owner != o.owner)
      destin = "*" + destin;
    endif
  endif
  srclen = min(length(source), 19);
  destlen = min(length(destin), 19);
  loc = " " + source[1..srclen] + "->" + destin[1..destlen];
elseif ($object_utils:isa(o, $room))
  loc = "";
  try
    for x in (o.entrances)
      if (typeof(x) == OBJ && valid(x) && x.owner != o.owner && $object_utils:has_property(x, "dest") && x.dest == o)
        loc = loc + (loc ? ", " | "") + "<-*" + x.name;
      endif
    endfor
  except (ANY)
    if ($perm_utils:controls(player, o))
      loc = " BROKEN PROPERTY: .entrances";
    endif
  endtry
else
  loc = " [Nowhere]";
endif
if (length(loc) > 41)
  loc = loc[1..37] + "..]";
endif
namelen = min(length(o.name), name_field_len - 1);
return tostr(vstr, $string_utils:right(o, olen), " ", $string_utils:left(o.name[1..namelen], name_field_len), loc);
