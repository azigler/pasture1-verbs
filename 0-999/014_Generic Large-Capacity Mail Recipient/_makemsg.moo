#14:_makemsg   this none this rxd

":_makemsg(ord,msg) => leafnode for msg";
"msg = $mail_agent:__convert_new(@args[2])";
msg = args[2];
if (caller != this)
  return E_PERM;
elseif (h = "" in msg)
  return {this:_make(@msg[h + 1..$]), args[1], @msg[1..h - 1]};
else
  return {0, args[1], @msg};
endif
