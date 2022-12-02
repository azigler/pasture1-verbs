#20:find_prefix   this none this rxd

"find_prefix(prefix, string-list) => list index of something starting with prefix, or 0 or $ambiguous_match.";
{subject, choices} = args;
answer = 0;
for i in [1..length(choices)]
  if (index(choices[i], subject) == 1)
    if (answer == 0)
      answer = i;
    else
      answer = $ambiguous_match;
    endif
  endif
endfor
return answer;
