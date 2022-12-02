#104:initialize_connection   this none this rxd

"Usage:  :initialize_connection()";
"";
{version} = args;
connection = caller;
messages = $list_utils:slice(this.messages_in);
connection:register_handlers(messages);
