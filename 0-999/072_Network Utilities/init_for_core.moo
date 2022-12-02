#72:init_for_core   this none this rxd

if (caller_perms().wizard)
  pass(@args);
  this.active = 0;
  this.errors_to_address = "moomailerrors@yourhost";
  this.site = "yoursite";
  this.postmaster = "postmastername@yourhost";
  this.usual_postmaster = "postmastername@yourhost";
  this.password_postmaster = "postmastername@yourhost";
  this.envelope_from = "postmastername@yourhost";
  this.blank_envelope = 0;
  this.MOO_name = "YourMOO";
  this.maildrop = "localhost";
  this.port = 7777;
  this.large_domains = {};
  this.trusts = {$hacker};
  this.connect_connections_to = {};
endif
