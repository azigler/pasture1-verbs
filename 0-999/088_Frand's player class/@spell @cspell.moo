#88:"@spell @cspell"   any any any rd

"@spell a word or phrase  -- Spell check a word or phrase.";
"@spell thing.prop  -- Spell check a property. The value must be a string or a list of strings.";
"@spell thing:verb  -- Spell check a verb. Only the quoted strings in the verb are checked.";
"@cspell word  -- Spell check a word, and if it is not in the dictionary, offset suggestions about what the right spelling might be. This actually works with thing.prop and thing:verb too, but it is too slow to be useful--it takes maybe 30 seconds per unknown word.";
"";
"Mr. Spell was written by waffle (waffle@euclid.humboldt.edu), for use by";
"MOOers all over this big green earth. (....and other places....)";
"This monstrosity programmed Sept-Oct 1991, when I should have been studying.";
"Mr. Spell was then gutted by lisdude on 2-17-19 to use ToastStunt builtins.";
set_task_perms(player);
if (!argstr)
  player:notify(tostr("Usage: ", verb, " object.property"));
  player:notify(tostr("       ", verb, " object:verb"));
  player:notify(tostr("       ", verb, " one or more words"));
else
  "@spell or @cspell.";
  corrected_words = {};
  data = $spell:get_input(argstr);
  if (data)
    misspelling = 0;
    for i in [1..length(data)]
      line = $string_utils:words(data[i]);
      for ii in [1..length(line)]
        $command_utils:suspend_if_needed(0);
        if (!$spell:valid(line[ii]))
          if (rindex(line[ii], "s") == length(line[ii]) && $spell:valid(line[ii][1..$ - 1]))
            msg = "Possible match: " + line[ii];
            msg = msg + " " + (length(data) != 1 ? "(line " + tostr(i) + ")  " | "  ");
          elseif (rindex(line[ii], "'s") == length(line[ii]) - 1 && $spell:valid(line[ii][1..$ - 2]))
            msg = "Possible match: " + line[ii];
            msg = msg + " " + (length(data) != 1 ? "(line " + tostr(i) + ")  " | "  ");
          else
            misspelling = misspelling + 1;
            msg = "Unknown word: " + line[ii] + (length(data) != 1 ? " (line " + tostr(i) + ")  " | "  ");
            if (verb == "@cspell" && !(line[ii] in corrected_words))
              corrected_words = listappend(corrected_words, line[ii]);
              guesses = $string_utils:from_list($spell:guess_words(line[ii]), " ");
              if (guesses == "")
                msg = msg + "-No guesses";
              else
                msg = msg + "-Possible correct spelling";
                msg = msg + (index(guesses, " ") ? "s: " | ": ");
                msg = msg + guesses;
              endif
            endif
          endif
          player:notify(tostr(msg));
        endif
      endfor
    endfor
    player:notify(tostr("Found ", misspelling ? misspelling | "no", " misspelled word", misspelling == 1 ? "." | "s."));
  elseif (data != $failed_match)
    player:notify(tostr("Nothing found to spellcheck!"));
  endif
endif
