#53:eval_key   this none this rxd

"eval_key(LIST|OBJ coded key, OBJ testobject) => returns true if testobject will solve the provided key.";
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
else
  raise(E_DIV);
endif
