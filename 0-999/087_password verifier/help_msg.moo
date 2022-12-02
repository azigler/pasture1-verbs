#87:help_msg   this none this rxd

if (typeof(base = this.(verb)) == STR)
  base = {base};
endif
base = {@base, "", tostr(".minimum_password_length = ", toliteral(x = this.minimum_password_length)), x ? tostr("Passwords are required to be a minimum of ", $string_utils:english_number(x), " characters in length.") | "There is no minimum length requirement for passwords."};
base = {@base, "", tostr(".check_against_moo = ", toliteral(x = this.check_against_moo)), tostr("Passwords ", x ? "may not" | "may", " be variants on the MOO's name (", $network.MOO_name, ").")};
base = {@base, "", tostr(".check_against_name = ", toliteral(x = this.check_against_name)), tostr("Passwords ", x ? "may not" | "may", " be variants on the player's MOO name and/or aliases.")};
base = {@base, "", tostr(".check_against_email = ", toliteral(x = this.check_against_email)), x ? "Passwords may not be variants on the player's email address." | "Passwords are not checked against the player's email address."};
base = {@base, "", tostr(".check_against_hosts = ", toliteral(x = this.check_against_hosts)), x ? "Passwords may not be variants on the player's hostname(s)." | "Passwords are not checked against the player's hostname(s)."};
base = {@base, "", tostr(".check_against_dictionary = ", toliteral(x = this.check_against_dictionary)), tostr("Passwords ", typeof(x) in {LIST, OBJ} ? "may not" | "may", " be dictionary words.", x && !$network.active ? "  (This option is set but unavailable.)" | "")};
base = {@base, "", tostr(".require_funky_characters = ", toliteral(x = this.require_funky_characters)), tostr("Non-alphabetic characters are ", x ? "" | "not ", "required in passwords.")};
base = {@base, "", tostr(".check_obscure_stuff = ", toliteral(x = this.check_obscure_stuff)), x ? "Misc. obscure checks enabled" | "No obscure checks in use."};
return base;
