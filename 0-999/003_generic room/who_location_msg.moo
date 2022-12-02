#3:who_location_msg   this none this rxd

return (msg = `this.(verb) ! ANY') ? $string_utils:pronoun_sub(msg, args[1]) | "";
