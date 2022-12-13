#6:"-* say"   any any any rxd

"speaking styles can be done with ~ and !, to indicate emotion and tone, respectively.";
"say ~glumly !mutter we won't survive";
"would show up as Caranov glumly mutters, \"We won't survive.\" It also adapts to giving only one argument, whether it be emotion or tone.";
"Tones can also be natural, if punctuation is used at the end of the sentence, although it is vastly more limited.";
"keep in mind that messages must at least be 3 words long to take tone and emotion into consideration. This does not apply to punctuation.";
if (!args)
  return player:tell("What would you like to say?");
endif
if (verb[1] == "-" && length(verb) > 1)
  target = player:my_match_object(verb[2..$]);
  if (valid(target))
    dobj = target;
    target = 1;
  else
    return player:tell("I don't see \"" + verb[2..$] + "\" here.");
  endif
else
  target = "";
endif
message = args;
{emotion = "", tone = {"say", "to"}};
for i in (message[1..$])
  if (i[1] == "~")
    emotion = i[2..$];
  elseif (i[1] == "!")
    tone = {i[2..$], "at"};
  endif
  if (i[1] in {"~", "!"})
    message = message:setremove(i);
  endif
endfor
punc = ["?" -> {"ask", ""}, "??" -> {"demand", "of "}, "???" -> {"derisively ask", ""}, "!" -> {"exclaim", "at "}, "!!" -> {"heavily emphasize", "to "}, "!!!" -> {"angrily roar", "at "}, ".." -> {"%<trail> off", "at "}, "..." -> {"muse", "to "}];
if (tone[1] == "say")
  for examine in ({length(message[$]) - 2, length(message[$]) - 1, length(message[$])})
    try
      if (maphaskey(punc, message[$][examine..$]))
        tone = punc[message[$][examine..$]];
        break;
      endif
    except e (ANY)
      continue;
    endtry
  endfor
endif
{tone, prep} = tone;
$you:say_action(msg = "%N " + (emotion ? emotion + " " | "") + this:parse_tone(tone) + (target ? " " + prep + " %d" | "") + ", \"" + $string_utils:from_list(message, " ") + "\"");
this:add_replay_entry({"general", "say"}, $string_utils:pronoun_sub(msg));
"Last modified Tue Dec 13 17:15:25 2022 UTC by caranov (#133).";
