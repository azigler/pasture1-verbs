#53:eval_key_new   this none this rxd

set_task_perms($no_one);
{key, who} = args;
type = typeof(key);
if (!(type in {LIST, OBJ}))
  return 1;
elseif (typeof(key) == OBJ)
  return who == key || $object_utils:contains(who, key);
endif
op = key[1];
if (op == "!")
  return !this:eval_key(key[2], who);
elseif (op == "?")
  return key[2]:is_unlocked_for(who);
elseif (op == "&&")
  return this:eval_key(key[2], who) && this:eval_key(key[3], who);
elseif (op == "||")
  return this:eval_key(key[2], who) || this:eval_key(key[3], who);
elseif (op == ".")
  if ($object_utils:has_property(who, key[2]) && who.(key[2]))
    return 1;
  else
    for thing in ($object_utils:all_contents(who))
      if ($object_utils:has_property(thing, key[2]) && thing.(key[2]))
        return 1;
      endif
    endfor
  endif
  return 0;
elseif (op == ":")
  if ($object_utils:has_verb(who, key[2]) && who:(key[2])())
    return 1;
  else
    for thing in ($object_utils:all_contents(who))
      if ($object_utils:has_verb(thing, key[2]) && thing:(key[2])())
        return 1;
      endif
    endfor
  endif
  return 0;
else
  raise(E_DIV);
endif
