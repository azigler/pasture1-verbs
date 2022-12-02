#53:unparse_key   this none this rxd

":unparse_key(LIST|OBJ coded key) => returns a string describing the key in english/moo-code terms.";
"Example:";
"$lock_utils:unparse_key({\"||\", $hacker, $housekeeper}) => \"#18105[Hacker] || #36830[housekeeper]\"";
key = args[1];
type = typeof(key);
if (!(type in {LIST, OBJ}))
  return "(None.)";
elseif (type == OBJ)
  if (valid(key))
    return tostr(key, "[", key.name, "]");
  else
    return tostr(key);
  endif
else
  op = key[1];
  arg1 = this:unparse_key(key[2]);
  if (op == "?")
    return "?" + arg1;
  elseif (op == "!")
    if (typeof(key[2]) == LIST)
      return "!(" + arg1 + ")";
    else
      return "!" + arg1;
    endif
  elseif (op in {"&&", "||"})
    other = op == "&&" ? "||" | "&&";
    lhs = arg1;
    rhs = this:unparse_key(key[3]);
    if (typeof(key[2]) == OBJ || key[2][1] != other)
      exp = lhs;
    else
      exp = "(" + lhs + ")";
    endif
    exp = exp + " " + op + " ";
    if (typeof(key[3]) == OBJ || key[3][1] != other)
      exp = exp + rhs;
    else
      exp = exp + "(" + rhs + ")";
    endif
    return exp;
  else
    raise(E_DIV);
  endif
endif
