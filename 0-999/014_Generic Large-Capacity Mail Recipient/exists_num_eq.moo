#14:exists_num_eq   this none this rxd

return this:ok(caller, caller_perms()) ? (i = this._mgr:find_ord(this.messages, args[1], "_lt_msgnum")) && (this:_message_num(@this._mgr:find_nth(this.messages, i)) == args[1] && i) | E_PERM;
