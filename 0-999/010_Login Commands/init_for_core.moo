#10:init_for_core   this none this rxd

if (caller_perms().wizard)
  this.current_lag = 0;
  this.lag_exemptions = {};
  this.max_connections = 99999;
  this.lag_samples = {0, 0, 0, 0, 0};
  this.print_lag = 0;
  this.last_lag_sample = 0;
  this.bogus_command = "?";
  this.blank_command = "welcome";
  this.create_enabled = 1;
  this.registration_address = "";
  this.registration_string = "Character creation is disabled.";
  this.newt_registration_string = "Your character is temporarily hosed.";
  this.welcome_message = {"Welcome to the LambdaCore database.", "", "Type 'connect wizard' to log in.", "", "You will probably want to change this text and the output of the `help' command, which are stored in $login.welcome_message and $login.help_message, respectively."};
  this.help_message = {"Sorry, but there's no help here yet.  Type `?' for a list of commands."};
  this.redlist = this.blacklist = this.graylist = this.spooflist = {{}, {}};
  this.temporary_redlist = this.temporary_blacklist = this.temporary_graylist = this.temporary_spooflist = {{}, {}};
  this.who_masks_wizards = 0;
  this.newted = this.temporary_newts = {};
  this.downtimes = {};
  this.current_numcommands = [];
  this.max_numcommands = 20;
  this.intercepted_players = this.intercepted_actions = {};
  this.name_lookup_players = {};
  if ("monitor" in properties(this))
    delete_property(this, "monitor");
  endif
  if ("monitor" in verbs(this))
    delete_verb(this, "monitor");
  endif
  if ("special_action" in verbs(this))
    set_verb_code(this, "special_action", {});
  endif
  pass(@args);
endif
