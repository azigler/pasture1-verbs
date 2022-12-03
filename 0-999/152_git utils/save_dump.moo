#152:save_dump   this none this rxd

if (!caller_perms().wizard)
  raise(E_PERM);
endif
{object, path} = args;
tokens = $string_utils:explode(path, "/");
"make folders if needed";
for token_id in [1..length(tokens) - 1]
  `file_mkdir($string_utils:from_list(tokens[1..token_id], "/")) ! E_FILE';
endfor
handle = file_open(path, "w-tn");
file_writeline(handle, $code_utils:dump_preamble(object));
for line in ($code_utils:dump_verbs(object, 1))
  yin();
  file_writeline(handle, line);
endfor
for line in ($code_utils:dump_properties(object, 1))
  yin();
  file_writeline(handle, line);
endfor
file_close(handle);
