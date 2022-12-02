#50:del*ete   any any any rd

if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
elseif (typeof(range = this:parse_range(who, {"_", "1"}, @args)) != LIST)
  player:tell(range);
elseif (range[3])
  player:tell("Junk at end of cmd:  ", range[3]);
else
  player:tell_lines((text = this.texts[who])[from = range[1]..to = range[2]]);
  player:tell("---Line", to > from ? "s" | "", " deleted.  Insertion point is before line ", from, ".");
  this.texts[who] = {@text[1..from - 1], @text[to + 1..$]};
  if (!this.changes[who])
    this.changes[who] = 1;
    this.times[who] = time();
  endif
  this.inserting[who] = from;
endif
