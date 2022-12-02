#59:parse_argspec   this none this rxd

":parse_arg_spec(@args)";
"  attempts to parse the given sequence of args into a verb_arg specification";
"returns {verb_args,remaining_args} if successful.";
"  e.g., :parse_arg_spec(\"this\",\"in\",\"front\",\"of\",\"any\",\"foo\"..)";
"           => {{\"this\",\"in front of\",\"any\"},{\"foo\"..}}";
"returns a string error message if parsing fails.";
nargs = length(args);
if (nargs < 1)
  return {{}, {}};
elseif ((ds = args[1]) == "tnt")
  return {{"this", "none", "this"}, listdelete(args, 1)};
elseif (!(ds in {"this", "any", "none"}))
  return tostr("\"", ds, "\" is not a valid direct object specifier.");
elseif (nargs < 2 || args[2] in {"none", "any"})
  verbargs = args[1..min(3, nargs)];
  rest = args[4..nargs];
elseif (!(gp = $code_utils:get_prep(@args[2..nargs]))[1])
  return tostr("\"", args[2], "\" is not a valid preposition.");
else
  verbargs = {ds, @gp[1..min(2, nargs = length(gp))]};
  rest = gp[3..nargs];
endif
if (length(verbargs) >= 3 && !(verbargs[3] in {"this", "any", "none"}))
  return tostr("\"", verbargs[3], "\" is not a valid indirect object specifier.");
endif
return {verbargs, rest};
