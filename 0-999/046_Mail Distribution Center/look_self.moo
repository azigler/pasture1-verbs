#46:look_self   this none this rxd

player:tell_lines(this.description);
for c in (this.contents)
  $command_utils:suspend_if_needed(0);
  c:look_self();
endfor
