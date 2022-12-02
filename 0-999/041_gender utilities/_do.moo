#41:_do   this none this rxd

"_do(cap,object,modifiers...)";
{cap, object, modifiers} = args;
if (!modifiers)
  if (typeof(object) != OBJ)
    return tostr(object);
  elseif (!valid(object))
    return (cap ? "N" | "n") + "othing";
  else
    return cap ? object:titlec() | object:title();
  endif
elseif (modifiers[1] == ".")
  if (i = index(modifiers[2..$], "."))
    i = i + 1;
  elseif (!(i = index(modifiers, ":") || index(modifiers, "#") || index(modifiers, "!")))
    i = length(modifiers) + 1;
  endif
  if (typeof(o = `object.(modifiers[2..i - 1]) ! ANY') == ERR)
    return tostr("%(", o, ")");
  else
    return this:_do(cap || strcmp("a", modifiers[2]) > 0, o, modifiers[i..$]);
  endif
elseif (modifiers[1] == ":")
  if (typeof(object) != OBJ)
    return tostr("%(", E_TYPE, ")");
  elseif (p = this:get_pronoun(modifiers, object))
    return p;
  else
    return tostr("%(", modifiers, "??)");
  endif
elseif (modifiers[1] == "#")
  return tostr(object);
elseif (modifiers[1] == "!")
  return this:get_conj(modifiers[2..$], object);
else
  i = index(modifiers, ".") || index(modifiers, ":") || index(modifiers, "#") || index(modifiers, "!") || length(modifiers) + 1;
  s = modifiers[1..i - 1];
  if (j = s in {"dobj", "iobj", "this"})
    return this:_do(cap, {dobj, iobj, callers()[2][1]}[j], modifiers[i..$]);
  else
    return tostr("%(", s, "??)");
  endif
endif
