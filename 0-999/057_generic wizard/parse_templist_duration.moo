#57:parse_templist_duration   this none this rxd

"parses out the time interval at the beginning of the args[1], assumes rest is commentary.";
if ((fw = $string_utils:first_word(args[1]))[1] == "for")
  words = $string_utils:words(fw[2]);
  try_ = {};
  ind = cont = 1;
  while (cont)
    word = words[ind];
    cont = ind;
    if (toint(word))
      try_ = {@try_, word};
      ind = ind + 1;
    else
      for set in ($time_utils.time_units)
        if (word in set)
          try_ = {@try_, word};
          ind = ind + 1;
        endif
      endfor
    endif
    if (cont == ind || ind > length(words))
      cont = 0;
    endif
  endwhile
  dur = $time_utils:parse_english_time_interval(@try_);
  rest = $string_utils:from_list(words[ind..$], " ");
  return {1, time(), dur, rest};
else
  return {0, argstr};
endif
