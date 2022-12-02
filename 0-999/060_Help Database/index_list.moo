#60:index_list   this none this rxd

hdr = "Available Help Indices";
text = {"", hdr, $string_utils:space(hdr, "-")};
for db in ($code_utils:help_db_list())
  try
    for p in (db:find_index_topics())
      text = {@text, tostr($string_utils:left(p, 14), " -- ", `db.(p)[2] ! ANY' || db.name, " (", db, ")")};
    endfor
  except (ANY)
    "generally it will be E_TYPE when :find_index_topics returns an ERR. Just skip";
    continue db;
  endtry
endfor
if (full = this:find_full_index_topic())
  text = {@text, "", tostr($string_utils:left(full, 14), " -- ", "EVERYTHING")};
endif
return text;
