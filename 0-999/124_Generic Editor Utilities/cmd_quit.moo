#124:cmd_quit   this none this rxd

{state} = args;
if (state.verb && state.extra)
  {object, verbname} = state.extra[1];
  if (verb_code(object, verbname) != state.text && $command_utils:yes_or_no("If you proceed, the text of the working verb could be lost due to failed compilation. Are you sure you wish to continue?") != 1)
    player:tell("Aborted.");
    return E_INVARG;
  endif
  program = this:program_verb(object, verbname, state);
endif
