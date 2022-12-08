#6:wipe_replay   this none this rxd

this.last_replay_wipe = time();
for category in (mapkeys(this.replay_history))
  for message in (this.replay_history[category])
    if (abs(toint(message[1]) - time()) >= 3600)
      this.replay_history[category] = setremove(this.replay_history[category], message);
    endif
  endfor
endfor
"Last modified Thu Dec  8 09:08:58 2022 UTC by caranov (#133).";
