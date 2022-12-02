#24:_set_property_flags   this none this rxd

"_set_property_flags(object, pname, {owner, flags} or something+\"c\", suspendok)";
"auxiliary to :set_property_flags... don't call this directly.";
if (caller != this)
  return E_PERM;
endif
if (args[4] && $command_utils:running_out_of_time(0))
  suspend(0);
endif
object = args[1];
if (typeof(args[3]) != LIST)
  set_property_info(object, args[2], {object.owner, args[3]});
else
  set_property_info(@args[1..3]);
endif
for kid in (children(object))
  this:_set_property_flags(@listset(args, kid, 1));
endfor
