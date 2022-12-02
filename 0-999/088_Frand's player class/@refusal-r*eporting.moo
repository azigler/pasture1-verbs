#88:@refusal-r*eporting   any any any rd

"'@refusal-reporting' - See if refusal reporting is on. '@refusal-reporting on', '@refusal-reporting off' - Turn it on or off..";
if (!argstr)
  player:tell("Refusal reporting is ", this.report_refusal ? "on" | "off", ".");
elseif (argstr in {"on", "yes", "y", "1"})
  this.report_refusal = 1;
  player:tell("Refusals will be reported to you as they happen.");
elseif (argstr in {"off", "no", "n", "0"})
  this.report_refusal = 0;
  player:tell("Refusals will happen silently.");
else
  player:tell("@refusal-reporting on     - turn on refusal reporting");
  player:tell("@refusal-reporting off    - turn it off");
  player:tell("@refusal-reporting        - see if it's on or off");
endif
