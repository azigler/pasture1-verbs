#3:bless_for_entry   this none this rxd

if (caller in {@this.entrances, this})
  this.blessed_object = args[1];
  this.blessed_task = task_id();
endif
