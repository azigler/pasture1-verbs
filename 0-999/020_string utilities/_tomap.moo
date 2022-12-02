#20:_tomap   this none this rxd

"_tomap(string) -- auxiliary for :to_value()";
"Last modified 11/28/18 11:48 p.m. by Sinistral (#2) on ChatMUD";
rest = this:triml(args[1]);
vhash = [];
if (!rest)
  return {0, []};
elseif (rest[1] == "]")
  return {rest[2..$], []};
endif
while (1)
  rlen = length(rest);
  key = 0;
  if (rest[1] == "\"")
    result = this:_unquote(rest[2..rlen]);
    if (typeof(result[1] == INT))
      return result;
    endif
    key = result[2];
    rest = result[1];
    if (!rest)
      return {0, ""};
    endif
    key_end = index(rest, "->");
    if (!key_end)
      return {rlen, "missing arrow '->' in hash entry definition"};
    endif
    rest = rest[key_end + 2..$];
  elseif (w = index("{[", rest[1]))
    return {rlen, "hash key cannot be list or hash"};
  else
    key_end = index(rest, "->");
    if (!key_end)
      return {rlen, "missing arrow '->' in hash entry definition"};
    endif
    thing = rest[1..key_end - 1];
    if (typeof(s = this:_toscalar(thing)) == STR)
      return {rlen, s};
    endif
    key = s;
    rest = rest[key_end + 2..rlen];
  endif
  val = 0;
  rest = this:triml(rest);
  rlen = length(rest);
  if (w = index("{[\"", rest[1]))
    result = this:({"_tolist", "_tomap", "_unquote"}[w])(rest[2..rlen]);
    if (typeof(result[1] == INT))
      return result;
    endif
    val = result[2];
    rest = result[1];
  else
    val = rest[1..vlen = min(index(rest + ",", ","), index(rest + "]", "]")) - 1];
    if (typeof(s = this:_toscalar(val)) == STR)
      return {rlen, s};
    endif
    val = s;
    rest = rest[vlen + 1..rlen];
  endif
  vhash[key] = val;
  rest = this:triml(rest);
  if (!rest)
    return {0, vhash};
  elseif (rest[1] == "]")
    return {rest[2..$], vhash};
  elseif (rest[1] == ",")
    rest = this:triml(rest[2..$]);
  else
    return {length(rest), ", or ] expected"};
  endif
endwhile
