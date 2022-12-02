#155:do_export_note   this none this rxd

":do_export_note(INT <note ID>)";
"The end all be all verb for exporting a note after presenting the player with a menu.";
{note} = args;
email = this:get_email_address(player);
if (email == $failed_match)
  return player:tell("No e-mail address could be found registered to you.");
else
  {title, body} = this:get_note(note);
  if ($command_utils:yes_or_no(tostr("Are you sure you want to e-mail the note \"", title, "\" to ", email, "?")) != 1)
    return player:tell("Aborted.");
  else
    $network:sendmail(email, tostr($network.moo_name, " Note: ", title), @body);
    player:tell("Note sent!");
  endif
endif
