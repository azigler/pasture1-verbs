#50:append_line   this none this rxd

":append_line([who,] string)";
"  appends the given string to the line before the insertion point.";
"  returns E_NONE if the session has no text loaded yet.";
if (typeof(args[1]) != INT)
  args = {player in this.active, @args};
endif
{who, string} = args;
if (!(fuckup = this:ok(who)))
  return fuckup;
elseif ((append = this.inserting[who] - 1) < 1)
  return this:insert_line(who, {string});
elseif (typeof(text = this.texts[who]) != LIST)
  return E_NONE;
else
  this.texts[who][append] = text[append] + string;
  if (!this.changes[who])
    this.changes[who] = 1;
    this.times[who] = time();
  endif
  p = this.active[who];
  if (!p:edit_option("quiet_insert"))
    p:tell("Appended to line ", append, ".");
  endif
endif
