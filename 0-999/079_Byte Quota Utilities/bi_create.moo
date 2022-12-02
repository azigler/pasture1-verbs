#79:bi_create   this none this rxd

set_task_perms(caller_perms());
who = this:parse_create_args(@args);
"Because who can be E_INVARG, need to catch E_TYPE. Let $recycler:_create deal with returning E_PERM since that's what's going to happen. Ho_Yan 11/19/96.";
if (!`who.wizard ! E_TYPE => 0' && $recycler.contents)
  return $recycler:_create(@args);
elseif (this:creation_permitted(who))
  this:enable_create(who);
  value = `create(@args) ! ANY';
  this:disable_create(who);
  if (typeof(value) != ERR)
    this:charge_quota(who, value);
    if (typeof(who.owned_objects) == LIST && !(value in who.owned_objects))
      this:add_owned_object(who, value);
    endif
  endif
  return value;
else
  return E_QUOTA;
endif
