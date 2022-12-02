#79:display_quota_summary   this none this rxd

{who, quota, usage, timestamp, unmeasured, unmeasurable} = args;
player:tell(who.name, " has a total building quota of ", $string_utils:group_number(quota), " bytes.");
player:tell($gender_utils:get_pronoun("P", who), " total usage was ", $string_utils:group_number(usage), " as of ", player:ctime(timestamp), ".");
if (usage > quota)
  player:tell(who.name, " is over quota by ", $string_utils:group_number(usage - quota), " bytes.");
else
  player:tell(who.name, " may create up to ", $string_utils:group_number(quota - usage), " more bytes of objects, properties, or verbs.");
endif
if (unmeasured)
  plural = unmeasured != 1;
  player:tell("There ", plural ? tostr("are ", unmeasured, " objects") | "is 1 object", " which ", plural ? "are" | "is", " not yet included in the tally; this tally may thus be inaccurate.");
  if (unmeasured >= this.max_unmeasured)
    player:tell("The number of unmeasured objects is too large; no objects may be created until @measure new is used.");
  endif
endif
if (unmeasurable)
  plural = unmeasurable != 1;
  player:tell("There ", plural ? tostr("are ", unmeasurable, " objects") | "is 1 object", " which do", plural ? "" | "es", " not have a .object_size property and will thus prevent additional building.", who == player ? "  Contact a wizard for assistance in having this situation repaired." | "");
endif
