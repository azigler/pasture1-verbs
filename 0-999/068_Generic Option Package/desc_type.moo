#68:desc_type   this none this rxd

":desc_type(types) => string description of types";
nlist = {};
for t in (types = args[1])
  if (typeof(t) == LIST)
    if (length(t) > 1)
      nlist = {@nlist, tostr("(", this:desc_type(t), ")-list")};
    else
      nlist = {@nlist, tostr(this:desc_type(t), "-list")};
    endif
  elseif (t in {INT, OBJ, STR, LIST})
    nlist = {@nlist, {"number", "object", "string", "?", "list"}[t + 1]};
  else
    return "Bad type list";
  endif
endfor
return $string_utils:english_list(nlist, "nothing", " or ");
