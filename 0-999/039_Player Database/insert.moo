#39:insert   this none this rxd

typeof(args[1]) == NUM && typeof(args[2]) == STR && (args[2] = $ansi_utils:delete(args[2]));
typeof(args[1]) == STR && (args[1] = $ansi_utils:delete(args[1]));
return pass(@args);
