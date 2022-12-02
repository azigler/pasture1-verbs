#6:receive_page   this none this rxd

"called by $player:page.  Two args, the page header and the text, all pre-processed by the page command.  Could be extended to provide haven abilities, multiline pages, etc.  Indeed, at the moment it just does :tell_lines, so we already do have multiline pages, if someone wants to take advantage of it.";
"Return codes:";
"  1:  page was received";
"  2:  player is not connected";
"  0:  page refused";
"If a specialization wants to refuse a page, it should return 0 to say it was refused.  If it uses pass(@args) it should propagate back up the return value.  It is possible that this code should interact with gagging and return 0 if the page was gagged.";
if (this:is_listening())
  this:tell_lines_suspended(args);
  return 1;
else
  return 2;
endif
