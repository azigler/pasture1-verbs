#14:length_date_gt   this none this rxd

if (this:ok(caller, caller_perms()))
  date = args[1];
  return this.last_msg_date <= date ? 0 | this.messages[2] - this._mgr:find_ord(this.messages, args[1], "_lt_msgdate");
else
  return E_PERM;
endif
