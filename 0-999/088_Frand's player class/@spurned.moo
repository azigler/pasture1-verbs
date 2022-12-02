#88:@spurned   none none none rd

"Displays a list of spurned objects.";
"Verb created by TheCat, 11/8/98";
if (this.spurned_objects)
  this:tell("You are spurning the following objects, including any and all descendents:  " + $string_utils:nn(this.spurned_objects));
else
  this:tell("You are not spurning any objects.");
endif
