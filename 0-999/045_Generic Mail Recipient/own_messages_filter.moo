#45:own_messages_filter   this none this rxd

":own_messages_filter(who,msg_seq) => subsequence of msg_seq consisting of those messages that <who> is actually allowed to remove (on the assumption that <who> is not one of the allowed writers of this folder.";
if (!this.rmm_own_msgs)
  return E_PERM;
elseif (typeof(seq = this:from_msg_seq({args[1]}, args[2])) != LIST || seq != args[2])
  return {};
else
  return seq;
endif
