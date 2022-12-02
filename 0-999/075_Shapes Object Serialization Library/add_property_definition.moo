#75:add_property_definition   this none this xd

{t, pn, pv, pi} = args;
p = ["Property" -> ["owner" -> pi[1], "perms" -> pi[2], "name" -> pn, "value" -> pv]];
t["Properties"] = {@t["Properties"], p};
return t;
