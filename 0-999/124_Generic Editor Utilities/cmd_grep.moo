#124:cmd_grep   this none this rxd

{state} = args;
if (!state.text)
  player:tell("There is no text to search.");
  return E_INVARG;
elseif (!state.arg)
  player:tell("Usage: FIND <text>");
  return E_INVARG;
endif
hohum = state.ins == length(state.text) + 1 ? 1 | state.ins;
"Note: If the caret is at the bottom, search the full text instead of nothing.";
found = 0;
for x in (state.text[hohum..$])
  if (index(x, hoargs = $string_utils:from_list(state.arg, " ")))
    found = hohum;
    break;
  endif
  hohum = hohum + 1;
endfor
if (!found)
  player:tell("No text matching `", $string_utils:from_list(state.arg, " "), "'.");
  return E_INVARG;
endif
state.ins = found + 1;
player:tell(found, ": ", state.text[found]);
