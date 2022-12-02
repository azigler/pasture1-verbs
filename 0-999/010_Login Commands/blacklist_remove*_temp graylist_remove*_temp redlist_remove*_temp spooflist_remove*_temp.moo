#10:"blacklist_remove*_temp graylist_remove*_temp redlist_remove*_temp spooflist_remove*_temp"   this none this rxd

"The temp version removes from the temporary property if it exists.";
if (!caller_perms().wizard)
  return E_PERM;
endif
where = args[1];
lname = this:listname(verb);
which = 1 + !$site_db:domain_literal(where);
if (index(verb, "temp"))
  lname = "temporary_" + lname;
  if (entry = $list_utils:assoc(where, this.(lname)[which]))
    this.(lname)[which] = setremove(this.(lname)[which], entry);
    return 1;
  else
    return E_INVARG;
  endif
elseif (where in this.(lname)[which])
  this.(lname)[which] = setremove(this.(lname)[which], where);
  return 1;
else
  return E_INVARG;
endif
