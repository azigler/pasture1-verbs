#107:parse_mcp_continuation   this none this rxd

{data_tag, keyword, @rest} = args;
value = argstr[index(argstr, keyword) + length(keyword) + 1..$];
keyword = keyword[1..$ - 1];
return {"*", data_tag, keyword, value};
