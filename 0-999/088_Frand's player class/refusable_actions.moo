#88:refusable_actions   this none this rxd

"'refusable_actions ()' -> {'page', 'whisper', ...} - Return a list of the actions that can be refused. This is a verb, rather than a property, so that it can be inherited properly. If you override this verb to add new refusable actions, write something like 'return {@pass (), 'action1', 'action2', ...}'. That way people can add new refusable actions at any level of the player class hierarchy, without clobbering any that were added higher up.";
return {"page", "whisper", "move", "join", "accept", "mail"};
