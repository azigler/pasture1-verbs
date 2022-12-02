#152:save_verb   this none this rxd

if (!caller_perms().wizard)
  raise(E_PERM);
endif
{path, content} = args;
tokens = $string_utils:explode(path, "/");
"make folders if needed";
for token_id in [1..length(tokens) - 1]
  `file_mkdir($string_utils:from_list(tokens[1..token_id], "/")) ! E_FILE';
endfor
handle = file_open(path, "w-tn");
for line in (content)
  yin();
  file_writeline(handle, line);
endfor
file_close(handle);
