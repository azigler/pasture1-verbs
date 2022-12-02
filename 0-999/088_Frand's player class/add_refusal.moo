#88:add_refusal   this none this rxd

"'add_refusal (<origin>, <actions> [, <duration> [, <extra>]])' - Add refusal(s) to this player's list. <Actions> is a list of the actions to be refused. The list should contain only actions, no synonyms. <Origin> is the actor whose actions are to be refused. <Until> is the time that the actions are being refused until, in the form returned by time(). It is optional; if it's not given, it defaults to .default_refusal_time. <Extra> is any extra information; it can be used for comments, or to make finer distinctions about the actions being refused, or whatever. If it is not given, it defaults to 0. The extra information is per-action; that is, it is stored separately for each action that it applies to.";
if (caller != this)
  return E_PERM;
endif
{orig, actions, ?duration = this.default_refusal_time, ?extra = 0} = args;
origins = this:player_to_refusal_origin(orig);
if (typeof(origins) != LIST)
  origins = {origins};
endif
if (typeof(actions) != LIST)
  actions = {actions};
endif
if (!this:check_refusal_actions(actions))
  return E_INVARG;
endif
until = time() + duration;
for origin in (origins)
  if (i = origin in this.refused_origins)
    this.refused_until[i] = until;
    for action in (actions)
      if (j = action in this.refused_actions[i])
        this.refused_extra[i][j] = extra;
      else
        this.refused_actions[i] = {@this.refused_actions[i], action};
        this.refused_extra[i] = {@this.refused_extra[i], extra};
      endif
    endfor
  else
    this.refused_origins = {@this.refused_origins, origin};
    this.refused_actions = {@this.refused_actions, actions};
    this.refused_until = {@this.refused_until, until};
    this.refused_extra = {@this.refused_extra, $list_utils:make(length(actions), extra)};
  endif
endfor
