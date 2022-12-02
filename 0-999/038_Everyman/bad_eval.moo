#38:bad_eval   this none this rxd

":bad_eval(exp)";
"  Returns 1 if the `exp' is inappropriate for use by $no_one.  In particular, if `exp' contains calls to `eval', `fork', `suspend', or `call_function' it is bad.  Similarly, if `player' is a nonvalid object the expression is considered `bad' because it is likely an attempt to anonymously spoof.";
"  At present, the checks for bad builtins are overzealous.  It should check for delimited uses of the above calls, in case someone has a variable called `prevalent'.";
{exp} = args;
if (index(exp, "eval") || index(exp, "fork") || index(exp, "suspend") || index(exp, "call_function"))
  "Well, they had one of the evil words in here.  See if it was in a quoted string or not -- we want to permit player:tell(\"Gentlemen use forks.\")";
  for bad in ({"eval", "fork", "suspend", "call_function"})
    tempindex = 1;
    while (l = index(exp[tempindex..$], bad, 0))
      if ($code_utils:inside_quotes(exp[1..tempindex + l - 1]))
        tempindex = tempindex + l;
      else
        "it's there, bad unquoted string";
        return 1;
      endif
    endwhile
  endfor
endif
if (!$recycler:valid(player) && player >= #0)
  return 1;
endif
return 0;
