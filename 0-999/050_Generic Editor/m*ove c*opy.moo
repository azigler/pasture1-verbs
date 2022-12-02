#50:"m*ove c*opy"   any any any rd

verb = (is_move = verb[1] == "m") ? "move" | "copy";
if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
  return;
endif
wargs = args;
t = to_pos = 0;
while (t = "to" in (wargs = wargs[t + 1..$]))
  to_pos = to_pos + t;
endwhile
range_args = args[1..to_pos - 1];
if (!to_pos || ERR == typeof(dest = this:parse_insert(who, $string_utils:from_list(wargs, " "))))
  player:tell(verb, " to where? ");
elseif (dest < 1 || dest > (last = length(this.texts[who])) + 1)
  player:tell("Destination (", dest, ") out of range.");
elseif ("from" in range_args || "to" in range_args)
  player:tell("Don't use that kind of range specification with this command.");
elseif (typeof(range = this:parse_range(who, {"_", "^"}, @args[1..to_pos - 1])) != LIST)
  player:tell(range);
elseif (range[3])
  player:tell("Junk before `to':  ", range[3]);
elseif (is_move && dest >= range[1] && dest <= range[2] + 1)
  player:tell("Destination lies inside range of lines to be moved.");
else
  from = range[1];
  to = range[2];
  ins = this.inserting[who];
  text = this.texts[who];
  if (!is_move)
    this.texts[who] = {@text[1..dest - 1], @text[from..to], @text[dest..last]};
    if (ins >= dest)
      this.inserting[who] = ins + to - from + 1;
    endif
  else
    "oh shit... it's a move";
    if (dest < from)
      newtext = {@text[1..dest - 1], @text[from..to], @text[dest..from - 1], @text[to + 1..last]};
      if (ins >= dest && ins <= to)
        ins = ins > from ? ins - from + dest | ins + to - from + 1;
      endif
    else
      newtext = {@text[1..from - 1], @text[to + 1..dest - 1], @text[from..to], @text[dest..last]};
      if (ins > from && ins < dest)
        ins = ins <= to ? ins + dest - to - 1 | ins - to + from - 1;
      endif
    endif
    this.texts[who] = newtext;
    this.inserting[who] = ins;
  endif
  if (!this.changes[who])
    this.changes[who] = 1;
    this.times[who] = time();
  endif
  player:tell("Lines ", is_move ? "moved." | "copied.");
endif
