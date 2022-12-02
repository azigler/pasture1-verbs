#87:check_email   this none this rxd

{pwd, who} = args;
if (!$perm_utils:controls(caller_perms(), who))
  return "Permission denied.";
endif
email = $wiz_utils:get_email_address(who);
if (!email)
  "can't check";
  return;
endif
if (index(email, pwd))
  return "Passwords can't match your registered email address.";
endif
