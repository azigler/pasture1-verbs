#104:send_*   this none this rxd

{connection, @args} = args;
if (caller == this)
  message = verb[6..$];
  `connection:send(message, this:parse_send_args(message, @args)) ! E_VERBNF';
else
  raise(E_PERM);
endif
