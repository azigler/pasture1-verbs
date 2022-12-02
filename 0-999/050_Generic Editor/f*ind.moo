#50:f*ind   any any any rxd

if (callers() && caller != this)
  return E_PERM;
endif
if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
elseif (typeof(subst = this:parse_subst(argstr && argstr[1] + argstr, "c", "Empty search string?")) != LIST)
  player:tell(tostr(subst));
elseif (typeof(start = subst[4] ? this:parse_insert(who, subst[4]) | this.inserting[who]) == ERR)
  player:tell("Starting from where?", subst[4] ? "  (can't parse " + subst[4] + ")" | "");
else
  search = subst[2];
  case = !index(subst[3], "c", 1);
  text = this.texts[who];
  tlen = length(text);
  while (start <= tlen && !index(text[start], search, case))
    start = start + 1;
  endwhile
  if (start > tlen)
    player:tell("`", search, "' not found.");
  else
    this.inserting[who] = start + 1;
    this:list_line(who, start);
  endif
endif
