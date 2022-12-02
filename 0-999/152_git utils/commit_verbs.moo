#152:commit_verbs   any any any rxd

if (!caller_perms().wizard)
  raise(E_PERM);
endif
this:save_all_verbs();
if (!length(args))
  player:tell("Enter the commit message:");
  commit_msg = $command_utils:read();
else
  commit_msg = $string_utils:from_list(args, " ");
endif
author_string = player.name;
if (player.email_address != "")
  author_string = author_string + " <" + player.email_address + ">";
endif
exec({"commit_verbs.sh", commit_msg, author_string});
success_string = tostr("Pushed git commit with message: " + commit_msg);
server_log(success_string);
return player:tell(success_string);
