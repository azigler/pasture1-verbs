#49:comment   any any any rd

"Syntax: comment [<range>]";
"";
"Turns the specified range of lines, into comments.";
if (caller != player && caller_perms() != player)
  return E_PERM;
elseif (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
elseif (typeof(range = this:parse_range(who, {"."}, @args)) != LIST)
  player:tell(tostr(range));
elseif (range[3])
  player:tell_lines($code_utils:verb_documentation());
else
  text = this.texts[who];
  {from, to, crap} = range;
  cut = $maxint;
  for line in [from..to]
    cut = min(cut, `match(text[line], "[^ ]")[1] ! E_RANGE => 1');
  endfor
  for line in [from..to]
    text[line] = toliteral(text[line][cut..$]) + ";";
  endfor
  this.texts[who] = text;
  player:tell(to == from ? "Line" | "Lines", " changed.");
  this.changes[who] = 1;
  this.times[who] = time();
endif
