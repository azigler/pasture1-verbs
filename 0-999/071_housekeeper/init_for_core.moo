#71:init_for_core   this none this rxd

if (caller_perms().wizard)
  this.password = "Impossible password to type";
  this.last_password_time = 0;
  this.litter = {};
  this.public_places = {};
  this.requestors = {};
  this.destination = {};
  this.clean = {};
  this.eschews = {};
  this.recycle_bins = {};
  this.cleaning = #-1;
  this.task = 0;
  this.owners = {#2};
  this.mail_forward = {#2};
  this.player_queue = {};
  this.move_player_task = 0;
  this.moveto_task = 0;
  pass(@args);
endif
