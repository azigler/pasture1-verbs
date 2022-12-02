#50:s*ubst   any any any rxd

if (callers() && caller != this)
  return E_PERM;
elseif (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
elseif (typeof(subst = this:parse_subst(argstr)) != LIST)
  player:tell(tostr(subst));
elseif (typeof(range = this:parse_range(who, {"_", "1"}, @$string_utils:explode(subst[4]))) != LIST)
  player:tell(range);
elseif (range[3])
  player:tell("Junk at end of cmd:  ", range[3]);
else
  {fromstr, tostr, specs, dummy} = subst;
  global = index(specs, "g", 1);
  regexp = index(specs, "r", 1);
  case = !index(specs, "c", 1);
  munged = {};
  text = this.texts[who];
  changed = {};
  {from, to} = range[1..2];
  for line in [from..to]
    t = t0 = text[line];
    if (!fromstr)
      t = tostr + t;
    elseif (global)
      if (regexp)
        while (new = this:subst_regexp(t, fromstr, tostr, case))
          t = new;
        endwhile
      else
        t = strsub(t, fromstr, tostr, case);
      endif
    else
      if (regexp)
        (new = this:subst_regexp(t, fromstr, tostr, case)) && (t = new);
      else
        (i = index(t, fromstr, case)) && (t = t[1..i - 1] + tostr + t[i + length(fromstr)..length(t)]);
      endif
    endif
    if (strcmp(t0, t))
      changed = {@changed, line};
    endif
    munged = {@munged, t};
  endfor
  if (!changed)
    player:tell("No changes in line", from == to ? tostr(" ", from) | tostr("s ", from, "-", to), ".");
  else
    this.texts[who] = {@text[1..from - 1], @munged, @text[to + 1..$]};
    if (!this.changes[who])
      this.changes[who] = 1;
      this.times[who] = time();
    endif
    for line in (changed)
      this:list_line(who, line);
    endfor
  endif
endif
