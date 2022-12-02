#68:set   this none this rxd

":set(optionlist,oname,value) => revised optionlist or string error message.";
"oname must be the full name of an option in .names or .extras.";
"Note that values must not be of type ERR.  ";
"FALSE (0, blank string, or empty list) is always a legal value.";
"If a verb :check_foo is defined on this, it will be used to typecheck any";
"non-false or object-type value supplied as a new value for option `foo'.";
"";
"   :check_foo(value) => string error message or {value to use}";
"";
"If instead there is a property .check_foo, that will give either the expected ";
"type or a list of allowed types.";
"Otherwise, the option is taken to be a boolean flag and all non-false, ";
"non-object values map to 1.";
"";
{options, oname, value} = args;
if (!(oname in this.names || oname in this.extras))
  return "Unknown option:  " + oname;
elseif (typeof(value) == ERR)
  "... no option should have an error value...";
  return "Error value";
elseif (!value && typeof(value) != OBJ)
  "... always accept FALSE (0, blankstring, emptylist)...";
elseif ($object_utils:has_callable_verb(this, check = "check_" + oname))
  "... a :check_foo verb exists; use it to typecheck the value...";
  if (typeof(c = this:(check)(value)) == STR)
    return c;
  endif
  value = c[1];
elseif ($object_utils:has_property(this, tprop = "type_" + oname))
  "... a .type_foo property exists...";
  "... property value should be a type or list of types...";
  if (!this:istype(value, t = this.(tprop)))
    return $string_utils:capitalize(this:desc_type(t) + " value expected.");
  endif
elseif ($object_utils:has_property(this, cprop = "choices_" + oname))
  "... a .choices_foo property exists...";
  "... property value should be a list of {value,docstring} pairs...";
  if (!$list_utils:assoc(value, c = this.(cprop)))
    return tostr("Allowed values: ", $string_utils:english_list($list_utils:slice(c, 1), "(??)", " or "));
  endif
else
  "... value is considered to be boolean...";
  if (!value)
    "... must be an object.  oops.";
    return tostr("Non-object value expected.");
  endif
  value = 1;
endif
"... We now have oname and a value.  However, if oname is one of the extras,";
"... then we need to call :actual to see what it really means.";
if (oname in this.names)
  nvlist = {{oname, value}};
elseif (typeof(nvlist = this:actual(oname, value)) != LIST || !nvlist)
  return nvlist || "Not implemented.";
endif
"... :actual returns a list of pairs...";
for nv in (nvlist)
  {oname, value} = nv;
  if (i = oname in options || $list_utils:iassoc(oname, options))
    if (!value && typeof(value) != OBJ)
      "value == 0, blank string, empty list";
      options[i..i] = {};
    elseif (value == 1)
      options[i] = oname;
    else
      options[i] = {oname, value};
    endif
  elseif (value || typeof(value) == OBJ)
    options[1..0] = {value == 1 ? oname | {oname, value}};
  endif
endfor
return options;
