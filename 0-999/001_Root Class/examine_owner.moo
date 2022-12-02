#1:examine_owner   this none this rxd

"examine_owner(examiner)";
"Return a list of strings to be told to the player, indicating who owns this.";
return {tostr("Owned by ", this.owner.name, ".")};
