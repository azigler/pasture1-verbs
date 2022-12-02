#14:restore_from   this none this rxd

":restore_from(OLD_MAIL_RECIPIENT, LOST_STRING)";
"This clears all biglist properties from this object, then";
"scans the properties of OLD_MAIL_RECIPIENT, which must be a descendant";
"of $big_mail_recipient, looking for those corresponding to mail messages,";
"and then rebuilds the message tree entirely from scratch.";
"";
"No attempt is made to preserve the original tree structure.";
"The live/deleted state of any given message is lost;";
"all messages, including formerly rmm-ed ones, are restored to .messages";
"";
"In the (unlikely) event that message-body properties have been lost, the";
"affected messages are given a one-line body consisting of LOST_STRING";
"";
{old, ?lost_body = "###BODY-LOST###"} = args;
if (!($perm_utils:controls(caller_perms(), this) && $perm_utils:controls(caller_perms(), old)))
  raise(E_PERM);
elseif (!$object_utils:isa(old, $big_mail_recipient))
  raise(E_TYPE, "First argument must be a $big_mail_recipient.");
elseif (typeof(lost_body) != STR)
  raise(E_TYPE, "Second argument, if given, must be a string.");
endif
mgr = this._mgr;
"...";
"... destroy everything...";
for p in (properties(this))
  delete_property(this, p);
endfor
this.messages = this.messages_going = {};
"...";
"... look at all properties...";
msgcount = lostcount = 0;
for p in (properties(old))
  if (index(p, " ") == 1)
    pvalue = old.(p);
    "... ignore everything except level-0 nodes...";
    if (pvalue[1..min(1, $)] == {0})
      for msg in (pvalue[2])
        if (ticks_left() < 6000 || seconds_left() < 2)
          player:tell("...", msgcount, " copied.");
          suspend(0);
        endif
        try
          body = old.(msg[1]);
        except e (E_PROPNF)
          body = {lost_body};
          lostcount = lostcount + 1;
        endtry
        msg[1] = this:_make(@body);
        msgtree = mgr:insert_last(this.messages, msg);
        msgcount = msgcount + 1;
        n = mgr:find_ord(msgtree, this:_message_num(@msg), "_lt_msgnum");
        if (n < msgcount)
          {msgtree, singleton} = mgr:extract_range(msgtree, msgcount, msgcount);
          msgtree = mgr:insert_after(msgtree, singleton, n);
        endif
        this.messages = msgtree;
      endfor
    endif
  endif
endfor
player:tell(msgcount, " messages installed on ", this.name, "(", this, ")");
if (lostcount)
  player:tell(lostcount, " messages have missing bodies (indicated by ", toliteral(lost_body), ").");
else
  player:tell("No message bodies were missing.");
endif
