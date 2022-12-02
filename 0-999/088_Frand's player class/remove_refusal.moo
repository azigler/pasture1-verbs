#88:remove_refusal   this none this rxd

"'remove_refusal (<origin>, <actions>)' - Remove any refused <actions> by <origin>. The <actions> list should contain only actions, no synonyms. Return the number of such refusals found (0 if none).";
if (caller != this)
  return E_PERM;
endif
{origin, actions} = args;
if (typeof(actions) != LIST)
  actions = {actions};
endif
count = 0;
i = origin in this.refused_origins;
if (i)
  for action in (actions)
    if (j = action in this.refused_actions[i])
      this.refused_actions[i] = listdelete(this.refused_actions[i], j);
      this.refused_extra[i] = listdelete(this.refused_extra[i], j);
      count = count + 1;
    endif
  endfor
  if (!this.refused_actions[i])
    this.refused_origins = listdelete(this.refused_origins, i);
    this.refused_actions = listdelete(this.refused_actions, i);
    this.refused_until = listdelete(this.refused_until, i);
    this.refused_extra = listdelete(this.refused_extra, i);
  endif
endif
return count;
