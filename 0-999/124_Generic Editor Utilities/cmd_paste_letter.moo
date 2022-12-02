#124:cmd_paste_letter   this none this rxd

{state} = args;
letters = {};
for x in (player.contents)
  if (x != 0 && (isa(x, $note) || isa(x, $letter)) && x:is_readable_by(player))
    letters = {@letters, x};
  endif
endfor
if (letters == {})
  player:tell("You are not carrying any notes.");
else
  if (length(letters) > 1)
    player:tell("Pick a note to paste into the working text.");
    letter = letters[$command_utils:menu(letters)];
  else
    letter = letters[1];
  endif
  if ($command_utils:yes_or_no(tostr("Really insert the text of ", letter:title(), "?")) == 1)
    state.text = {@state.text[1..state.ins - 1], @letter:text(), @state.text[state.ins..$]};
    player:tell("Text inserted.");
  endif
endif
