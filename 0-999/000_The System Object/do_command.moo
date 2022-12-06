#0:do_command   this none this rxd

server_log("CMD from " + $string_utils:name_and_number(player) + ": " + argstr);
try
  if (player.autoafk_options["auto_unafk"] && player in $global_chat.afk_list)
    "Clearly not AFK anymore.";
    $global_chat:afk();
  endif
except (ANY)
endtry
if (args[1] in player.allowed_roundtime_commands == 0 && tofloat(player.roundtime) - ftime() > 0.0)
  player:freeze();
  return 1;
endif
"Last modified Tue Dec  6 17:09:54 2022 UTC by caranov (#133).";
