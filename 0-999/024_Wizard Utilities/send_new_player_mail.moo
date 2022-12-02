#24:send_new_player_mail   this none this rxd

":send_new_player_mail(preface, name, address, character#, password)";
"  used by $wiz:@make-player and $guest:@request";
if (!caller_perms().wizard)
  return E_PERM;
endif
{preface, name, address, new, password} = args;
msg = {preface};
msg = {@msg, tostr("A character has been created, with name \"", name, "\" and password \"", password, "\"."), "Passwords are case sensitive, which means you have to type it exactly as", "it appears here, including capital and lowercase letters.", "So, to log in, you would type:", tostr("  Connect ", name, " ", password)};
if ($object_utils:has_property($local, "new_player_message"))
  msg = {@msg, @$local.new_player_message};
endif
return $network:sendmail(address, "Your " + $network.moo_name + " character, " + name, "Reply-to: " + $login.registration_address, @msg);
