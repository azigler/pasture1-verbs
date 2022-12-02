#6:notify   this none this rxd

line = args[1];
if (!(this in connected_players()))
  "...drop it on the floor...";
  return 0;
elseif (caller != this && !$perm_utils:controls(caller_perms(), this))
  return E_PERM;
endif
if (this.pagelen)
  "...need wizard perms if this and this.owner are different, since...";
  "...only this can notify() and only this.owner can read .linebuffer...";
  if (player == this && this.linetask[2] != task_id())
    "...player has started a new task...";
    "....linetask[2] is the taskid of the most recent player task...";
    if (this.linetask[2] != this.linetask[1])
      this.linesleft = this.pagelen - 2;
    endif
    this.linetask[2] = task_id();
  endif
  "... digest the current line...";
  if (this.linelen > 0)
    lbuf = {@this.linebuffer, @this:linesplit(line, this.linelen)};
  else
    lbuf = {@this.linebuffer, line};
  endif
  "... print out what we can...";
  if (this.linesleft)
    howmany = min(this.linesleft, length(lbuf));
    for l in (lbuf[1..howmany])
      pass(l);
    endfor
    this.linesleft = this.linesleft - howmany;
    lbuf[1..howmany] = {};
  endif
  if (lbuf)
    "...see if we need to say ***More***";
    if (this.linetask[1] != this.linetask[2])
      "....linetask[1] is the taskid of the most recent player task";
      "...   for which ***More*** was printed...";
      this.linetask[1] = this.linetask[2];
      fork (0)
        if (lb = this.linebuffer)
          pass(strsub(this.more_msg, "%n", tostr(length(lb))));
        endif
      endfork
    endif
    llen = length(lbuf);
    if (llen > 500)
      "...way too much saved text, flush some of it...";
      lbuf[1..llen - 100] = {"*** buffer overflow, lines flushed ***"};
    endif
  endif
  this.linebuffer = lbuf;
else
  if (this.linelen > 0)
    for l in (this:linesplit(line, this.linelen))
      pass(l);
    endfor
  else
    pass(line);
  endif
endif
