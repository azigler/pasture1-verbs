#124:cmd_list   this none this rxd

{state} = args;
if (!state.text)
  player:tell("No text to list.");
  return E_INVARG;
  "     elseif (!state.arg)";
  "       player:tell(\"List what lines? (Line ranges from 1 to \", state.ins-1, \".)\");";
else
  if (!state.arg)
    if (state.ins + 8 > length(state.text))
      listuntil = length(state.text);
    else
      listuntil = state.ins + 8;
    endif
    if (state.ins - 8 <= 0)
      listfrom = 1;
    else
      listfrom = state.ins - 8;
    endif
    range = {listfrom, listuntil};
  elseif (state.arg == {"all"})
    range = {1, length(state.text)};
  else
    range = this:parse_range(state.arg, length(state.text), state.ins);
    if (typeof(range) == STR)
      player:tell(range);
      return E_INVARG;
    endif
  endif
  {start, end} = range;
  ind = start;
  "Since we don't want to introduce ANSI into the actual text, we'll create a temp variable.";
  if (state.verb && "highlight_syntax" in player.prog_options)
    list_text = $code_utils:highlight_syntax(state.text[start..end]);
  else
    list_text = state.text[start..end];
  endif
  for x in (list_text)
    $command_utils:suspend_if_needed(0);
    line_color = this:get_opt("color_line");
    player:tell(line_color != "" ? $ansi_utils:hr_to_code(line_color) | "", ind, line_color != "" ? "" | "", ": ", typeof(x) != STR ? toliteral(x) | x);
    ind = ind + 1;
    if (ind == state.ins)
      ind_color = this:get_opt("color_indicator");
      player:tell(ind_color != "" ? $ansi_utils:hr_to_code(ind_color) | "", "^^^^", ind_color != "" ? "" | "");
    endif
  endfor
endif
