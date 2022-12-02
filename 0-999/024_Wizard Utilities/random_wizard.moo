#24:random_wizard   this none this rxd

"Put all your wizards in $wiz_utils.wizards.  Then various long-running tasks will cycle among the permissions, spreading out the scheduler-induced personal lag.";
w = this.wizards;
i = this.next_perm_index;
if (i >= length(w))
  i = 1;
else
  i = i + 1;
endif
this.next_perm_index = i;
return w[i];
