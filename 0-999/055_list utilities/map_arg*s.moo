#55:map_arg*s   this none this rxd

"map_arg([n,]object,verb,@args) -- assumes the nth element of args is a list, calls object:verb(@args) with each element of the list substituted in turn, returns the list of results.  n defaults to 1.";
"map_verb_arg(o,v,{a...},a2,a3,a4,a5)={o:v(a,a2,a3,a4,a5),...}";
"map_verb_arg(4,o,v,a1,a2,a3,{a...},a5)={o:v(a1,a2,a3,a,a5),...}";
set_task_perms(caller_perms());
if (n = args[1])
  {object, verb, @rest} = args[2..$];
else
  object = n;
  n = 1;
  {verb, @rest} = args[2..$];
endif
results = {};
for a in (rest[n])
  results = listappend(results, object:(verb)(@listset(rest, a, n)));
endfor
return results;
