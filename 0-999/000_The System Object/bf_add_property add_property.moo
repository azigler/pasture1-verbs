#0:"bf_add_property add_property"   this none this rxd

"add_property() -- see help on the builtin for more information. This verb is called by the server when $server_options.protect_add_property exists and is true and caller_perms() are not wizardly.";
who = caller_perms();
{what, propname, value, info} = args;
if (typeof(what) != OBJ)
  retval = E_TYPE;
elseif (!valid(what))
  retval = E_INVARG;
elseif (!$perm_utils:controls(who, what) && !what.w)
  retval = E_PERM;
elseif (!$perm_utils:controls(who, info[1]))
  retval = E_PERM;
elseif (!$quota_utils:property_addition_permitted(who))
  retval = E_QUOTA;
elseif (what.owner != who && !who.wizard && !$quota_utils:property_addition_permitted(what.owner))
  retval = E_QUOTA;
  "elseif (!who.programmer)";
  "  return E_PERM;     I wanted to do this, but $builder:@newmessage relies upon nonprogs being able to call add_property.  --Nosredna";
elseif (propname in {"object_size", "size_quota", "queued_task_limit"} && !who.wizard)
  retval = E_PERM;
else
  "we now know that the caller's perms control the object (or the object is writable), and that the caller's perms are permitted to control the new property's owner.";
  retval = `add_property(@args) ! ANY';
endif
return typeof(retval) == ERR && $code_utils:dflag_on() ? raise(retval) | retval;
