#124:cmd_count   this none this rxd

{state} = args;
if (length(state.arg) == 1 && state.arg[1] in {"line", "lines"} || !state.arg)
  player:tell("Lines: ", length(state.text));
endif
if (length(state.arg) == 1 && state.arg[1] in {"character", "letters", "chars", "char", "characters"} || !state.arg)
  chars = 0;
  for x in (state.text)
    chars = chars + length(x);
  endfor
  player:tell("Characters: ", chars);
endif
if (length(state.arg) == 1 && state.arg[1] in {"word", "words"} || !state.arg)
  words = 0;
  for x in (state.text)
    words = words + length($string_utils:words(x));
  endfor
  player:tell("Words: ", words);
endif
