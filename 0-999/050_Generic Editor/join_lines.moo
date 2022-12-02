#50:join_lines   this none this rxd

{who, from, to, english} = args;
if (!(fuckup = this:ok(who)))
  return fuckup;
elseif (from >= to)
  return 0;
else
  nline = "";
  for line in ((text = this.texts[who])[from..to])
    if (!english)
      nline = nline + line;
    else
      len = length(line) + 1;
      while ((len = len - 1) && line[len] == " ")
      endwhile
      if (len > 0)
        nline = nline + line + (index(".:", line[len]) ? "  " | " ");
      endif
    endif
  endfor
  this.texts[who] = {@text[1..from - 1], nline, @text[to + 1..$]};
  if ((insert = this.inserting[who]) > from)
    this.inserting[who] = insert <= to ? from + 1 | insert - to + from;
  endif
  if (!this.changes[who])
    this.changes[who] = 1;
    this.times[who] = time();
  endif
  return to - from;
endif
