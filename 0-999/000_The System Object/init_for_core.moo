#0:init_for_core   this none this rxd

if (caller_perms().wizard)
  pass(@args);
  `delete_property(this, "mail_name_db") ! E_PROPNF';
  `delete_verb(this, "do_command") ! E_VERBNF';
  $server["core_history"] = {{$network.MOO_name, server_version(), time()}, @$server["core_history"]};
  $wiz_utils.shutdown_message = "";
  $server["shutdown_time"] = 0;
  $server_options.dump_interval = 3600;
  $wiz_utils.gripe_recipients = {player};
  for v in ({"do_login_command", "server_started"})
    c = {};
    for i in (verb_code(this, v))
      c = {@c, strsub(i, "$local.login", "$login")};
    endfor
    set_verb_code(#0, v, c);
  endfor
endif
