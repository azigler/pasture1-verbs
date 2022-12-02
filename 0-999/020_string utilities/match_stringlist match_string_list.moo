#20:"match_stringlist match_string_list"   this none this rx

"Copied from Puff (#1449):match_stringlist Tue Oct 19 08:18:13 1993 PDT";
"$string_utils:match_stringlist(string, {list of strings})";
"The list of strings should be just that, a list of strings.  The first string is matched against the list of strings.";
"If it exactly matches exactly one of them, the index of the match is returned. If it exactly matches more than one of them, $ambiguous_match is returned.";
"If there are no exact matches, then partial matches are considered, ones in which the given string is a prefix of one of the strings.";
"Again, if exactly one match is found, the index of that string is returned, and if more than one match is found, $ambiguous match is returned.";
"Finally, if there are no exact or partial matches, then $failed_match is returned.";
{subject, stringlist} = args;
if (subject == "" || length(stringlist) < 1)
  return $nothing;
endif
matches = {};
"First check for exact matches.";
for i in [1..length(stringlist)]
  if (subject == stringlist[i])
    matches = {@matches, i};
  endif
endfor
"Now return a match, or $ambiguous, or check for partial matches.";
if (length(matches) == 1)
  return matches[1];
elseif (length(matches) > 1)
  return $ambiguous_match;
elseif (length(matches) == 0)
  "Checking for partial matches is almost identical to checking for exact matches, but we use index(list[i], target) instead of list[i] == target to see if they match.";
  for i in [1..length(stringlist)]
    if (index(stringlist[i], subject) == 1)
      matches = {@matches, i};
    endif
  endfor
  if (length(matches) == 1)
    return matches[1];
  elseif (length(matches) > 1)
    return $ambiguous_match;
  elseif (length(matches) == 0)
    return $failed_match;
  endif
endif
