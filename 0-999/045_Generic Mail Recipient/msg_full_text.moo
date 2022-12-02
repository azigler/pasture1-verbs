#45:msg_full_text   this none this rxd

":msg_full_text(@msg) => list of strings.";
"msg is a mail message (in the usual transmission format).";
"display_seq_full calls this to obtain the actual list of strings to display.";
return player:msg_text(@args);
"default is to leave it up to the player how s/he wants it to be displayed.";
