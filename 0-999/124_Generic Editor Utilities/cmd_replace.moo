#124:cmd_replace   this none this rxd

{state} = args;
if (length(state.arg) < 1)
  player:tell("Usage: ", this:get_option("cmd_char"), "", state.command, " <PCRE replacement>");
  return E_INVARG;
elseif (!state.text)
  player:tell("There is no text to change.");
  return E_INVARG;
else
  changed = 0;
  success = 1;
  range = {1, length(state.text)};
  if (length(state.arg) >= 2 && typeof(this:parse_range(state.arg[$], length(state.text), state.ins)) == LIST)
    range = this:parse_range(state.arg[$], length(state.text), state.ins);
    player:tell("(Running replacement", range[1] != range[2] ? "s" | "", " on ", range[1] == range[2] ? "line " + tostr(range[1]) | tostr("lines ", range[1], " to ", range[2]), ".)");
  endif
  for I in [range[1]..range[2]]
    try
      newline = pcre_replace(state.text[I], $string_utils:from_list(state.arg));
    except e (ANY)
      player:tell("Error on line ", I, ": ", e[2]);
      success = 0;
      break;
    endtry
    if (newline != state.text[I])
      changed = changed + 1;
      state.text[I] = newline;
    endif
    yin();
  endfor
  player:tell("Replacement ", success ? "complete" | "failed", ". ", changed, " ", $s("line", changed), " affected.");
endif
