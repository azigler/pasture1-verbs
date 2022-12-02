#155:get_option   this none this rxd

":get_option(STR <option name>[, OBJ <player>]) => INT";
"Return true if <option name> is set for <player>. Player defaults to whoever invoked the verb.";
{option, ?who = player} = args;
if (!maphaskey(this.options, who))
  return 0;
else
  return option in this.options[who];
endif
