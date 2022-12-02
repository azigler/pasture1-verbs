#50:join*literal   any any any rd

if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
elseif (typeof(range = this:parse_range(who, {"_-^", "_", "^"}, @args)) != LIST)
  player:tell(range);
elseif (range[3])
  player:tell("Junk at end of cmd:  ", range[3]);
elseif (!(result = this:join_lines(who, @range[1..2], length(verb) <= 4)))
  player:tell(result == 0 ? "Need at least two lines to join." | result);
else
  this:list_line(who, range[1]);
endif
