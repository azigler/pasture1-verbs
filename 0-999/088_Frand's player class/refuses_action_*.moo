#88:refuses_action_*   this none this rxd

"'refuses_action_* (<which>, <origin>, ...)' - The action (such as 'whisper' for the verb :refuses_action_whisper) is being considered for refusal. Return whether the action should really be refused. <Which> is an index into this.refused_origins. By default, always refuse non-outdated actions that get this far.";
{which, @junk} = args;
if (time() >= this.refused_until[which])
  fork (0)
    "This <origin> is no longer refused. Remove any outdated refusals.";
    this:remove_expired_refusals();
  endfork
  return 0;
else
  return 1;
endif
