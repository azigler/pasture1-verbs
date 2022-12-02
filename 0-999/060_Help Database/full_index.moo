#60:full_index   this none this rxd

text = {};
for db in ($code_utils:help_db_list())
  if ($object_utils:has_callable_verb(db, "index"))
    text = {@text, @db:index({tostr(db.name, " (", db, ")")})};
  endif
endfor
return text;
