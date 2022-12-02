#13:kill   this none this rxd

":kill(tree[,leafverb]) deletes tree and _kills all of the nodes that it uses.";
"if leafverb is given, caller:leafverb is called on all leaves in tree.";
if (tree = args[1])
  lverb = {@args, ""}[2];
  this:_skill(caller, typeof(tree) == LIST ? tree[1] | tree, lverb);
endif
"... otherwise nothing to do...";
