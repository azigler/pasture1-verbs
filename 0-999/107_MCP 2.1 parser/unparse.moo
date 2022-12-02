#107:unparse   this none this rxd

{request, authkey, alist} = args;
keyvals = "";
need_data_tag = 0;
multilines = {};
for keyval in (alist)
  {keyword, value, ?maybe_ignore} = keyval;
  if (typeof(value) == STR)
    if (!match(value, this.unquoted_string))
      value = toliteral(value);
    endif
  elseif (typeof(value) == LIST)
    need_data_tag = 1;
    multilines = {@multilines, {keyword, value}};
    keyword = keyword + "*";
    value = "\"\"";
  else
    value = toliteral(value);
  endif
  keyvals = keyvals + " " + keyword + ": " + value;
endfor
if (need_data_tag)
  data_tag = this:next_datakey();
  keyvals = keyvals + " _data-tag: " + data_tag;
endif
message = "#$#" + request;
if (authkey)
  message = message + " " + authkey;
endif
message = {message + keyvals};
if (need_data_tag)
  prefix = "#$#* " + data_tag + " ";
  for field in (multilines)
    {keyword, value} = field;
    for line in (value)
      message = {@message, tostr(prefix, keyword, ": ", typeof(line) == LIST ? toliteral(line) | line)};
    endfor
  endfor
  message = {@message, "#$#: " + data_tag};
endif
return message;
