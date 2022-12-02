#88:page_echo_msg   this none this rxd

"'page_echo_msg ()' - Return a message to inform the pager what happened to their page.";
if (task_id() == this.page_refused)
  this:report_refusal(player, "You just refused a page from ", player.name, ".");
  return this:page_refused_msg();
else
  return pass(@args);
endif
