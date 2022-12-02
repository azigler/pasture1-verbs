#20:match_suspended   this none this rxd

"$string_utils:match_suspended(string [, obj-list, prop-name]*)";
"Each obj-list should be a list of objects or a single object, which is treated as if it were a list of that object.  Each prop-name should be string naming a property on every object in the corresponding obj-list.  The value of that property in each case should be either a string or a list of strings.";
"The argument string is matched against all of the strings in the property values.";
"If it exactly matches exactly one of them, the object containing that property is returned.  If it exactly matches more than one of them, $ambiguous_match is returned.";
"If there are no exact matches, then partial matches are considered, ones in which the given string is a prefix of some property string.  Again, if exactly one match is found, the object with that property is returned, and if there is more than one match, $ambiguous_match is returned.";
"Finally, if there are no exact or partial matches, then $failed_match is returned.";
"This verb will suspend as needed, and should be used if obj-list is very large.";
subject = args[1];
if (subject == "")
  return $nothing;
endif
no_exact_match = no_partial_match = 1;
for i in [1..length(args) / 2]
  prop_name = args[2 * i + 1];
  for object in (typeof(olist = args[2 * i]) == LIST ? olist | {olist})
    if (valid(object))
      if (typeof(str_list = `object.(prop_name) ! E_PERM, E_PROPNF => {}') != LIST)
        str_list = {str_list};
      endif
      if (subject in str_list)
        if (no_exact_match)
          no_exact_match = object;
        elseif (no_exact_match != object)
          return $ambiguous_match;
        endif
      else
        for string in (str_list)
          if (index(string, subject) != 1)
          elseif (no_partial_match)
            no_partial_match = object;
          elseif (no_partial_match != object)
            no_partial_match = $ambiguous_match;
          endif
        endfor
      endif
    endif
    $command_utils:suspend_if_needed(5);
  endfor
endfor
return no_exact_match && (no_partial_match && $failed_match);
