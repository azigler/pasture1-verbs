#88:receive_page   this none this rxd

"'receive_page (<message>)' - Receive a page. If the page is accepted, pass(@args) shows it to the player.";
if (this:refuses_action(player, "page"))
  this.page_refused = task_id();
  return 0;
endif
this.page_refused = 0;
return pass(@args);
