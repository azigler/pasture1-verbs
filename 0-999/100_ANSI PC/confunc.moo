#100:confunc   this none this rxd

if (valid(cp = caller_perms()) && caller != this && !$perm_utils:controls(cp, this) && caller != #0)
  return E_PERM;
else
  au = $ansi_utils;
  if (au.active)
    this:notify(tostr("ANSI Version ", au.version, " is currently active.  Type \"?ansi-intro\" for more information."));
  endif
  if ((mess = au.status_message) && !$object_utils:isa(this, $guest) && !this:ansi_option("no_connect_status"))
    fork (0)
      line = $string_utils:space((l = this:linelen()) - 2, "*");
      btmmsg = "Type \"@ansi-o +no_connect_status\" to ignore this message.";
      this:notify(line);
      for a in (typeof(mess) == LIST ? {"ANSI Message:", @mess, btmmsg} | {"ANSI Message: " + mess, btmmsg})
        for b in ($generic_editor:fill_string(a, l - 2))
          this:notify("* " + b);
        endfor
      endfor
      this:notify(line);
    endfork
  endif
  return pass(@args);
endif
