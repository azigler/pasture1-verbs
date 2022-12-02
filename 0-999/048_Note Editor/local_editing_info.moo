#48:local_editing_info   this none this rxd

{what, text} = args;
cmd = typeof(text) == STR ? "@set-note-string" | "@set-note-text";
name = typeof(what) == OBJ ? what.name | tostr(what[1].name, ".", what[2]);
note = typeof(what) == OBJ ? what | tostr(what[1], ".", what[2]);
"Check if the text is a list of strings. If so, edit it like text. Otherwise, parse values.";
type = "str:";
for x in (text)
  if (typeof(x) != STR)
    type = "val:";
    break;
  endif
endfor
ref = tostr(type, typeof(what) == OBJ ? tostr(what, ".text") | tostr(what[1], ".", what[2]));
return {name, text, tostr(cmd, " ", note), ref, "string-list"};
