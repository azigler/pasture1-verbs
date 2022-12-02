#108:dispatch   this none this rxd

{message, authkey, alist} = args;
if (caller == this)
  if (!this.phase && message == "mcp")
    authkey = $list_utils:assoc("authentication-key", alist);
    minv = $list_utils:assoc("version", alist);
    maxv = $list_utils:Assoc("to", alist);
    if (authkey && minv && maxv && $mcp:compare_version_range({minv[2], maxv[2]}, {$mcp.version, $mcp.version}))
      this:set_authentication_key(authkey[2]);
      this:add_package($mcp.negotiate, $mcp.negotiate.version_range[1]);
    else
      "woop woop break somehow";
      return;
    endif
    this:set_phase(1);
    $mcp.negotiate:do_negotiation();
  elseif (this.phase)
    if (this.authentication_key != E_NONE && authkey != this.authentication_key)
      return;
    endif
    package = this:find_handler(message);
    if (typeof(package) == OBJ)
      set_task_perms(caller_perms());
      package:dispatch(this:strip_prefix(this:package_name(package), message), alist);
    endif
    "figure out which package to dispatch to";
    "do dispatch";
  endif
endif
