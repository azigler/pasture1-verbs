#20:match_str*ing   this none this rxd

"* wildcard matching. Returns a list of what the *s actually matched. Won't cath every match, if there are several ways to parse it.";
"Example: $string_utils:match_string(\"Jack waves to Jill\",\"* waves to *\") returns {\"Jack\", \"Jill\"}";
"Optional arguments: numbers are interpreted as case-sensitivity, strings as alternative wildcards.";
{what, targ, @rest} = args;
wild = "*";
case = ret = {};
what = what + "&^%$";
targ = targ + "&^%$";
for y in (rest)
  if (typeof(y) == STR)
    wild = y;
  elseif (typeof(y) == INT)
    case = {y};
  endif
endfor
while (targ != "")
  if (z = index(targ, wild))
    part = targ[1..z - 1];
  else
    z = length(targ);
    part = targ;
  endif
  n = part == "" ? 1 | index(what, part, @case);
  if (n)
    ret = listappend(ret, what[1..n - 1]);
    what = what[z + n - 1..$];
    targ = targ[z + 1..$];
  else
    return 0;
  endif
endwhile
if (ret == {})
  return what == "";
elseif (ret == {""})
  return 1;
elseif (ret[1] == "")
  return ret[2..$];
else
  return 0;
endif
