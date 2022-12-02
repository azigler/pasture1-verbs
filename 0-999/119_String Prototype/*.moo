#119:*   this none this rxd

if (verb in {"init_for_core", "exitfunc", "enterfunc", "moveto"})
  return `pass(@args) ! ANY => 0';
elseif (verb == "length" || verb == "len")
  return length(this);
elseif (verb == "strip_ansi")
  return $ansi_utils:delete(this);
endif
if (verb in {"include_for_core", "proxy_for_core"})
  return {};
endif
"So that programmers can call string:json() or string:parse_json(),";
"And get a map as the return value (if the string can be parsed into json).";
if (verb == "parse_json" || verb == "json")
  return call_function("parse_json", this, @args);
endif
r = $string_utils:(verb)(this, @args);
if (r != 0)
  return r;
endif
