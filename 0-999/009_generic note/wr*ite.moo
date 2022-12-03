#9:wr*ite   any (on top of/on/onto/upon) this rxd

if (this:is_writable_by(valid(caller_perms()) ? caller_perms() | player))
  this:set_text({@this.text, dobjstr});
  $you:say_action("%N %<writes> \"" + dobjstr + "\" on %i.");
else
  player:tell("You can't write on this note.");
endif
