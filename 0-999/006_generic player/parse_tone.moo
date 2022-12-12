#6:parse_tone   this none this rxd

{tone} = args;
if (tone[$] == "s" && tone[$ - 1..$] != "es")
  tone = tone[1..$] + "es";
endif
if (tone[$] == "y" && tone != "say")
  tone = tone[1..$ - 1] + "ies";
endif
tone[$] != "s" && (tone = "%<" + tone + "s>") || (tone = "%<" + tone + ">");
return tone;
"Last modified Sun Dec 11 22:05:23 2022 UTC by Lindsey (#146).";
