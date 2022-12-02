#95:expl*ode   any any any rd

if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
elseif (typeof(range = this:parse_range(who, {"_", "1"}, @args)) != LIST)
  player:tell(range);
elseif (range[3])
  player:tell("Junk at end of cmd:  ", range[3]);
else
  text = this.texts[who];
  newins = ins = this.inserting[who];
  start = range[1];
  if (typeof(debris = this:explode_line("", text[start])) == STR)
    player:tell("Line ", start, ":  ", debris);
    return;
  endif
  if (!debris[1])
    debris = listdelete(debris, 1);
  endif
  newlines = {};
  for line in (text[i = start + 1..end = range[2]])
    dlen = length(debris);
    newlines = {@newlines, @debris[1..dlen - 1]};
    if (ins == i)
      newins = start + length(newlines) + 1;
    endif
    if (typeof(debris = this:explode_line(debris[dlen], line)) == STR)
      player:tell("Line ", i, ":  ", debris);
      return;
    endif
    i = i + 1;
  endfor
  explen = length(newlines) + length(debris);
  if (ins > end)
    newins = ins - (end - start + 1) + explen;
  endif
  this.texts[who] = {@text[1..start - 1], @newlines, @debris, @text[end + 1..length(text)]};
  this.inserting[who] = newins;
  player:tell("--> ", start, "..", start + explen - 1);
endif
