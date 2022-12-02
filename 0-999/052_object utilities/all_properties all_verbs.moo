#52:"all_properties all_verbs"   this none this rxd

"Syntax:  all_properties (OBJ what)";
"         all_verbs      (OBJ what)";
"";
"Returns all properties or verbs defined on `what' and all of its ancestors. Uses wizperms to get properties or verbs if the caller of this verb owns what, otherwise, uses caller's perms.";
what = args[1];
if (what.owner != caller_perms())
  set_task_perms(caller_perms());
endif
bif = verb == "all_verbs" ? "verbs" | "properties";
res = `call_function(bif, what) ! E_PERM => {}';
while (valid(what = parent(what)))
  res = {@`call_function(bif, what) ! E_PERM => {}', @res};
endwhile
return res;
