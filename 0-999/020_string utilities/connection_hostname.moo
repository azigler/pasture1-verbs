#20:connection_hostname   this none this rxd

"Return the host string for an object or extract it from a legacy connection_name() string. Assumes you are using bsd_network style connection names.";
caller != #0 && set_task_perms(caller_perms());
{lookup} = args;
if (typeof(lookup) == OBJ)
  return `connection_name(lookup) ! E_INVARG => ""';
elseif (typeof(lookup) == STR)
  "Make the assumption here that connection_name() has been passed in from legacy code and contains just the host string.";
  return (m = `match(lookup, "^.* %(from%|to%) %([^, ]+%)") ! ANY') ? substitute("%2", m) | lookup;
else
  return "";
endif
