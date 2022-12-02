#65:parse_@unsend   this none this rxd

{name, value, bleh} = args;
if (typeof(value) == INT)
  return tostr(name, " is not a boolean option.");
elseif (typeof(value) == STR)
  value = {value};
endif
ok = this.unsend_sequences;
for x in (value)
  if (!(pos = index(x, ":")) || !(x[1..pos - 1] in ok))
    return tostr("Invalid sequence - ", x);
  elseif (pos != rindex(x, ":"))
    return tostr("As a preventative measure, you may not use more than one : in a sequence. The following sequence is therefore invalid - ", x);
  endif
endfor
return {name, value};
