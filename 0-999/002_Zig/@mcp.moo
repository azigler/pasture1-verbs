#2:@mcp   any none none rd

if (!valid(who = player:my_match_object(dobjstr)))
  who = player;
endif
session = $mcp:session_for(who);
packages = session.packages;
player:tell("session: ", session);
player:tell("key: ", session.authentication_key);
for p in (packages)
  player:tell(p[1].name, " (", p[1], ") ", p[2][1], ".", p[2][2]);
endfor
player:tell("---");
