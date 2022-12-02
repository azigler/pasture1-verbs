#45:look_self   this none this rxd

"Returns full name and mail aliases for this list, read and write status by the player, and a short description. Calling :look_self(1) will omit the description.";
{?brief = 0} = args;
namelist = "*" + ((names = this:mail_names()) ? $string_utils:from_list(names, ", *") | tostr(this));
if (typeof(fwd = this:mail_forward()) != LIST)
  fwd = {};
endif
if (this:is_writable_by(player))
  if (player in fwd)
    read = " [Writable/Subscribed]";
  else
    read = " [Writable]";
  endif
elseif (this.readers == 1)
  read = tostr(" [Public", player in fwd ? "/Subscribed]" | "]");
elseif (player in fwd)
  read = " [Subscribed]";
elseif (this:is_readable_by(player))
  read = " [Readable]";
else
  read = "";
endif
if (this:is_usable_by($no_one))
  mod = "";
elseif (this:is_usable_by(player))
  mod = " [Approved]";
else
  mod = " [Moderated]";
endif
player:tell(namelist, "  (", this, ")", read, mod);
if (!brief)
  d = this:description();
  if (typeof(d) == STR)
    d = {d};
  endif
  for l in (d)
    if (length(l) <= 75)
      ls = {l};
    else
      ls = $generic_editor:fill_string(l, 76);
    endif
    for line in (ls)
      player:tell("    ", line);
      $command_utils:suspend_if_needed(0);
    endfor
  endfor
endif
