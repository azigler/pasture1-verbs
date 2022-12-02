#59:argstr   this none this rxd

":argstr(verb,args[,argstr]) => what argstr should have been.  ";
"Recall that the command line is parsed into a sequence of words; `verb' is";
"assigned the first word, `args' is assigned the remaining words, and argstr";
"is assigned a substring of the command line, which *should* be the one";
"starting first nonblank character after the verb, but is instead (because";
"the parser is BROKEN!) the one starting with the first nonblank character";
"after the first space in the line, which is not necessarily after the verb.";
"Clearly, if the verb contains spaces --- which can happen if you use";
"backslashes and quotes --- this loses, and argstr will then erroneously";
"have extra junk at the beginning.  This verb, given verb, args, and the";
"actual argstr, returns what argstr should have been.";
verb = args[1];
argstr = {@args, argstr}[3];
n = length(args = args[2]);
if (!index(verb, " "))
  return argstr;
elseif (!args)
  return "";
endif
"space in verb => two possible cases:";
"(1) first space was not in a quoted string.";
"    first word of argstr == rest of verb unless verb ended on this space.";
if ((nqargs = $string_utils:words(argstr)) == args)
  return argstr;
elseif ((nqn = length(nqargs)) == n + 1 && nqargs[2..nqn] == args)
  return argstr[$string_utils:word_start(argstr)[2][1]..length(argstr)];
else
  "(2) first space was in a quoted string.";
  "    argstr starts with rest of string";
  qs = $string_utils:word_start("\"" + argstr);
  return argstr[qs[length(qs) - length(args) + 1][1] - 1..length(argstr)];
endif
