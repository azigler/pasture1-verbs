#10:parse_command   this none this rxd

":parse_command(@args) => {verb, args}";
"Given the args from #0:do_login_command,";
"  returns the actual $login verb to call and the args to use.";
"Commands available to not-logged-in users should be located on this object and given the verb_args \"any none any\"";
if (caller != #0 && caller != this)
  return E_PERM;
endif
if (li = this:interception(player))
  return {@li, @args};
endif
if (!args)
  return {this.blank_command, @args};
elseif ((verb = args[1]) && !$string_utils:is_numeric(verb))
  for i in ({this, @$object_utils:ancestors(this)})
    try
      if (verb_args(i, verb) == {"any", "none", "any"} && index(verb_info(i, verb)[2], "x"))
        return args;
      endif
    except (ANY)
      continue i;
    endtry
  endfor
endif
return {this.bogus_command, @args};
