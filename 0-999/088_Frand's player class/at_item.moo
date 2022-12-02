#88:at_item   this none this rxd

"'at_item (<location>, <party>)' - Given a location and a list of the people there, return a string displaying the information. Override this if you want to change the format of each line of @at's output.";
{loc, party} = args;
su = $string_utils;
if (this.at_number)
  number = su:right(tostr(loc), 7) + " ";
else
  number = "";
endif
room = su:left(valid(loc) ? loc.name | "[Nowhere]", this.at_room_width);
if (length(room) > this.at_room_width)
  room = room[1..this.at_room_width];
endif
text = number + room + " ";
if (party)
  filler = su:space(length(text) - 2);
  line = text;
  text = {};
  for who in (party)
    name = " " + (valid(who) ? who.name | "[Nobody]");
    if (length(line) + length(name) > this:linelen())
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
