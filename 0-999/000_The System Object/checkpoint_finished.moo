#0:checkpoint_finished   this none this rxd

callers() && raise(E_PERM);
$login.checkpoint_in_progress = 0;
`$local.checkpoint_notification:checkpoint_finished(@args) ! ANY';
