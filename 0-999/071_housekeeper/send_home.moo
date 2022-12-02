#71:send_home   this none this rxd

if (caller != this)
  return E_PERM;
endif
litter = args[1];
littering = litter.location;
this:ejectit(litter, littering);
home = litter.location;
if ($object_utils:isa(home, $room))
  home:announce_all("The ", this.name, " sneaks in, deposits ", litter:title(), " and leaves.");
else
  home:tell("You notice the ", this.name, " sneak in, give you ", litter:title(), " and leave.");
endif
if ($object_utils:has_callable_verb(littering, "announce_all_but"))
  littering:announce_all_but({litter}, "The ", this.name, " sneaks in, picks up ", litter:title(), " and rushes off to put it away.");
endif
