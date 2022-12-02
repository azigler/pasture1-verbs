#3:@resident*s   any none none rd

if (!$perm_utils:controls(player, this))
  player:tell("You must own this room to manipulate the legal residents list.  Try contacting ", this.owner.name, ".");
else
  if (typeof(this.residents) != LIST)
    this.residents = {this.residents};
  endif
  if (!dobjstr)
    "First, remove !valid objects from this room...";
    for x in (this.residents)
      if (typeof(x) != OBJ || !$recycler:valid(x))
        player:tell("Warning: removing ", x, ", an invalid object, from the residents list.");
        this.residents = setremove(this.residents, x);
      endif
    endfor
    player:tell("Allowable residents in this room:  ", $string_utils:english_list($list_utils:map_prop(this.residents, "name"), "no one"), ".");
    return;
  elseif (dobjstr[1] == "!")
    notflag = 1;
    dobjstr = dobjstr[2..$];
  else
    notflag = 0;
  endif
  result = $string_utils:match_player_or_object(dobjstr);
  if (!result)
    return;
  else
    "a one element list was returned to us if it won.";
    result = result[1];
    if (notflag)
      if (!(result in this.residents))
        player:tell(result.name, " doesn't appear to be in the residents list of ", this.name, ".");
      else
        this.residents = setremove(this.residents, result);
        player:tell(result.name, " removed from the residents list of ", this.name, ".");
      endif
    else
      if (result in this.residents)
        is = $gender_utils:get_conj("is", result);
        player:tell(result.name, " ", is, " already an allowed resident of ", this.name, ".");
      else
        this.residents = {@this.residents, result};
        player:tell(result.name, " added to the residents list of ", this.name, ".");
      endif
    endif
  endif
endif
