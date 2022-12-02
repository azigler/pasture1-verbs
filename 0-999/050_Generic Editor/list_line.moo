#50:list_line   this none this rxd

$ansi_utils:add_noansi();
if (this:ok(who = args[1]))
  f = 1 + ((line = args[2]) in {(ins = this.inserting[who]) - 1, ins});
  player:tell($string_utils:right(line, 3, " _^"[f]), ":_^"[f], " ", this.texts[who][line]);
endif
$ansi_utils:remove_noansi();
