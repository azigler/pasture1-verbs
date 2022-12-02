#6:recycle   this none this rxd

if (caller == this || $perm_utils:controls(caller_perms(), this))
  pass(@args);
  features = this.features;
  for x in (features)
    "Have to do this, or :feature_remove thinks you're a liar and doesn't believe.";
    this.features = setremove(this.features, x);
    if ($object_utils:has_verb(x, "feature_remove"))
      try
        x:feature_remove(this);
      except (ANY)
        player:tell("Failure in ", x, ":feature_remove for player ", $string_utils:nn(this));
      endtry
    endif
    $command_utils:suspend_if_needed(0);
  endfor
endif
