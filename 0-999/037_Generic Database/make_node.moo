#37:make_node   this none this rxd

"WIZARDLY";
return caller != this ? E_PERM | add_property(this, " " + args[1], listdelete(args, 1), {$generic_db.owner, this.node_perms});
