#1:recycle   this none this rxd

if (caller == this || $perm_utils:controls(caller_perms(), this))
  try
    if (typeof(this.owner.owned_objects) == LIST && !is_clear_property(this.owner, "owned_objects"))
      this.owner.owned_objects = setremove(this.owner.owned_objects, this);
      $recycler.lost_souls = setadd($recycler.lost_souls, this);
    endif
  except (ANY)
    "Oy, doesn't have a .owned_objects??, or maybe .owner is $nothing";
    "Should probably do something...like send mail somewhere.";
  endtry
else
  return E_PERM;
endif
