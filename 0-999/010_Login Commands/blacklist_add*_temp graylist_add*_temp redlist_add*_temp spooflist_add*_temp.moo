#10:"blacklist_add*_temp graylist_add*_temp redlist_add*_temp spooflist_add*_temp"   this none this rxd

"To add a temporary entry, only call the `temp' version.";
"blacklist_add_temp(Site, start time, duration)";
if (!caller_perms().wizard)
  return E_PERM;
endif
{where, ?start, ?duration} = args;
lname = this:listname(verb);
which = 1 + !$site_db:domain_literal(where);
if (index(verb, "temp"))
  lname = "temporary_" + lname;
  this.(lname)[which] = setadd(this.(lname)[which], {where, start, duration});
else
  this.(lname)[which] = setadd(this.(lname)[which], where);
endif
return 1;
