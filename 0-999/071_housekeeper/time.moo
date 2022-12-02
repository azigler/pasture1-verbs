#71:time   this none this rxd

"Returns the amount of time to suspend between objects while continuous cleaning.";
"Currently set to try to complete cleaning circuit in one hour, but not exceed one object every 20 seconds.";
return max(20 + $login:current_lag(), length(this.clean) ? 3600 / length(this.clean) | 0);
