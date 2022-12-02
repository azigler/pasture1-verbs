#50:@rmstateprop   any (out of/from inside/from) this rd

if (!$perm_utils:controls(player, this))
  player:tell(E_PERM);
elseif (typeof(result = this:set_stateprops(dobjstr)) == ERR)
  player:tell(result != E_NACC ? result | dobjstr + " is already a property on an ancestral editor.");
else
  player:tell("Property removed.");
endif
