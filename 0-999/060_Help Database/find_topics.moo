#60:find_topics   this none this rxd

topiclist = pass(@args);
if (topiclist || !args)
  return topiclist;
elseif (valid(o = $string_utils:match_object(what = args[1], player.location)))
  return {what};
else
  return {};
endif
