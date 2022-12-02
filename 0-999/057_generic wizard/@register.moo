#57:@register   any any any rd

"Registers a player.";
"Syntax:  @register name email-address [additional commentary]";
"Email-address is stored in $registration_db and on the player object.";
if (!player.wizard)
  return player:tell(E_PERM);
endif
$wiz_utils:do_register(@args);
