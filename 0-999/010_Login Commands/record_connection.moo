#10:record_connection   this none this rxd

":record_connection(plyr) update plyr's connection information";
"to reflect impending login.";
if (!caller_perms().wizard)
  return E_PERM;
else
  plyr = args[1];
  plyr.first_connect_time = min(time(), plyr.first_connect_time);
  plyr.previous_connection = {plyr.last_connect_time, $string_utils:connection_hostname(plyr.last_connect_place)};
  plyr.last_connect_time = time();
  plyr.last_connect_place = connection_name(player);
  chost = $string_utils:connection_hostname(player);
  acp = setremove(plyr.all_connect_places, chost);
  plyr.all_connect_places = {chost, @acp[1..min($, 15)]};
  if (!$object_utils:isa(plyr, $guest))
    $site_db:add(plyr, chost);
  endif
endif
