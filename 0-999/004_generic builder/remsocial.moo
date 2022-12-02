#4:remsocial   any any any rxd

"syntax: remsocial <socialname>";
"this is a command which can be used to remove a social from the list of socials.";
"This can only be called by builder class or above.";
{social} = args;
if (match = $socials:match_social(social) == 0)
  return player:tell("This social could not be found.");
endif
if ($command_utils:yes_or_no("Are you sure you would like to delete social " + social + "?"))
  $socials.socials = mapdelete($socials.socials, social);
  player:tell("Deleted successfully.");
else
  return player:tell("this social will not be deleted.");
endif
