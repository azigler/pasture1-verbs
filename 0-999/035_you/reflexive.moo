#35:reflexive   this none this rxd

"Copied from you (#67923):reflexive [verb author Blob (#21528)] at Wed Jul 13 05:09:32 2005 PDT";
":reflexive(msg, %[di])";
"Make a message reflexive by replacing %d or %i with %r.";
{msg, pos} = args;
upper = $string_utils:uppercase(pos) + "'s";
lower = $string_utils:lowercase(pos) + "'s";
msg = strsub(msg, lower, "%p", 1);
msg = strsub(msg, upper, "%P", 1);
msg = strsub(msg, pos, "%r", 1);
msg = strsub(msg, $string_utils:uppercase(pos), "%R", 1);
return msg;
