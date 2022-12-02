#45:is_usable_by   this none this rxd

who = args[1];
if (this.moderated)
  return `who in this.moderated ! E_TYPE' || (this:is_writable_by(who) || who.wizard);
else
  return this.guests_can_send_here || !$object_utils:isa(who, $guest);
endif
