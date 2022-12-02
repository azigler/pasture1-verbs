#99:self_diagnostic   this none this rx

":self_diagnostic ([NUM fix[, OBJ plyr]]) => NUM errors fixed";
"Reports all errors found to <plyr> or the current player.";
"Fixes any errors it can if <fix> is specified and true.";
"<errors fixed> is the errors that could have been fixed if <fix> is false.";
if (!this:trusts(caller_perms()))
  return E_PERM;
else
  count = 0;
  for x in (this.diagnostic_tests)
    player:tell("Running test \"", x, "\"...");
    count = count + !!this:("test_" + x)(@args);
  endfor
  return count;
endif
