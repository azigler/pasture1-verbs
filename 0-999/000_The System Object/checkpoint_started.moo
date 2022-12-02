#0:checkpoint_started   this none this rxd

callers() && raise(E_PERM);
$login.checkpoint_in_progress = 1;
`$local.checkpoint_notification:checkpoint_started(@args) ! ANY';
