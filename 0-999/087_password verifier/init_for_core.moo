#87:init_for_core   this none this rxd

if (caller_perms().wizard)
  pass(@args);
  this.minimum_password_length = this.check_against_name = this.check_against_email = this.check_against_hosts = this.check_against_dictionary = this.require_funky_characters = this.check_against_moo = this.check_obscure_stuff = 0;
endif
