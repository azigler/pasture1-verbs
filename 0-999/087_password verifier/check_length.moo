#87:check_length   this none this rxd

if ((l = this.minimum_password_length) && length(args[1]) < l)
  return tostr("Passwords must be a minimum of ", $string_utils:english_number(l), l == 1 ? " character " | " characters ", "long.");
endif
