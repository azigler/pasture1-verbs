#8:"oclose_msg close_msg oopen_msg open_msg oput_fail_msg put_fail_msg oremove_fail_msg oremove_msg remove_fail_msg remove_msg oput_msg put_msg oopen_fail_msg open_fail_msg empty_msg"   this none this rxd

return (msg = `this.(verb) ! ANY') ? $string_utils:pronoun_sub(msg) | "";
