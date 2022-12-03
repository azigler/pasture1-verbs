#59:dump_preamble   this none this rxd

":dump_preamble(object): produces the @create command necessary to dump this object.";
dobj = args[1];
parent = parent(dobj);
pstring = tostr(parent);
for p in (properties(#0))
  if (#0.(p) == parent)
    pstring = "$" + p;
  endif
endfor
if ($object_utils:has_property(dobj, "aliases"))
  return tostr("@create ", pstring, " named ", dobj.name, ":", $string_utils:from_list(dobj.aliases, ","));
else
  return tostr("@create ", pstring, " named ", dobj.name);
endif
