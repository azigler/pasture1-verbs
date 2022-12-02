#30:dump_topic   this none this rxd

try
  text = this.(fulltopic = args[1]);
  return {tostr(";;", $code_utils:corify_object(this), ".(", toliteral(fulltopic), ") = $command_utils:read_lines()"), @$command_utils:dump_lines(text)};
except error (ANY)
  return error[1];
endtry
