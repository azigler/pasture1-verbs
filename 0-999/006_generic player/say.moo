#6:say   any any any rxd

"speaking styles can be done with ~ and !, to indicate emotion and tone, respectively.";
"say ~glumly !mutter we won't survive";
"would show up as Caranov glumly mutters, \"We won't survive.\" It also adapts to giving only one argument, whether it be emotion or tone.";
"Tones can also be natural, if punctuation is used at the end of the sentence, although it is vastly more limited.";
"keep in mind that messages must at least be 3 words long to take tone and emotion into consideration. This does not apply to punctuation.";
if (!args)
  return player:tell("What would you like to say?");
endif
message = args;
emotion = "";
tone = "say";
if (message:length() > 2 && message[1]:length() > 1 && message[2]:length() > 1)
  if (message[1][1] == "~")
    emotion = message[1][2..$];
  elseif (message[1][1] == "!")
    tone = message[1][2..$];
  endif
  if (message[2][1] == "!")
    tone = message[2][2..$];
  endif
  for i, ind in (message[1..2])
    if ("~" in i || "!" in i)
      message = message:setremove(i);
    endif
  endfor
endif
punc = ["?" -> "ask", "??" -> "demand", "???" -> "derisively ask", "!" -> "exclaim", "!!" -> "heavily emphasize", "!!!" -> "angrily roar", ".." -> "%<trail> off", "..." -> "muse"];
if (tone == "say")
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
tone[$] != "s" && (tone = "%<" + tone + "s>") || (tone = "%<" + tone + ">");
$you:say_action("%n " + emotion + " " + tone + ", \"" + $string_utils:from_list(message, " ") + "\"");
"Last modified Sat Dec  3 15:36:05 2022 UTC by caranov (#133).";
