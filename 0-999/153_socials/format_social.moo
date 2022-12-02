#153:format_social   this none this rxd

{pov, socialmsg, ?target = 0} = args;
"pov can be one of";
"self(untargetted)";
"publicmsg(untargetted room)";
"selftarget(the message you see when you perform a social on a target)";
"publictarget(the message displayed to everyone when done on a target),";
"target(the message the target will see),";
"targetself(What you see when the social is targeted on yourself), ";
"publictargetself(the message everyone sees when you target yourself).";
if (pov == "selftarget")
  return $string_utils:pronoun_sub($string_utils:substitute(socialmsg, {{"%N", "you"}, {"%his", target.pp}, {"%him", target.po}, {"himself", target.pr}}), player, target);
elseif (pov == "publictarget" || pov == "publictargetself")
  return $string_utils:pronoun_sub($string_utils:substitute(socialmsg, {{"%his", target.pp}, {"%him", target.po}, {"himself", target.pr}}), player, target);
elseif (pov == "self" || pov == "targetself")
  return $string_utils:pronoun_sub($string_utils:substitute(socialmsg, {{"%N", "you"}, {"%his", "your"}, {"%him", "you"}, {"%himself", "yourself"}}), player, target);
elseif (pov == "target")
  return $string_utils:pronoun_sub($string_utils:substitute(socialmsg, {{"%his", "your"}, {"%him", "you"}, {"%himself", "yourself"}}), player, target);
else
  return target == 0 ? $string_utils:pronoun_sub(socialmsg, this) | $string_utils:pronoun_sub(socialmsg, player, target);
endif
