#50:invoke   this none this rxd

":invoke(...)";
"to find out what arguments this verb expects,";
"see this editor's parse_invoke verb.";
new = args[1];
if (!(caller in {this, player}) && !$perm_utils:controls(caller_perms(), player))
  "...non-editor/non-player verb trying to send someone to the editor...";
  return E_PERM;
endif
if ((who = this:loaded(player)) && this:changed(who))
  if (!new)
    if (this:suck_in(player))
      player:tell("You are working on ", this:working_on(who));
    endif
    return;
  elseif (player.location == this)
    player:tell("You are still working on ", this:working_on(who));
    if (msg = this:previous_session_msg())
      player:tell(msg);
    endif
    return;
  endif
  "... we're not in the editor and we're about to start something new,";
  "... but there's still this pending session...";
  player:tell("You were working on ", this:working_on(who));
  if (!$command_utils:yes_or_no("Do you wish to delete that session?"))
    if (this:suck_in(player))
      player:tell("Continuing with ", this:working_on(player in this.active));
      if (msg = this:previous_session_msg())
        player:tell(msg);
      endif
    endif
    return;
  endif
  "... note session number may have changed => don't trust `who'";
  this:kill_session(player in this.active);
endif
spec = this:parse_invoke(@args);
if (typeof(spec) == LIST)
  if (player:edit_option("local") && $object_utils:has_verb(this, "local_editing_info") && (info = this:local_editing_info(@spec)))
    this:invoke_local_editor(@info);
  elseif (this:suck_in(player))
    this:init_session(player in this.active, @spec);
  endif
endif
