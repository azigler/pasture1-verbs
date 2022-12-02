#108:send   this none this rxd

{message, alist} = args;
who = caller_perms();
if (caller == this)
  prefix = "";
elseif ($list_utils:assoc(caller, this.packages))
  package = caller;
  message = this:message_fullname(this:package_name(package), message);
else
  raise(E_PERM);
endif
con = this.connection;
snoop = `this.connection.MCP_snoop ! E_PROPNF, E_INVIND => 0';
for line in ($mcp.parser:unparse(message, this.authentication_key, alist))
  notify(con, line);
  if (snoop)
    notify(con, "S->C: " + line);
  endif
endfor
