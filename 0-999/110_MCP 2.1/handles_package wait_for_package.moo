#110:"handles_package wait_for_package"   this none this rxd

{who, @rest} = args;
if (valid(session = this:session_for(who)))
  return session:(verb)(@rest);
endif
