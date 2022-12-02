#59:explain_verb_syntax   this none this rxd

if (args[4..5] == {"none", "this"})
  return 0;
endif
{thisobj, verb, adobj, aprep, aiobj} = args;
prep_part = aprep == "any" ? "to" | this:short_prep(aprep);
".........`any' => `to' (arbitrary),... `none' => empty string...";
if (adobj == "this" && dobj == thisobj)
  dobj_part = dobjstr;
  iobj_part = !prep_part || aiobj == "none" ? "" | (aiobj == "this" ? dobjstr | iobjstr);
elseif (aiobj == "this" && iobj == thisobj)
  dobj_part = adobj == "any" ? dobjstr | (adobj == "this" ? iobjstr | "");
  iobj_part = iobjstr;
elseif (!("this" in args[3..5]))
  dobj_part = adobj == "any" ? dobjstr | "";
  iobj_part = prep_part && aiobj == "any" ? iobjstr | "";
else
  return 0;
endif
return tostr(verb, dobj_part ? " " + dobj_part | "", prep_part ? " " + prep_part | "", iobj_part ? " " + iobj_part | "");
