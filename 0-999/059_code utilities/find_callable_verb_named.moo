#59:find_callable_verb_named   this none this rxd

":find_callable_verb_named(object,name[,n])";
"  returns the *number* of the first verb on object that matches the given";
"  name and has the x flag set.";
"  optional argument n, if given, starts the search with verb n,";
"  causing the first n verbs (0..n-1) to be ignored.";
"  0 is returned if no verb is found.";
"  This routine does not find inherited verbs.";
{object, name, ?start = 1} = args;
for i in [start..length(verbs(object))]
  verbinfo = verb_info(object, i);
  if (index(verbinfo[2], "x") && this:verbname_match(verbinfo[3], name))
    return i;
  endif
endfor
return 0;
