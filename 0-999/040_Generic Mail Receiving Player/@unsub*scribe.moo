#40:@unsub*scribe   any any any rd

"@unsubscribe [*<folder/mailing_list> ...]";
"entirely removes the record of your current message for the named folders,";
"indicating your disinterest in anything that might appear there in the future.";
set_task_perms(player);
unsubscribed = {};
current_folder = this:current_folder();
for a in (args || {0})
  if (a != 0)
    folder = $mail_agent:match_recipient(a);
    if (folder == $failed_match)
      folder = this:my_match_object(a);
    endif
  else
    folder = current_folder;
  endif
  if (!valid(folder))
    "...bogus folder name...  try removing it anyway.";
    if (this:kill_current_message(folder))
      player:notify("Invalid folder, but found it subscribed anyway.  Removed.");
    else
      $mail_agent:match_failed(folder, a);
    endif
  elseif (folder == this)
    player:notify(tostr("You can't ", verb, " yourself."));
  else
    if (!this:kill_current_message(folder))
      player:notify(tostr("You weren't subscribed to ", $mail_agent:name(folder)));
      if ($object_utils:isa(folder, $mail_recipient))
        result = folder:delete_notify(this);
        if (typeof(result) == LIST && result[1] == this)
          player:notify("Removed you from the mail notifications list.");
        endif
      endif
    else
      unsubscribed = {@unsubscribed, folder};
      if ($object_utils:isa(folder, $mail_recipient))
        folder:delete_notify(this);
      endif
    endif
  endif
endfor
if (unsubscribed)
  player:notify(tostr("Forgetting about ", $string_utils:english_list($list_utils:map_arg($mail_agent, "name", unsubscribed))));
  if (current_folder in unsubscribed)
    this:set_current_folder(this);
  endif
endif
