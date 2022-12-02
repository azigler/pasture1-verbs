#46:is_recipient   this none this rxd

return valid(what = args[1]) && ($mail_recipient_class in (ances = $object_utils:ancestors(what)) || $mail_recipient in ances);
