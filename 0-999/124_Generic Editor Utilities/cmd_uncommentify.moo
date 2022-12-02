#124:cmd_uncommentify   this none this rxd

{state} = args;
if (!state.arg)
  player:tell("You must include what lines you wish to uncomment.");
  return E_INVARG;
endif
range = this:parse_range(state.arg, length(state.text), state.ins);
if (typeof(range) == STR)
  player:tell(range);
  return E_INVARG;
endif
{start, end} = range;
bogus = {};
for x in [start..end]
  if (length(state.text[x]) > 3 && state.text[x][1] == "\"" && state.text[x][$ - 1..$] == "\";")
    state.text[x] = state.text[x][2..$ - 2];
  else
    bogus = {@bogus, state.text[x]};
  endif
endfor
player:tell("Line", end < start ? "s" | "", " uncommented.");
if (bogus)
  player:tell("---", length(bogus), " ", $s("line", length(bogus)), " ", start < end ? "were" | "was", " not comments.");
endif
