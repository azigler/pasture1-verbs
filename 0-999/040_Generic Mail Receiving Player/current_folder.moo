#40:current_folder   this none this rxd

":current_folder() => default folder to use, always an object, usually `this'";
set_task_perms(caller_perms());
return !this:mail_option("sticky") || this.current_folder && this;
