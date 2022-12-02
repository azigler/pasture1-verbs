#59:find_last_verb_named   this none this rxd

":find_last_verb_named(object,name[,n])";
"  returns the *number* of the last verb on object matching the given name.";
"  optional argument n, if given, starts the search with verb n-1,";
"  causing verbs (n..length(verbs(object))) to be ignored.";
"  -1 is returned if no verb is found.";
"  This routine does not find inherited verbs.";
{object, name, ?last = -1} = args;
if (last < 0)
  last = length(verbs(object));
endif
for i in [0..last - 1]
  verbinfo = verb_info(object, last - i);
  if (this:verbname_match(verbinfo[3], name))
    return last - i;
  endif
endfor
return -1;
