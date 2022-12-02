#59:parse_sysobj_map   this none this rxd

"$code_utils:parse_sysobj_map(string)";
"Attempt to parse a string into a map on $sysobj, allowing it to function as a poor man's namespace.";
"Returns E_PROPNF if no map could be matched or the value of the given key's value if successful.";
{string} = args;
set_task_perms(caller_perms());
if (string[1] == "$")
  string = string[2..$];
endif
if ((ind = index(string, "[")) && string[$] == "]")
  key = strsub(string[ind + 1..$ - 1], "\"", "");
  "Let it work with \"key\" or key";
  ob = `#0.(string[1..ind - 1])[key] ! ANY';
  if (typeof(ob) != ERR)
    return ob;
  endif
endif
return E_PROPNF;
