#6:remove_feature   this none this rxd

"Remove a feature from this player's features list.  Caller must be this, or have permissions of this, a wizard, or feature.owner.";
"Returns true if successful, E_PERM if caller didn't have permission.";
feature = args[1];
if (caller == this || $perm_utils:controls(caller_perms(), this) || caller_perms() == feature.owner)
  if (typeof(this.features) == LIST)
    "If this is a list, we can just setremove...";
    this.features = setremove(this.features, feature);
    "Otherwise, we leave it alone.";
  endif
  "Let the feature know it's been removed.";
  try
    feature:feature_remove(this);
  except (ANY)
    "just ignore errors.";
  endtry
  return 1;
  "We're done.";
else
  return E_PERM;
  "Caller didn't have permission.";
endif
