#40:"@subscribe*-quick @unsubscribed*-quick"   any any any rd

"@subscribe *<folder/mailing_list> [with notification] [before|after *<folder>]";
"  causes you to be notified when new mail arrives on this list";
"@subscribe";
"  just lists available mailing lists.";
"@unsubscribed";
"  prints out available mailing lists you aren't already subscribed to.";
"@subscribe-quick and @unsubscribed-quick";
"  prints out same as above except without mail list descriptions, just names.";
set_task_perms(player);
quick = 0;
if (qi = index(verb, "-q"))
  verb = verb[1..qi - 1];
  quick = 1;
endif
fname = {@args, 0}[1];
if (!fname)
  ml = $list_utils:slice(this.current_message[3..$]);
  all_mlists = {@$mail_agent.contents, @this.mail_lists};
  if (length(all_mlists) > 50 && !$command_utils:yes_or_no(tostr("There are ", length(all_mlists), " mailing lists.  Are you sure you want the whole list?")))
    return player:tell("OK, aborting.");
  endif
  for c in (all_mlists)
    $command_utils:suspend_if_needed(0);
    if (c:is_usable_by(this) || c:is_readable_by(this) && (verb != "@unsubscribed" || !(c in ml)))
      c:look_self(quick);
    endif
  endfor
  player:notify(tostr("-------- end of ", verb, " -------"));
  return;
elseif (verb == "@unsubscribed")
  player:notify("@unsubscribed does not take arguments.");
  return;
elseif ($mail_agent:match_failed(folder = $mail_agent:match_recipient(fname), fname))
  return;
elseif (folder == this)
  player:notify("You don't need to @subscribe to yourself");
  return;
elseif ($object_utils:isa(folder, $mail_recipient) ? !folder:is_readable_by(this) | !$perm_utils:controls(this, folder))
  player:notify("That mailing list is not readable by you.");
  return;
endif
notification = this in folder.mail_notify;
i = 0;
beforeafter = 0;
while (length(args) >= 2)
  if (length(args) < 3)
    player:notify(args[2] + " what?");
    return;
  elseif (args[2] in {"with", "without"})
    with = args[2] == "with";
    if (index("notification", args[3]) != 1)
      player:notify(tostr("with ", args[3], "?"));
      return;
    elseif (!$object_utils:isa(folder, $mail_recipient))
      player:notify(tostr("You cannot use ", verb, " to change mail notification from a non-$mail_recipient."));
    elseif (!with == !notification)
      "... nothing to do...";
    elseif (with)
      if (this in folder:add_notify(this))
        notification = 1;
      else
        player:notify("This mail recipient does not allow immediate notification.");
      endif
    else
      folder:delete_notify(this);
      notification = 0;
    endif
  elseif (args[2] in {"before", "after"})
    if (beforeafter)
      player:notify(args[2] == beforeafter ? tostr("two `", beforeafter, "'s?") | "Only use one of `before' or `after'");
      return;
    elseif ($mail_agent:match_failed(other = $mail_agent:match_recipient(args[3]), args[3]))
      return;
    elseif (other == this)
      i = 2;
    elseif (!(i = $list_utils:iassoc(other, this.current_message)))
      player:notify(tostr("You aren't subscribed to ", $mail_agent:name(other), "."));
      return;
    endif
    beforeafter = args[2];
    i = i - (beforeafter == "before");
    if (this:mail_option("rn_order") != "fixed")
      player:notify("Warning:  Do `@mail-option rn_order=fixed' if you do not want your @rn listing reordered when you next login.");
    endif
  endif
  args[2..3] = {};
endwhile
this:make_current_message(folder, @i ? {i} | {});
len = folder:length_all_msgs();
player:notify(tostr($mail_agent:name(folder), " has ", len, " message", len == 1 ? "" | "s", ".", notification ? "  You will be notified immediately when new messages are posted." | "  Notification of new messages will be printed when you connect."));
this:set_current_folder(folder);
