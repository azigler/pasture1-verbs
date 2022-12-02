#95:explode_line   this none this rxd

su = $string_utils;
prev = args[1];
line = su:triml(args[2]);
indent = length(args[2]) - length(line);
if (line[1] == "@")
  if (!(splicee = $no_one:eval("{" + line[2..length(line)] + "}"))[1])
    return "Can't eval what's after the @.";
  endif
  newlines = this:explode_list(indent + 1, splicee[2]);
  return {prev, @newlines};
elseif (line[1] == "}")
  if (this:is_delimiter(prev) && !index(prev, "{"))
    return {tostr(args[2][1..indent], su:trim(prev), " ", line)};
  else
    return args;
  endif
elseif (line[1] != "{")
  return args;
elseif (!rindex(line, "}"))
  if (this:is_delimiter(prev))
    return {su:trimr(prev) + (rindex(prev, "{") ? " " | ", ") + line};
  else
    return args;
  endif
elseif (!(v = $no_one:eval(line))[1])
  return "Can't eval this line.";
else
  newlines = {@this:explode_list(indent + 2, v[2]), su:space(indent) + "}"};
  if (this:is_delimiter(prev))
    return {su:trimr(prev) + (rindex(prev, "{") ? " {" | ", {"), @newlines};
  else
    return {prev, su:space(indent) + "{", @newlines};
  endif
endif
