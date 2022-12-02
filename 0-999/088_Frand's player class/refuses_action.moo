#88:refuses_action   this none this rxd

"'refuses_action (<origin>, <action>, ...)' - Return whether this object refuses the given <action> by <origin>. <Origin> is typically a player. Extra arguments after <origin>, if any, are used to further describe the action.";
"Modified by Diopter (#98842) at LambdaMOO";
{origin, action, @extra_args} = args;
extra_args = {origin, @extra_args};
rorigin = this:player_to_refusal_origin(origin);
if ((which = rorigin in this.refused_origins) && action in this.refused_actions[which] && this:("refuses_action_" + action)(which, @extra_args))
  return 1;
elseif (typeof(rorigin) == OBJ && valid(rorigin) && (which = rorigin.owner in this.refused_origins) && action in this.refused_actions[which] && this:("refuses_action_" + action)(which, @extra_args))
  return 1;
elseif ((which = $nothing in this.refused_origins) && rorigin != this && action in this.refused_actions[which] && this:("refuses_action_" + action)(which, @extra_args))
  return 1;
elseif ((which = "all guests" in this.refused_origins) && $object_utils:isa(origin, $guest) && action in this.refused_actions[which] && this:("refuses_action_" + action)(which, @extra_args))
  return 1;
endif
return 0;
