#171:download   this none this rxd

"NOTE: This is the verb I use to download the json from another MOO. It's not used here, but I included it for completeness sake.";
"";
":download(STR <url> [, MAP <headers>, INT <include return headers>]) => LIST <data>";
"Download <url> using HTTP[S]. Optionally include <headers> as part of the request.";
"If <include return headers> is true, return headers are included in the return <data>.";
"Essentially this is an alternative to curl() because I'm too lazy to add server support for headers.";
{url, ?headers = [], ?return_headers = 0} = args;
"Separate the request from the URL.";
regex = "(?<protocol>http:\\/\\/|https:\\/\\/)?(?<host>[\\w\\.]+)(?<request>.+)?";
url = pcre_match(url, regex);
if (!url)
  raise(E_INVARG, "Invalid URL.");
else
  url = url[1];
endif
"Configure headers if we don't have some expected ones.";
if (!maphaskey(headers, "Connection:"))
  headers["Connection:"] = "close";
endif
tls = url["protocol"]["match"] != "" && url["protocol"]["match"][5] == "s";
connection = open_network_connection(url["host"]["match"], tls ? 443 | 80, ["tls" -> tls]);
notify(connection, tostr("GET ", url["request"]["match"] != "" ? url["request"]["match"] | "/", " HTTP/1.1"));
notify(connection, tostr("Host: ", url["host"]["match"]));
for value, key in (headers)
  notify(connection, tostr(key, " ", value));
endfor
notify(connection, "");
set_connection_option(connection, "hold-input", 1);
ret = {};
while (typeof(line = $network:read(connection)) != ERR)
  $command_utils:buffer();
  ret = {@ret, line};
endwhile
boot_player(connection);
return return_headers ? ret | ret["" in ret + 1..$];
