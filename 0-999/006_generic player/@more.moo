#6:@more   any none none rd

if (player != this)
  "... somebody's being sneaky...";
  "... Can't do set_task_perms(player) since we need to be `this'...";
  "... to notify and `this.owner' to change +c properties...";
  return;
elseif (!(lbuf = this.linebuffer))
  this.linesleft = this.pagelen - 2;
  notify(this, "*** No more ***");
elseif (index("flush", dobjstr || "x") == 1)
  this.linesleft = this.pagelen - 2;
  notify(this, tostr("*** Flushed ***  ", length(lbuf), " lines"));
  this.linebuffer = {};
elseif (index("rest", dobjstr || "x") == 1 || !this.pagelen)
  this.linesleft = this.pagelen - 2;
  for l in (lbuf)
    notify(this, l);
  endfor
  this.linebuffer = {};
else
  howmany = min(this.pagelen - 2, llen = length(lbuf = this.linebuffer));
  for l in (lbuf[1..howmany])
    notify(this, l);
  endfor
  this.linesleft = this.pagelen - 2 - howmany;
  this.linebuffer = lbuf[howmany + 1..llen];
  if (howmany < llen)
    notify(this, strsub(this.more_msg, "%n", tostr(llen - howmany)));
    this.linetask[1] = task_id();
  endif
endif
this.linetask[2] = task_id();
