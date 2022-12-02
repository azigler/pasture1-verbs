#104:match_request   this none this rxd

"Usage:  :match_request(request)";
"";
request = args[1];
if ($object_utils:has_verb(this, verbname = "mcp_" + request))
  return verbname;
else
  return 0;
endif
"version: 1.0 Fox Wed Jul  5 17:58:14 1995 EDT";
