#37:proxy_for_core   this none this rxd

"Create a stand-in for the core-extraction process";
"  (rather than change the ownership on 80000 properties only to delete them).";
{core_variant, is_mcd} = args;
if (!is_mcd)
  return this;
elseif (caller != #0)
  raise(E_PERM);
elseif (children(this) || length(properties(this)) < 100)
  return this;
endif
proxy = $recycler:_create(parent(this), this.owner);
player:tell("Creating proxy object ", proxy, " for ", this.name, " (", this, ")");
for p in ({"name", "r", "w", "f"})
  proxy.(p) = this.(p);
endfor
for p in ($object_utils:all_properties_suspended(parent(this)))
  if (!is_clear_property(this, p))
    $command_utils:suspend_if_needed(0, "...setting props from parent...");
    proxy.(p) = this.(p);
  endif
endfor
for p in (properties(this))
  $command_utils:suspend_if_needed(0);
  if (p[1] == " " && p != " ")
    continue;
  endif
  add_property(proxy, p, this.(p), property_info(this, p));
endfor
for v in [1..length(verbs(this))]
  add_verb(proxy, verb_info(this, v), verb_args(this, v));
  set_verb_code(proxy, v, verb_code(this, v));
  $command_utils:suspend_if_needed(0);
endfor
proxy:clearall();
return proxy;
