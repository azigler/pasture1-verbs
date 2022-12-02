#100:notify   this none this rx

if (!(caller == this || $perm_utils:controls(caller_perms(), this)))
  return E_PERM;
endif
line = args[1];
if (!valid(au = $ansi_utils))
  return pass(@args);
elseif ("normal" in (typeof(z = this.replace_codes) == NUM ? au.replace_code_pointers[z] | z) && !(task_id() in au.noansi_queue))
  line = au:terminate_normal(line);
endif
if (this.pagelen)
  if (!(this in connected_players()))
    "...drop it on the floor...";
    return 0;
  endif
  "...need wizard perms if this and this.owner are different, since...";
  "...only this can notify() and only this.owner can read .linebuffer...";
  if (player == this && this.linetask[2] != task_id())
    "...player has started a new task...";
    "....linetask[2] is the taskid of the most recent player task...";
    this.linetask[2] != this.linetask[1] && (this.linesleft = this.pagelen - 2);
    this.linetask[2] = task_id();
  endif
  "... digest the current line...";
  li = this.linelen ? this:linesplit(line, abs(this.linelen)) | {line};
  lbuf = {@this.linebuffer, @li};
  "... print out what we can...";
  if (this.linesleft)
    howmany = min(this.linesleft, length(lbuf));
    for l in (lbuf[1..howmany])
      au:notify(this, l);
      "notify(this, l, nocr);";
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
        notify(this, strsub(this.more_msg, "%n", tostr(length(this.linebuffer))));
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
      au:notify(this, l);
    endfor
  else
    au:notify(this, line);
  endif
endif
