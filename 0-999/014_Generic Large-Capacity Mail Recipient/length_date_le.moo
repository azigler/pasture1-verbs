#14:length_date_le   this none this rxd

return this:ok(caller, caller_perms()) ? this._mgr:find_ord(this.messages, args[1], "_lt_msgdate") | E_PERM;
