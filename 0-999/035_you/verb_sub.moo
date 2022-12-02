#35:verb_sub   this none this rxd

"$you:verb_sub(STR verbspec) -> returns verbspec conjugated for singular use as if `you' were saying it.";
return $gender_utils:get_conj(args[1], this);
x = args[1];
len = length(x);
if (len > 3 && rindex(x, "n't") == len - 3)
  return this:verb_sub(x[1..len - 3]) + "n't";
endif
for y in (this.conjugations)
  if (x == y[1])
    return y[2];
  endif
endfor
for y in ({{"ches", "ch"}, {"ies", "y"}, {"sses", "ss"}, {"shes", "sh"}, {"s", ""}})
  if (len > length(y[1]) && rindex(x, y[1]) == len - length(y[1]) + 1)
    return x[1..len - length(y[1])] + y[2];
  endif
endfor
return x;
