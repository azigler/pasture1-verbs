#50:"ins*ert n*ext p*revious ."   any none none rd

if (i = index(argstr, "\""))
  text = argstr[i + 1..$];
  argstr = argstr[1..i - 1];
else
  text = 0;
endif
spec = $string_utils:trim(argstr);
if (index("next", verb) == 1)
  verb = "next";
  spec = "+" + (spec || "1");
elseif (index("prev", verb) == 1)
  verb = "prev";
  spec = "-" + (spec || "1");
else
  spec = spec || ".";
endif
if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
elseif (ERR == typeof(number = this:parse_insert(who, spec)))
  if (verb in {"next", "prev"})
    player:tell("Argument must be a number.");
  else
    player:tell("You must specify an integer or `$' for the last line.");
  endif
elseif (number > (max = length(this.texts[who]) + 1) || number < 1)
  player:tell("That would take you out of range (to line ", number, "?).");
else
  this.inserting[who] = number;
  if (typeof(text) == STR)
    this:insert_line(who, text);
  else
    if (verb != "next")
      number > 1 ? this:list_line(who, number - 1) | player:tell("____");
    endif
    if (verb != "prev")
      number < max ? this:list_line(who, number) | player:tell("^^^^");
    endif
  endif
endif
