#14:init_for_core   this none this rxd

if (caller_perms().wizard)
  this._mgr = $biglist;
  this.mowner = $mail_recipient.owner;
  for p in (properties(this))
    $command_utils:suspend_if_needed(0);
    if (p && p[1] == " ")
      delete_property(this, p);
    endif
  endfor
  this.messages = this.messages_going = {};
  this:_fix_last_msg_date();
  this._genprop = "";
  pass(@args);
endif
