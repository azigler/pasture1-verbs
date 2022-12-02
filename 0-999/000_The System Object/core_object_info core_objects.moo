#0:"core_object_info core_objects"   this none this rxd

set_task_perms($no_one);
{?core_variant = "Imnotsurewhatthisshouldbeyetdontdependonthis", ?in_mcd = 0} = args;
if (in_mcd)
  {vb, perms, loc} = callers()[1][2..4];
  if (vb != "make-core-database" || !perms.wizard || loc != $wiz)
    raise(E_PERM);
  endif
endif
core_objects = {};
proxy_original = proxy_incore = core_properties = skipped_parents = namespaces = {};
todo = {{#0, {"sysobj", "owner"}}};
"...lucky for us #0 has a self-referential property";
while ({?sfc, @todo} = todo)
  {o, ?props_to_follow = {}} = sfc;
  o_props = {};
  for p in (props_to_follow)
    v = o.(p);
    "...namespaces should be maps with only object values.";
    if (typeof(v) == MAP)
      map_values = mapvalues(v);
      for x in (map_values)
        if (typeof(x) != OBJ)
          continue p;
        endif
      endfor
      namespaces = {@namespaces, {o, p, v}};
      core_objects = {@core_objects, @map_values};
    else
      for v in (typeof(o.(p)) == MAP ? mapvalues(o.(p)) | {o.(p)})
        if (typeof(v) != OBJ || !valid(v))
          continue p;
        endif
        o_props = {@o_props, p};
        if (v in proxy_original || v in core_objects)
          "...we have been here before...";
          continue p;
        endif
        if ($object_utils:has_callable_verb(v, "proxy_for_core"))
          "...proxy_for_core() returns an object to";
          "...take the place of v in the final core.";
          "...For * verbs, proxy_for_core will also accept {}";
          proxy_original[1..0] = {v};
          try
            vnew = v:proxy_for_core(core_variant, in_mcd);
            if (typeof(vnew) in {OBJ, LIST} == 0)
              raise(E_TYPE, "returned non-object, non-empty list");
            elseif (vnew in proxy_original > 1)
              raise(E_RECMOVE, "proxy loop");
            endif
          except e (ANY)
            player:notify(tostr("Error from ", v, ":proxy_for_core => ", e[2]));
            player:notify(toliteral(e[4]));
            vnew = #-1;
          endtry
          if (vnew == v || typeof(vnew) == LIST)
            proxy_original[1..1] = {};
          else
            proxy_incore[1..0] = {vnew};
            if (vnew in core_objects || !valid(vnew))
              continue p;
            endif
            v = vnew;
          endif
        endif
        if ($object_utils:has_callable_verb(v, "include_for_core"))
          "...include_for_core() returns a list of properties on v";
          "...to be searched for additional core objects.";
          try
            v_props = v:include_for_core(core_variant);
            if (typeof(v_props) != LIST)
              raise(E_TYPE, "returned non-list");
            endif
            if (v_props)
              todo = {@todo, {v, v_props}};
            endif
          except e (ANY)
            player:notify(tostr("Error from ", v, ":include_for_core => ", e[2]));
            player:notify(toliteral(e[4]));
          endtry
        endif
        core_objects = setadd(core_objects, v);
      endfor
    endif
  endfor
  core_properties = {@core_properties, {o, o_props}};
endwhile
for o in (core_objects)
  p = parent(o);
  while (valid(p))
    if (!(p in core_objects))
      skipped_parents = setadd(skipped_parents, p);
    endif
    p = parent(p);
  endwhile
endfor
if (verb == "core_object_info")
  "... what make-core-database needs";
  return {core_objects, core_properties, skipped_parents, proxy_original, proxy_incore, namespaces};
else
  "... what most people care about";
  return core_objects;
endif
