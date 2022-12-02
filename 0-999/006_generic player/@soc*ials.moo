#6:@soc*ials   any any any rxd

if (!args)
  player:tell("Available socials:");
  socials = {};
  for i in (mapkeys($socials.socials))
    socials = setadd(socials, i);
  endfor
  return player:tell_lines({@socials, tostr(socials:length()) + " total socials."});
else
  what = tostr(@args);
  player:tell("The following socials match to " + what + ":");
  socials = {};
  for i in ($socials:match_social(what, 1))
    socials = socials:add(i);
  endfor
  player:tell_lines({@socials, tostr(socials:length()) + " socials found."});
endif
