#24:check_prog_restricted   this none this rxd

"Checks to see if args[1] is restricted from programmer either permanently or temporarily. Removes from temporary list if time is up";
if (caller != this && !$perm_utils:controls(caller_perms(), this))
  return E_PERM;
endif
if ((who = args[1]) in this.programmer_restricted)
  "okay, who is restricted. Now check to see if it is temporary";
  if (entry = $list_utils:assoc(who, this.programmer_restricted_temp))
    if ($login:uptime_since(entry[2]) > entry[3])
      "It's temporary and the time is up, remove and return false";
      this.programmer_restricted_temp = setremove(this.programmer_restricted_temp, entry);
      this.programmer_restricted = setremove(this.programmer_restricted, who);
      return 0;
    else
      "time is not up";
      return 1;
    endif
  else
    return 1;
  endif
else
  return 0;
endif
