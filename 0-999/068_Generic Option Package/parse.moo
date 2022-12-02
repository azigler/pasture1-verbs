#68:parse   this none this rxd

":parse(args[,...]) => {oname [,value]} or string error message";
"additional arguments are fed straight through to :parse_* routines.";
" <option> <value>     => {option, value}";
" <option>=<value>     => {option, value}";
" <option> is <value>  => {option, value}";
" +<option>            => {option, 1}";
" -<option>            => {option, 0}";
" !<option>            => {option, 0}";
" <option>             => {option}";
if (!(words = args[1]))
  return "";
endif
option = words[1];
words[1..1] = {};
if (flag = option && index("-+!", option[1]))
  option[1..1] = "";
endif
if (i = index(option, "="))
  rawval = option[i + 1..$];
  option = option[1..i - 1];
  if (i == 1)
    "... =bar ...";
    return "Blank option name?";
  elseif (flag)
    "... +foo=bar";
    return "Don't give a value if you use +, -, or !";
  elseif (words)
    "... foo=bar junk";
    return $string_utils:from_list(words, " ") + "??";
  endif
elseif (!option)
  return "Blank option name?";
elseif (flag)
  if (words)
    "... +foo junk";
    return "Don't give a value if you use +, -, or !";
  endif
  rawval = (flag - 1) % 2;
else
  words && (words[1] == "is" && (words[1..1] = {}));
  rawval = words;
endif
"... do we know about this option?...";
if (!(oname = this:_name(strsub(option, "-", "_"))))
  return tostr(oname == $failed_match ? "Unknown" | "Ambiguous", " option:  ", option);
endif
"... determine new value...";
if (!rawval)
  "... `@option foo is' or `@option foo=' ...";
  return rawval == {} ? {oname} | {oname, 0};
elseif ($object_utils:has_callable_verb(this, pverb = "parse_" + oname))
  return this:(pverb)(oname, rawval, args[2..$]);
elseif ($object_utils:has_property(this, cprop = "choices_" + oname))
  return this:parsechoice(oname, rawval, this.(cprop));
elseif (rawval in {0, "0", {"0"}})
  return {oname, 0};
elseif (rawval in {1, "1", {"1"}})
  return {oname, 1};
else
  return tostr("Option is a flag, use `+", option, "' or `-", option, "' (or `!", option, "')");
endif
