#7:move   this none this rxd

set_task_perms(caller_perms());
what = args[1];
"if ((what.location != this.source) || (!(this in this.source.exits)))";
"  player:tell(\"You can't go that way.\");";
"  return;";
"endif";
unlocked = this:is_unlocked_for(what);
if (unlocked)
  this.dest:bless_for_entry(what);
endif
if (unlocked && this.dest:acceptable(what))
  start = what.location;
  if (msg = this:leave_msg(what))
    what:tell_lines(msg);
  endif
  what:moveto(this.dest);
  if (what.location != start)
    "Don't print oleave messages if WHAT didn't actually go anywhere...";
    this:announce_msg(start, what, this:oleave_msg(what) || this:defaulting_oleave_msg(what) || "has left.");
  endif
  if (what.location == this.dest)
    "Don't print arrive messages if WHAT didn't really end up there...";
    if (msg = this:arrive_msg(what))
      what:tell_lines(msg);
    endif
    this:announce_msg(what.location, what, this:oarrive_msg(what) || "has arrived.");
  endif
else
  if (msg = this:nogo_msg(what))
    what:tell_lines(msg);
  else
    what:tell("You can't go that way.");
  endif
  if (msg = this:onogo_msg(what))
    this:announce_msg(what.location, what, msg);
  endif
endif
