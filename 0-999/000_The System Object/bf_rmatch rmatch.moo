#0:"bf_rmatch rmatch"   this none this rxd

r = `rmatch(@args) ! ANY';
return typeof(r) == ERR && $code_utils:dflag_on() ? raise(r) | r;
