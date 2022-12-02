#27:intersection_preserve_case   this none this rxd

"Copied from Fox (#54902):intersection Mon Dec 27 17:02:57 1993 PST";
"a version of $set_utils:intersection that maintains the property that everything in the return value is in the first argument, even considering case";
if (!args)
  return {};
endif
{result, @rest} = args;
for s in (rest)
  for x in (result)
    if (!(x in s))
      result = setremove(result, x);
    endif
  endfor
endfor
return result;
