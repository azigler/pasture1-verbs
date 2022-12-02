#107:parse_mcp_alist   this none this rxd

"take args and return a list in the format:";
"{true if contains multiline, { { keyword-name, data, multiline }, ... }";
alist = {};
if (length(alist) % 2)
  raise(E_ARGS);
endif
contains_multiline = 0;
while (args)
  {keyword, value, @args} = args;
  if (keyword[$] != ":")
    raise(E_INVARG, "invalid keyword: " + keyword);
  else
    if (keyword[$ - 1] == "*")
      contains_multiline = 1;
      value = {};
      keyword = keyword[1..$ - 2];
    else
      keyword = keyword[1..$ - 1];
    endif
    alist = {@alist, {keyword, value}};
  endif
endwhile
return {contains_multiline, alist};
