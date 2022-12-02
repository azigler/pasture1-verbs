#20:end_expression   this none this rxd

":end_expression(string[,stop_at])";
"  assumes string starts with an expression; returns the index of the last char in expression or 0 if string appears not to be an expression.  Expression ends at any character from stop_at which occurs at top level.";
{string, ?stop_at = " "} = args;
gone = 0;
paren_stack = "";
inquote = 0;
search = top_level_search = "[][{}()\"" + strsub(stop_at, "]", "") + "]";
paren_search = "[][{}()\"]";
while (m = match(string, search))
  char = string[m[1]];
  string[1..m[2]] = "";
  gone = gone + m[2];
  if (char == "\"")
    "...skip over quoted string...";
    char = "\\";
    while (char == "\\")
      if (!(m = match(string, "%(\\.?%|\"%)")))
        return 0;
      endif
      char = string[m[1]];
      string[1..m[2]] = "";
      gone = gone + m[2];
    endwhile
  elseif (index("([{", char))
    "... push parenthesis...";
    paren_stack[1..0] = char;
    search = paren_search;
  elseif (i = index(")]}", char))
    if (paren_stack && "([{"[i] == paren_stack[1])
      "... pop parenthesis...";
      paren_stack[1..1] = "";
      search = paren_stack ? paren_search | top_level_search;
    else
      "...parenthesis mismatch...";
      return 0;
    endif
  else
    "... stop character ...";
    return gone - 1;
  endif
endwhile
return !paren_stack && gone + length(string);
