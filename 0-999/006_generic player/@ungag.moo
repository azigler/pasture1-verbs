#6:@ungag   any none none rxd

if (player != this || (caller != this && !$perm_utils:controls(caller_perms(), this)))
  player:notify("Permission denied.");
elseif (dobjstr == "")
  player:notify(tostr("Usage:  ", verb, " <player>  or  ", verb, " everyone"));
elseif (dobjstr == "everyone")
  this.gaglist = {};
  player:notify("You are no longer gagging anyone or anything.");
else
  if (valid(dobj))
    match = dobj;
  elseif ((match = toobj(dobjstr)) > #0)
  else
    match = $string_utils:match(dobjstr, this.gaglist, "name", this.gaglist, "aliases");
  endif
  if (match == $failed_match)
    player:notify(tostr("You don't seem to be gagging anything named ", dobjstr, "."));
  elseif (match == $ambiguous_match)
    player:notify(tostr("I don't know which \"", dobjstr, "\" you mean."));
  else
    this.gaglist = setremove(this.gaglist, match);
    player:notify(tostr(valid(match) ? match.name | match, " removed from gag list."));
  endif
  this:("@listgag")();
endif
