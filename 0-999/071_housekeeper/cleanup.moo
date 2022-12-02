#71:cleanup   this none this rxd

"$housekeeper:cleanup([insist]) => clean up player's objects. Argument is 'up' or 'up!' for manually requested cleanups (notify player differently)";
if (caller_perms() != this)
  return E_PERM;
endif
for object in (this.clean)
  x = object in this.clean;
  if (this.requestors[x] == player)
    if (result = this:replace(object, @args))
      player:tell(result, ".");
    endif
  endif
  $command_utils:suspend_if_needed(0);
endfor
player:tell("The housekeeper has finished cleaning up your objects.");
