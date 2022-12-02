#87:reject_password   this none this rxd

":reject_password ( STR password [ , OBJ for-whom ] );";
"=> string value [if the password is rejected, why?]";
"=> false value [if the password isn't rejected]";
if (length(args) == 1)
  trust = 0;
else
  if ($perm_utils:controls(caller_perms(), args[2]))
    trust = 1;
  else
    return "Permissions don't permit setting of that password.";
  endif
endif
"this is gonna be huge";
return this:trivial_check(@args) || (this.minimum_password_length && this:check_length(@args)) || (this.check_against_name && trust && this:check_name(@args)) || (this.check_against_email && trust && this:check_email(@args)) || (this.check_against_hosts && trust && this:check_hosts(@args)) || (typeof(this.check_against_dictionary) in {LIST, OBJ} && this:check_dictionary(@args)) || (this.require_funky_characters && this:check_for_funky_characters(@args)) || (this.check_against_moo && this:check_against_moo(@args)) || (this.check_obscure_stuff && this:check_obscure_combinations(@args));
