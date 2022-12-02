#22:errors   this none this rxd

text = args[1];
for i in [1..length($code_utils.error_list)]
  text = {@text, tostr("    ", $string_utils:left($code_utils.error_names[i], 15), $code_utils.error_list[i])};
endfor
return text;
