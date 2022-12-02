#68:show   this none this rxd

":show(options,name or list of names)";
" => text describing current value of option and what it means";
name = args[2];
if (typeof(name) == LIST)
  text = {};
  for n in (name)
    text = {@text, @this:show(@listset(args, n, 2))};
  endfor
  return text;
elseif (!(name in this.names || name in this.extras))
  return {"Unknown option:  " + name};
elseif ($object_utils:has_callable_verb(this, sverb = "show_" + name))
  r = this:(sverb)(@args);
  value = r[1];
  desc = r[2];
elseif ($object_utils:has_property(this, sverb) && (value = this:get(args[1], name)) in {0, 1})
  desc = this.(sverb)[value + 1];
  if (typeof(desc) == STR)
    desc = {desc};
  endif
elseif ($object_utils:has_property(this, cprop = "choices_" + name))
  if (!(value = this:get(args[1], name)))
    desc = this.(cprop)[1][2];
  elseif (!(a = $list_utils:assoc(value, this.(cprop))))
    return {name + " has unexpected value " + toliteral(value)};
  else
    desc = a[2];
  endif
elseif (name in this.extras)
  return {name + " not documented (complain)"};
else
  value = this:get(args[1], name);
  desc = {"not documented (complain)"};
  if (typeof(value) in {LIST, STR})
    desc[1..0] = toliteral(value);
    value = "";
  endif
endif
if (value in {0, 1})
  which = "-+"[value + 1] + name;
elseif (typeof(value) in {OBJ, STR, INT} && value != "")
  which = tostr(" ", name, "=", value);
else
  which = " " + name;
endif
show = {$string_utils:left(which + "  ", this.namewidth) + desc[1]};
for i in [2..length(desc)]
  show = {@show, $string_utils:space(this.namewidth) + desc[i]};
endfor
return show;
