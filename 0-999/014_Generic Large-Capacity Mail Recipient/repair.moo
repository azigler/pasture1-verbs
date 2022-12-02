#14:repair   this none none rd

"Syntax: repair <biglist>";
"";
"This tool makes a last-resort attempt to repair broken biglists (ones whose data structures are out of alignment due to an error such as \"out of ticks\" during some update operation leaving the b-tree in an inconsistent state).  This tool comes with no warranty of any kind.  You should only use it when you have no other choice, and you should make an attempt to @dump or fully copy or otherwise checkpoint your object before attempting to repair it so that you can recover from any failures this might produce.  This operation is NOT undoable.";
if (!$perm_utils:controls(player, this))
  player:tell("You do not control that.");
elseif (!$command_utils:yes_or_no("This tool can be used to repair some (but maybe not all) situations involving generic biglists that have had an error (usually \"out of ticks\") during an update operation and were left inconsistent.  Is this list really and truly broken in such a way?"))
  player:tell("No action taken.  PLEASE don't use this except in extreme cases.");
elseif (!$command_utils:yes_or_no("Have you made a best effort to @dump or otherwise save the contents in case this make things worse?"))
  player:tell("No action taken.  PLEASE do any saving you can before proceeding.");
elseif (!$command_utils:yes_or_no("This tool comes with no warranty of any kind.  Is this really your last resort and are you prepared to accept the consequences of utter failure?  There is no undoing the actions this takes.  Do you understand and accept the risks?"))
  player:tell("No action taken.  I'm not taking any responsibility for this failing.  It's gotta be your choice.");
else
  player:tell("OK!  Going ahead with repair attempts...");
  this:_repair();
  player:tell("All done.  If this worked, you can thank Mickey.  If not, remember the promises you made above about accepting responsibility for failure.");
endif
"Last modified Fri Feb 16 08:36:27 1996 MST by Minnie (#123).";
