#2:@mcps   none none none rd

for p in (connected_players())
  session = $mcp:session_for(p);
  if (session:handles_package($mcp:match_package("mcp-negotiate")))
    player:tell(p.name);
  endif
endfor
player:tell("---");
