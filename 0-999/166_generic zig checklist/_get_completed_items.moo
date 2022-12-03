#166:_get_completed_items   this none this rxd

completed_list = {};
for item, index in (this.completed)
  completed_list = listappend(completed_list, tostr(index) + ". " + item[1] + " [Crossed off by " + item[2] + "]");
endfor
return completed_list;
