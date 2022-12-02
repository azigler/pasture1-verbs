#7:"leave_msg oleave_msg arrive_msg oarrive_msg nogo_msg onogo_msg"   this none this rxd

msg = this.(verb);
return msg ? $string_utils:pronoun_sub(msg, @args) | "";
