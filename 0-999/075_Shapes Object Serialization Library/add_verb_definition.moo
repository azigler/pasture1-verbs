#75:add_verb_definition   this none this xd

{t, vi, va, ?vc = {}} = args;
v = ["Verb" -> ["owner" -> vi[1], "perms" -> vi[2], "names" -> vi[3], "dobj" -> va[1], "prep" -> va[2], "iobj" -> va[3], "code" -> vc]];
t["Verbs"] = {@t["Verbs"], v};
return t;
