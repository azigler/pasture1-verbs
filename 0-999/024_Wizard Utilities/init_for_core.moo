#24:init_for_core   this none this rxd

if (caller_perms().wizard)
  pass(@args);
  `delete_property(this, "guest_feature_restricted") ! ANY';
  this.boot_exceptions = {};
  this.programmer_restricted = {};
  this.programmer_restricted_temp = {};
  this.chparent_restricted = {};
  this.rename_restricted = {};
  this.change_password_restricted = {};
  this.record_missed_help = 0;
  this.missed_help_counters = this.missed_help_strings = {};
  this.suicide_string = "You don't *really* want to commit suicide, do you?";
  this.wizards = {#2};
  this.next_perm_index = 1;
  this.system_chars = {$hacker, $no_one, $housekeeper};
  this.expiration_progress = $nothing;
  this.expiration_recipient = {#2};
endif
