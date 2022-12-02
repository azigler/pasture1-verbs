#9:er*ase   this none none rxd

if (this:is_writable_by(valid(caller_perms()) ? caller_perms() | player))
  this:set_text({});
  player:tell("Note erased.");
else
  player:tell("You can't erase this note.");
endif
