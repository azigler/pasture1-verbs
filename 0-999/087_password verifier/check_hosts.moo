#87:check_hosts   this none this rxd

{pwd, who} = args;
if (!$perm_utils:controls(caller_perms(), who))
  return "Permission denied.";
endif
hosts = who.all_connect_places;
for x in (hosts)
  if (index(x, pwd))
    return "Passwords may not match hostnames.";
  endif
endfor
