#31:do_reset   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
else
  flush_input(this, 0);
  for x in ({"paranoid", "lines", "responsible", "linelen", "linebuffer", "brief", "gaglist", "rooms", "pagelen", "current_message", "current_folder", "messages", "messages_going", "request", "mail_options", "edit_options", "home", "spurned_objects", "web_info", "ansi_options", "replace_codes"})
    if ($object_utils:has_property(parent(this), x))
      clear_property(this, x);
    endif
  endfor
  this:set_description(this.default_description);
  this:set_gender(this.default_gender);
  for x in (this.contents)
    this:eject(x);
  endfor
  for x in (this.features)
    if (!(x in $guest.features))
      this:remove_feature(x);
    endif
  endfor
  for x in ($guest.features)
    if (!(x in this.features))
      this:add_feature(x);
    endif
  endfor
  for x in ($object_utils:descendants($generic_editor))
    if (loc = this in x.active)
      x:kill_session(loc);
    endif
  endfor
endif
