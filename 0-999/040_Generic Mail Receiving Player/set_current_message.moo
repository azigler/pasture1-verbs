#40:set_current_message   this none this rxd

":set_current_message(recipient[,number[,date]])";
"Returns the new {number,last-read-date} pair for recipient.";
if (caller != this && !$perm_utils:controls(caller_perms(), this))
  raise(E_PERM);
endif
{recip, ?number = E_NONE, ?date = 0, ?force = 0} = args;
cm = this.current_message;
if (recip == this)
  this.current_message[2] = max(date, cm[2]);
  if (number != E_NONE)
    this.current_message[1] = number;
  endif
  return this.current_message[1..2];
elseif (i = $list_utils:iassoc(recip, cm))
  if (force)
    "`force' is assumed to come from `@unread'";
    return (this.current_message[i] = {recip, number, date})[2..3];
  else
    return (this.current_message[i] = {recip, number == E_NONE ? cm[i][2] | number, max(date, cm[i][3])})[2..3];
  endif
else
  entry = {recip, number != E_NONE && number, date};
  this.current_message = {@cm, entry};
  return entry[2..3];
endif
