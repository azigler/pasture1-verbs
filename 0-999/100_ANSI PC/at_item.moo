#100:at_item   this none this rxd

"'at_item (<location>, <party>)' - Given a location and a list of the people there, return a string displaying the information. Override this if you want to change the format of each line of @at's output.";
loc = args[1];
party = args[2];
su = $string_utils;
number = this.at_number ? su:right(tostr(loc), 7) + " " | "";
room = su:left(valid(loc) ? loc.name | "[Nowhere]", this.at_room_width);
$ansi_utils:length(room) > this.at_room_width && (room = $ansi_utils:cutoff(room, 1, this.at_room_width));
text = number + room + " ";
if (party)
  filler = su:space(length(text) - 2);
  line = text;
  text = {};
  for who in (party)
    name = " " + (valid(who) ? who.name | "[Nobody]");
    if ($ansi_utils:length(line) + $ansi_utils:length(name) > this:linelen())
      text = {@text, line};
      line = filler + name;
    else
      line = line + name;
    endif
  endfor
  text = {@text, line};
else
  text = text + " [deserted]";
endif
return text;
