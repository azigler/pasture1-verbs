#6:parse_tone   this none this rxd

{tone} = args;
if (tone[$] == "s" && tone[$ - 1..$] != "es")
  tone = tone[1..$] + "es";
endif
if (tone[$] == "y")
  tone = tone[1..$ - 1] + "ies";
endif
tone[$] != "s" && (tone = "%<" + tone + "s>") || (tone = "%<" + tone + ">");
return tone;
"Last modified Thu Dec  8 06:48:22 2022 UTC by caranov (#133).";
