#50:fill   any any any rd

fill_column = 70;
if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
elseif (typeof(range = this:parse_range(who, {"_", "1"}, @args)) != LIST)
  player:tell(range);
elseif (range[3] && (range[3][1] != "@" || (fill_column = toint(range[3][2..$])) < 10))
  player:tell("Usage:  fill [<range>] [@ column]   (where column >= 10).");
else
  join = this:join_lines(who, @range[1..2], 1);
  newlines = this:fill_string((text = this.texts[who])[from = range[1]], fill_column);
  if (fill = (nlen = length(newlines)) > 1 || newlines[1] != text[from])
    this.texts[who] = {@text[1..from - 1], @newlines, @text[from + 1..$]};
    if ((insert = this.inserting[who]) > from && nlen > 1)
      this.inserting[who] = insert + nlen - 1;
    endif
  endif
  if (fill || join)
    for line in [from..from + nlen - 1]
      this:list_line(who, line);
    endfor
  else
    player:tell("No changes.");
  endif
endif
