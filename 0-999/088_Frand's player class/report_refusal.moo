#88:report_refusal   this none this rxd

"'report_refusal (<player>, <message>, ...)' - If refusal reporting is turned on, print the given <message> to report the refusal of some action by <player>. The message may take more than one argument. You can override this verb to do more selective reporting.";
if (this.report_refusal)
  this:tell(@listdelete(args, 1));
endif
