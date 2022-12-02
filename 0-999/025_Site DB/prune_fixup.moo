#25:prune_fixup   this none this rxd

if (!caller_perms().wizard)
  raise(E_PERM);
endif
if (!args)
  for x in ({"com", "edu", "us", "au", "net", "za", "uk", "at", "ca", "org", "il", "mil", "no", "gov", "se", "fi", "it", "be", "jp", "de", "pt", "sg", "ie", "br", "nl", "gr", "ch", "pl", "nz", "<none>", "<bad>", "ee", "dk", "fr", "si", "cz", "th", "tw", "hk", "su", "es", "kr", "hr", "is", "mx", "my", "ro", "kw", "cl", "ph", "cr", "tr", "in", "eg", "ec", "lv", "ve", "sk", "ar", "co", "pe", "hu", "jm", "ni", "ru", "id", "bm", "mt", "cn", "bg", "pk", "uy", "yu", "ae", "zw", "gi", "sm", "nu"})
    this:prune_fixup(x);
  endfor
  return;
endif
root = args[1];
items = this:find_exact(root);
orig = items;
if (items == #-3)
  return 1;
endif
$site_db.prune_progress = root;
$site_db.prune_task = task_id();
for item in (items)
  if (typeof(item) == STR)
    if (this:prune_fixup(item + "." + root))
      items = setremove(items, item);
    endif
  endif
  if ($command_utils:running_out_of_time())
    set_task_perms($wiz_utils:random_wizard());
    suspend(0);
  endif
endfor
if (!items)
  this:delete(root);
  this.total_pruned_sites = this.total_pruned_sites + 1;
  return 1;
elseif (orig == items)
else
  this:insert(root, items);
endif
