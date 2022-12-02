#16:search   this (for/about) any rxd

who = caller_perms();
if (who != #-1 && !(who == player || caller == this) || !(who.wizard || who in $local.registrar_pet_core.members))
  raise(E_PERM);
endif
total = 0;
player:tell("Searching...");
for k in ($registration_db:find_all_keys(""))
  $command_utils:suspend_if_needed(0);
  line = k + " " + toliteral($registration_db:find_exact(k));
  if (index(line, iobjstr))
    player:tell(line);
    total = total + 1;
  endif
endfor
player:tell("Search over.  ", total, " matches found.");
