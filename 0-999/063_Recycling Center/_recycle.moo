#63:_recycle   this none this rxd

{item} = args;
if (!$perm_utils:controls(caller_perms(), item))
  raise(E_PERM);
elseif (is_player(item))
  raise(E_INVARG);
endif
this:addhist(caller_perms(), item);
"...recreate can fail (:recycle can crash)...";
this:add_orphan(item);
this:kill_all_tasks(item);
$quota_utils:reimburse_quota(item.owner, item);
$building_utils:recreate(item, $nothing);
this:remove_orphan(item);
