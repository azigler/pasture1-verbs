#50:description   this none this rxd

is_look_self = 1;
for c in (callers())
  if (is_look_self && c[2] in {"enterfunc", "confunc"})
    return {"", "Do a 'look' to get the list of commands, or 'help' for assistance.", "", @this.description};
  elseif (c[2] != "look_self" && c[2] != "pass")
    is_look_self = 0;
  endif
endfor
d = {"Commands:", ""};
col = {{}, {}};
for c in [1..2]
  for cmd in (this.commands2[c])
    cmd = this:commands_info(cmd);
    col[c] = {cmdargs = $string_utils:left(cmd[1] + " ", 12) + cmd[2], @col[c]};
  endfor
endfor
i1 = length(col[1]);
i2 = length(col[2]);
right = 0;
while (i1 || i2)
  if (!(i1 && length(col[1][i1]) > 35 || (i2 && length(col[2][i2]) > 35)))
    d = {@d, $string_utils:left(i1 ? col[1][i1] | "", 40) + (i2 ? col[2][i2] | "")};
    i1 && (i1 = i1 - 1);
    i2 && (i2 = i2 - 1);
    right = 0;
  elseif (right && i2)
    d = {@d, length(col[2][i2]) > 35 ? $string_utils:right(col[2][i2], 75) | $string_utils:space(40) + col[2][i2]};
    i2 = i2 - 1;
    right = 0;
  elseif (i1)
    d = {@d, col[1][i1]};
    i1 = i1 - 1;
    right = 1;
  else
    right = 1;
  endif
endwhile
return {@d, "", "----  Do `help <cmdname>' for help with a given command.  ----", "", "  <ins> ::= $ (the end) | [^]n (above line n) | _n (below line n) | . (current)", "<range> ::= <lin> | <lin>-<lin> | from <lin> | to <lin> | from <lin> to <lin>", "  <lin> ::= n | [n]$ (n from the end) | [n]_ (n before .) | [n]^ (n after .)", "`help insert' and `help ranges' describe these in detail.", @this.description};
