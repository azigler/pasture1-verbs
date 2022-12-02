#8:tell_contents   this none this rxd

if (this.contents)
  player:tell("Contents:");
  for thing in (this:contents())
    player:tell("  ", thing:title());
  endfor
elseif (msg = this:empty_msg())
  player:tell(msg);
endif
