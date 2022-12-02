#95:to_value   this none this rxd

":to_value(@list_of_strings) => {line#, error_message} or {0,value}";
"converts the given list of strings back into a value if possible";
stack = {};
curlist = {};
curstr = 0;
i = 0;
for line in (args)
  i = i + 1;
  if (!(line = $string_utils:triml(line)))
    "skip blank lines";
  elseif ((char = line[1]) == "+")
    if (curstr == 0)
      return {i, "previous line is not a string"};
    endif
    curstr = curstr + line[2..length(line)];
  else
    if (curstr != 0)
      curlist = {@curlist, curstr};
      curstr = 0;
    endif
    if (char == "}" || (char == "{" && !rindex(line, "}")))
      comma = 0;
      for c in [1..length(line)]
        char = line[c];
        if (char == "}")
          if (comma)
            return {i, "unexpected `}'"};
          elseif (!stack)
            return {i, "too many }'s"};
          endif
          curlist = {@stack[1], curlist};
          stack = listdelete(stack, 1);
        elseif (char == "{")
          comma = 1;
          stack = {curlist, @stack};
          curlist = {};
        elseif (char == " ")
        elseif (!comma && char == ",")
          comma = 1;
        else
          return {i, tostr("unexpected `", char, "'")};
        endif
      endfor
    elseif (char == "\"")
      curstr = line[2..length(line)];
    elseif (char == "@")
      if (!(v = $no_one:eval("{" + line[2..length(line)] + "}"))[1])
        return {i, "Can't eval what's after the @"};
      endif
      curlist = {@curlist, @v[2]};
    else
      if (!(v = $no_one:eval(line))[1])
        return {i, "Can't eval this line"};
      endif
      curlist = {@curlist, v[2]};
    endif
  endif
endfor
if (stack)
  return {i, "missing }"};
endif
if (curstr != 0)
  return {0, {@curlist, curstr}};
else
  return {0, curlist};
endif
