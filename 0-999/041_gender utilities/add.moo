#41:add   this none this rxd

"$gender_utils:add(object[,perms[,owner]])";
"--- adds pronoun properties to object if they're not already there.";
"    perms default to \"rc\", owner defaults to the object owner.";
set_task_perms(caller_perms());
{object, ?perms = "rc", ?owner = object.owner} = args;
prons = this.pronouns;
e = 1;
for p in (prons)
  if (!$object_utils:has_property(object, p))
    e = `add_property(object, p, "", {owner, perms}) ! ANY';
    if (typeof(e) == ERR)
      player:tell("Couldn't add ", object, ".", p, ":  ", e);
      return;
    endif
  elseif (typeof(object.(p)) != STR && typeof(e = `object.(p) = "" ! ANY') == ERR)
    player:tell("Couldn't reset ", object, ".", p, ":  ", e);
    return;
  elseif (!object.(p))
    e = 0;
  endif
endfor
if (!e && ERR == typeof(e = this:set(object, "neuter")))
  player:tell("Couldn't initialize pronouns:  ", e);
endif
