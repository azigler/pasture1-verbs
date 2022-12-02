#63:check_quota_scam   this none this rxd

who = args[1];
if ($quota_utils.byte_based && (is_clear_property(who, "size_quota") || is_clear_property(who, "owned_objects")))
  raise(E_QUOTA);
endif
cheater = 0;
other_cheaters = {};
for x in (this.lost_souls)
  if (valid(x) && (owner = x.owner) != $hacker && typeof(owner.owned_objects) == LIST && !(x in owner.owned_objects))
    if (owner == who)
      who.owned_objects = setadd(who.owned_objects, x);
      cheater = 1;
    else
      "it's someone else's quota scam we're detecting...";
      other_cheaters = setadd(other_cheaters, owner);
      owner.owned_objects = setadd(owner.owned_objects, x);
      this.lost_souls = setremove(this.lost_souls, x);
    endif
  endif
  this.lost_souls = setremove(this.lost_souls, x);
endfor
if ($quota_utils.byte_based)
  if (cheater)
    $quota_utils:summarize_one_user(who);
  endif
  if (other_cheaters)
    fork (0)
      for x in (other_cheaters)
        $quota_utils:summarize_one_user(x);
      endfor
    endfork
  endif
endif
