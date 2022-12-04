#0:do_command   this none this rxd

server_log("CMD from " + $string_utils:name_and_number(player) + ": " + argstr);
try
  if (player.autoafk_options["auto_unafk"] && player in $global_chat.afk_list)
    "Clearly not AFK anymore.";
    $global_chat:afk();
  endif
except (ANY)
endtry
