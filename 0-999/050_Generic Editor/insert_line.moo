#50:insert_line   this none this rxd

":insert_line([who,] line or list of lines [,quiet])";
"  inserts the given text at the insertion point.";
"  returns E_NONE if the session has no text loaded yet.";
if (typeof(args[1]) != INT)
  args = {player in this.active, @args};
endif
{who, lines, ?quiet = this.active[who]:edit_option("quiet_insert")} = args;
if (!(fuckup = this:ok(who)))
  return fuckup;
elseif (typeof(text = this.texts[who]) != LIST)
  return E_NONE;
else
  if (typeof(lines) != LIST)
    lines = {lines};
  endif
  p = this.active[who];
  insert = this.inserting[who];
  this.texts[who] = {@text[1..insert - 1], @lines, @text[insert..$]};
  this.inserting[who] = insert + length(lines);
  if (lines)
    if (!this.changes[who])
      this.changes[who] = 1;
      this.times[who] = time();
    endif
    if (!quiet)
      if (length(lines) != 1)
        p:tell("Lines ", insert, "-", insert + length(lines) - 1, " added.");
      else
        p:tell("Line ", insert, " added.");
      endif
    endif
  else
    p:tell("No lines added.");
  endif
endif
