#102:parse_escape   this none this rxd

oname = args[1];
raw = args[2];
if (typeof(raw) == STR)
  return {oname, raw};
else
  return "String value expected.";
endif
