#54:"burn_succeeded_msg oburn_succeeded_msg burn_failed_msg oburn_failed_msg"   this none this rxd

return (msg = this.(verb)) ? $string_utils:pronoun_sub(msg) | "";
