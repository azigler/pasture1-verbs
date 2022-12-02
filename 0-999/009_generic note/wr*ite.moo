#9:wr*ite   any (on top of/on/onto/upon) this rxd

if (this:is_writable_by(valid(caller_perms()) ? caller_perms() | player))
  this:set_text({@this.text, dobjstr});
  player:tell("Line added to note.");
  player.location:announce_all_but({player}, player.name + " writes \"" + dobjstr + "\" on " + this.name + ".");
else
  player:tell("You can't write on this note.");
endif
