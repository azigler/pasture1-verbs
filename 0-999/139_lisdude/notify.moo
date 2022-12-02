#139:notify   this none this rxd

"Your basic, run-of-the-mill ansi-spoofing notify verb. Standard issue.";
if (`this.notify ! E_PROPNF' && (this.notify == 3 || (`index($ansi_utils:delete(tostr(args[1])), player.name) ! ANY' == 0 && player != this)))
  args[1] = tostr(args[1], "     -[yellow]", player.name, " (", player, ") ", this.notify == 2 ? "" | toliteral(callers(1)), "[normal]");
endif
return pass(@args);
