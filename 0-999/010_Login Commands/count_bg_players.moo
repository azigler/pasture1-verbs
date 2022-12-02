#10:count_bg_players   this none this rxd

caller_perms().wizard || $error:raise(E_PERM);
now = time();
tasks = queued_tasks();
sum = 0;
for t in (tasks)
  delay = t[2] - now;
  interval = delay <= 0 ? 1 | delay * 2;
  "SUM is measured in hundredths of a player for the moment...";
  delay <= 300 && (sum = sum + 2000 / interval);
endfor
count = sum / 100;
return count;
