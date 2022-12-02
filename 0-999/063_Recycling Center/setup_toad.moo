#63:setup_toad   this none this rxd

"this:setup_toad(objnum,new_owner,parent)";
"Called by :_create and :request.";
if (caller != this)
  return E_PERM;
endif
{potential, who, what} = args;
if (!$quota_utils:creation_permitted(who))
  return E_QUOTA;
elseif (valid(potential))
  return E_INVARG;
else
  set_task_perms({@callers(), {#-1, "", player}}[2][3]);
  "... if :initialize crashes...";
  this:add_orphan(potential);
  $building_utils:recreate(potential, what);
  $wiz_utils:set_owner(potential, who);
  this:remove_orphan(potential);
  "... if we don't get this far, the object stays on the orphan list...";
  "... orphan list should be checked periodically...";
  return potential;
endif
