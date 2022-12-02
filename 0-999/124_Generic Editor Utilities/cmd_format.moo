#124:cmd_format   this none this rxd

{state} = args;
if (!state.text)
  player:tell("No text to format.");
  return E_INVARG;
endif
ind = 1;
reformatted = {};
player:tell("Formatting...");
for x in (state.text)
  if (length(x) > abs(player:linelen()))
    player:tell("Line ", ind, " too long: reformatting.");
    reformatted = {@reformatted, @player:linesplit(x, abs(player:linelen()))};
  else
    reformatted = {@reformatted, x};
  endif
  ind = ind + 1;
endfor
state.text = reformatted;
player:tell("Done.");
