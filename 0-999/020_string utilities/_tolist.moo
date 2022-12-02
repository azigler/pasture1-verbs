#20:_tolist   this none this rxd

"_tolist(string) --- auxiliary for :to_value()";
rest = this:triml(args[1]);
vlist = {};
if (!rest)
  return {0, {}};
elseif (rest[1] == "}")
  return {rest[2..$], {}};
endif
while (1)
  rlen = length(rest);
  if (w = index("{\"", rest[1]))
    result = this:({"_tolist", "_unquote"}[w])(rest[2..rlen]);
    if (typeof(result[1]) == INT)
      return result;
    endif
    vlist = {@vlist, result[2]};
    rest = result[1];
  else
    thing = rest[1..tlen = min(index(rest + ",", ","), index(rest + "}", "}")) - 1];
    if (typeof(s = this:_toscalar(thing)) == STR)
      return {rlen, s};
    endif
    vlist = {@vlist, s};
    rest = rest[tlen + 1..rlen];
  endif
  if (!rest)
    return {0, vlist};
  elseif (rest[1] == "}")
    return {rest[2..$], vlist};
  elseif (rest[1] == ",")
    rest = this:triml(rest[2..$]);
  else
    return {length(rest), ", or } expected"};
  endif
endwhile
