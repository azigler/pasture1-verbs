#45:_fix_last_msg_date   this none this rxd

mlen = this:length_all_msgs();
this.last_msg_date = mlen && this:messages_in_seq(mlen)[2][1];
