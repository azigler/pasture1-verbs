#50:print   none none none rd

txt = this:text(player in this.active);
if (typeof(txt) == LIST)
  player:tell_lines(txt);
else
  player:tell("Text unreadable:  ", txt);
endif
player:tell("--------------------------");
