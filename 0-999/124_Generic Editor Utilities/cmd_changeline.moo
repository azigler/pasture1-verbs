#124:cmd_changeline   this none this rxd

{state} = args;
if (length(state.arg) < 2)
  player:tell("Usage: ", this:get_option("cmd_char"), "", state.command, " <line-number> <new-text>");
  return E_INVARG;
elseif (!state.text)
  player:tell("There is no text to change.");
  return E_INVARG;
else
  if (state.arg[1] == "$")
    NUM = length(state.text);
  elseif (state.arg[1] == "^")
    NUM = state.ins;
  else
    NUM = toint(state.arg[1]);
  endif
  if (NUM < 1 || NUM > length(state.text))
    player:tell("There is no line with that number. Lines range from 1 to ", length(state.text), ".");
    return E_INVARG;
  else
    newline = $string_utils:from_list(state.arg[2..$], " ");
    state.text[NUM] = newline;
    player:tell("Line ", NUM, " changed.");
  endif
endif
