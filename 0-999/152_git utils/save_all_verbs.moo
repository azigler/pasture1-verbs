#152:save_all_verbs   none none none rxd

if (!caller_perms().wizard)
  raise(E_PERM);
endif
max_object = max_object();
"remove old verb files";
`file_rename("verbs/0-999/", tostr(".TRASH/", time())) ! ANY => 0';
`file_rename("verbs/1000-9999/", tostr(".TRASH/", time())) ! ANY => 0';
`file_rename("verbs/10000-99999/", tostr(".TRASH/", time())) ! ANY => 0';
`file_rename("verbs/100000-999999/", tostr(".TRASH/", time())) ! ANY => 0';
"set directory structure";
if (toint(max_object) < 1000)
  dir_zeroes = 3;
  dir_str = "0-999/";
elseif (toint(max_object) < 10000)
  dir_zeroes = 4;
  dir_str = "1000-9999/";
elseif (toint(max_object) < 100000)
  dir_zeroes = 5;
  dir_str = "10000-99999/";
elseif (toint(max_object) < 1000000)
  dir_zeroes = 6;
  dir_str = "100000-999999/";
endif
for object in [#0..max_object]
  yin();
  if (valid(object))
    "create padding for folder name";
    obj_num_str = tostr(object)[2..$];
    while (length(obj_num_str) < dir_zeroes)
      obj_num_str = "0" + obj_num_str;
    endwhile
    for vname in (verbs(object))
      yin();
      try
        vinfo = verb_info(object, vname);
        vargs = verb_args(object, vname);
        vfullname = vinfo[3];
        if (index(vfullname, " "))
          vfullname = toliteral(vfullname);
        endif
        if (index(vargs[2], "/"))
          vargs[2] = tostr("(", vargs[2], ")");
        endif
        "determine name of file";
        filename = tostr("verbs/", dir_str, obj_num_str, "_" + object.name + "/", vname, ".moo");
        "use same format as $prog:@list";
        vheader = tostr(object, ":", vfullname, "   ", $string_utils:from_list(vargs, " "), " ", vinfo[2]);
        if (!length(vcode = verb_code(object, vname)))
          vcode = {"(That verb has not been programmed.)"};
        endif
        file_content = {vheader, "", @vcode};
        $git_utils:save_verb(filename, file_content);
      except e (ANY)
        if (e[2] == "File name too long")
          filename = tostr("verbs/", dir_str, obj_num_str, "_" + object.name + "/", $string_utils:words(vname)[1], ".moo");
          $git_utils:save_verb(filename, file_content);
        endif
      endtry
    endfor
    if (!is_player(object))
      dump_name = tostr("verbs/", dir_str, obj_num_str, "_" + object.name + "/__dump.txt");
      $git_utils:save_dump(object, dump_name);
    endif
  endif
endfor
return player:notify("All verbs successfully saved to files.");
