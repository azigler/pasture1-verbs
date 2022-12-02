#46:"is_readable_by is_writable_by is_usable_by"   this none this rxd

what = args[1];
if ($object_utils:isa(what, $mail_recipient))
  return what:(verb)(@listdelete(args, 1));
else
  "...it's a player:";
  "...  anyone can send mail to it.";
  "...  only the player itself or a wizard can read it.";
  return verb == "is_usable_by" || $perm_utils:controls(args[2], what);
endif
