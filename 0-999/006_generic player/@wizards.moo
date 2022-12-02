#6:@wizards   any none none rxd

"@wizards [all]";
if (caller != player)
  return E_PERM;
endif
if (args)
  $code_utils:show_who_listing($wiz_utils:all_wizards());
else
  $code_utils:show_who_listing($wiz_utils:connected_wizards()) || player:notify("No wizards currently logged in.");
endif
