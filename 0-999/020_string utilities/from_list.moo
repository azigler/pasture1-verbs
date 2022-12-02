#20:from_list   this none this rxd

"$string_utils:from_list(list [, separator])";
"Return a string being the concatenation of the string representations of the elements of LIST, each pair separated by the string SEPARATOR, which defaults to the empty string.";
{thelist, ?separator = ""} = args;
if (separator == "")
  return tostr(@thelist);
elseif (thelist)
  result = tostr(thelist[1]);
  for elt in (listdelete(thelist, 1))
    result = tostr(result, separator, elt);
  endfor
  return result;
else
  return "";
endif
