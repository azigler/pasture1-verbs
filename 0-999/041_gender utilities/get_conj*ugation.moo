#41:get_conj*ugation   this none this rxd

"get_conj(verbspec,object) => verb conjugated according to object.";
"verbspec can be one of \"singular/plural\", \"singular\", \"singular/\", or \"/plural\", e.g., \"is/are\", \"is\", \"is/\", or \"/are\".";
"The object is checked to see whether it is singular or plural.  This is inferred from its .gender property.  If .gender doesn't exist or the object itself is invalid, we assume singular.";
{spec, ?object = player} = args;
i = index(spec + "/", "/");
sing = spec[1..i - 1];
if (i < length(spec))
  plur = spec[i + 1..$];
else
  plur = "";
endif
cap = strcmp("a", i == 1 ? spec[2] | spec) > 0;
if (valid(object) && STR == typeof(g = `object.gender ! ANY') && (i = g in this.genders) && this.is_plural[i])
  vb = plur || this:_verb_plural(sing, i);
else
  vb = sing || this:_verb_singular(plur, i);
endif
if (cap)
  return $string_utils:capitalize(vb);
else
  return vb;
endif
