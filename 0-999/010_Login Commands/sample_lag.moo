#10:sample_lag   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
endif
lag = time() - this.last_lag_sample - 15;
this.lag_samples = {lag, @this.lag_samples[1..3]};
"Now compute the current lag and store it in a property, instead of computing it in :current_lag, which is called a hundred times a second.";
thislag = max(0, time() - this.last_lag_sample - this.lag_sample_interval);
if (thislag > 60 * 60)
  "more than an hour, probably the lag sampler stopped";
  this.current_lag = 0;
else
  samples = this.lag_samples;
  sum = 0;
  cnt = 0;
  for x in (listdelete(samples, 1))
    sum = sum + x;
    cnt = cnt + 1;
  endfor
  this.current_lag = max(thislag, samples[1], samples[2], sum / cnt);
endif
fork (15)
  this:sample_lag();
endfork
this.last_lag_sample = time();
