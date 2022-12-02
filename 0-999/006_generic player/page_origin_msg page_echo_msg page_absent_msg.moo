#6:"page_origin_msg page_echo_msg page_absent_msg"   this none this rxd

"set_task_perms(this.owner)";
return (msg = `this.(verb) ! ANY') ? $string_utils:pronoun_sub(this.(verb), this) | "";
