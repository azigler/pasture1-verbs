#24:is_wizard   this none this rxd

":is_wizard(who) => whether `who' is a wizard or is the .public_identity of some wizard.";
"This verb is used for permission checks on commands that should only be accessible to wizards or their ordinary-player counterparts.  It will return true for unadvertised wizards.";
who = args[1];
if (who.wizard)
  return 1;
else
  for w in ($object_utils:leaves($wiz))
    if (w.wizard && is_player(w) && who == `w.public_identity ! ANY')
      return 1;
    endif
  endfor
endif
return 0;
