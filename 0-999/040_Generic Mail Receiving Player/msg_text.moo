#40:msg_text   this none this rxd

":msg_text(@msg) => list of strings.";
"msg is a mail message (in the usual transmission format) being read BY this player.";
"The default version of recipient:msg_full_text calls this to obtain the actual list of strings to display.  (this is a badly named verb).";
"returns the actual list of strings to display.";
return $mail_agent:to_text(@args);
