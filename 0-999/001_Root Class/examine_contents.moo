#1:examine_contents   this none this rxd

"examine_contents(examiner)";
"by default, calls :tell_contents.";
"Should probably go away.";
who = args[1];
if (caller == this)
  try
    this:tell_contents(this.contents, this.ctype);
  except (ANY)
    "Just ignore it. We shouldn't care about the contents unless the object wants to tell us about them via :tell_contents ($container, $room)";
  endtry
endif
