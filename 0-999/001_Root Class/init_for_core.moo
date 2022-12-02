#1:init_for_core   this none this rxd

if (caller_perms().wizard)
  deletes = {};
  for vnum in [1..length(verbs(this))]
    $command_utils:suspend_if_needed(0);
    for name in ($string_utils:explode(verb_info(this, vnum)[3]))
      if (rindex(name, "(old)") == max(1, length(name) - 4))
        deletes[1..0] = {vnum};
        break;
      elseif (rindex(name, "(core)") == max(1, length(name) - 5))
        deletes[1..0] = {vnum};
        set_verb_code(this, name[1..$ - 6], verb_code(this, vnum));
        break;
      endif
    endfor
  endfor
  for vnum in (deletes)
    delete_verb(this, vnum);
  endfor
endif
