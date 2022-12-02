#6:add_feature   this none this rxd

"Add a feature to this player's features list.  Caller must be this or have suitable permissions (this or wizardly).";
"If this is a nonprogrammer, then ask feature if it is feature_ok (that is, if it has a verb :feature_ok which returns a true value, or a property .feature_ok which is true).";
"After adding feature, call feature:feature_add(this).";
"Returns true if successful, E_INVARG if not a valid object, and E_PERM if !feature_ok or if caller doesn't have permission.";
if (caller == this || $perm_utils:controls(caller_perms(), this))
  feature = args[1];
  if (typeof(feature) != OBJ || !valid(feature))
    return E_INVARG;
    "Not a valid object.";
  endif
  if ($code_utils:verb_or_property(feature, "feature_ok", this))
    "The object is willing to be a feature.";
    if (typeof(this.features) == LIST)
      "If list, we can simply setadd the feature.";
      this.features = setadd(this.features, feature);
    else
      "If not, we erase the old value and create a new list.";
      this.features = {feature};
    endif
    "Tell the feature it's just been added.";
    try
      feature:feature_add(this);
    except (ANY)
      "just ignore errors.";
    endtry
    return 1;
    "We're done.";
  else
    return E_PERM;
    "Feature isn't feature_ok.";
  endif
else
  return E_PERM;
  "Caller doesn't have permission.";
endif
