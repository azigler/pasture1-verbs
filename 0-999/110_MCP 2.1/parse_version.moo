#110:parse_version   this none this rxd

"string version number -> {major, minor}";
{version} = args;
if (m = match(version, "%([0-9]+%)%.%([0-9]+%)"))
  return {toint(substitute("%1", m)), toint(substitute("%2", m))};
endif
