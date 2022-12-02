#35:say_action_reflexive   this none this rx

"$you:say_action(message [,who [,thing, [,where [, excluding-whom]]]])";
"announce 'message' with pronoun substitution as if it were just ";
"  where:announce_all_but(excluding-whom, ";
"    $string_utils:pronoun_sub(message, who, thing, where));";
"except that who (player), dobj, and iobj get modified messages, with the appropriate use of 'you' instead of their name, and except that `excluding-whom' isn't really a valid variable name.";
"who       default player";
"thing     default object that called this verb";
"where     default who.location";
"excluding default {}";
{msg, ?who = player, ?thing = caller, ?where = who.location, ?excluding = {}} = args;
you = this;
if (typeof(msg) == LIST)
  tell = "";
  for x in (msg)
    tell = tell + (typeof(x) == STR ? x | x[random(length(x))]);
  endfor
else
  tell = msg;
endif
if (who == dobj)
  tell = this:reflexive(tell, "%d");
endif
if (who == iobj)
  tell = this:reflexive(tell, "%i");
endif
if (!(who in excluding))
  msg = tell;
  x = dobj;
  y = iobj;
  dobj = dobj == who ? you | dobj;
  iobj = iobj == who ? you | iobj;
  who:tell($string_utils:pronoun_sub(this:fixpos(msg, "%n"), you, thing, where));
  dobj = x;
  iobj = y;
endif
if ($object_utils:has_callable_verb(where, "announce_all_but"))
  where:announce_all_but({dobj, who, iobj, @excluding}, $string_utils:pronoun_sub(tell, who, thing, where));
endif
if (valid(dobj) && dobj != who && !(dobj in excluding))
  x = dobj;
  y = iobj;
  msg = this:fixpos(tell, "%d");
  if (dobj == iobj)
    iobj = you;
    msg = this:fixpos(msg, "%i");
  endif
  dobj = you;
  x:tell($string_utils:pronoun_sub(msg, who, thing, where));
  dobj = x;
  iobj = y;
endif
if (valid(iobj) && !(iobj in {who, dobj, @excluding}))
  x = iobj;
  iobj = you;
  x:tell($string_utils:pronoun_sub(this:fixpos(tell, "%i"), who, thing, where));
  iobj = x;
endif
