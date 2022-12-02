#3:acceptable   this none this rxd

what = args[1];
return this:is_unlocked_for(what) && (this:free_entry(@args) || (what == this.blessed_object && task_id() == this.blessed_task) || what.owner == this.owner || (typeof(this.residents) == LIST && (what in this.residents || what.owner in this.residents)));
