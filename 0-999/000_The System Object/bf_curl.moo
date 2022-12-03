#0:bf_curl   this none this rxd

"Syntax:   curl(STR <url> [[, INT <include_headers> / MAP <options>][, MAP <options>]]) => STR";
"";
"By default, the curl builtin will download a webpage and return it as a string. ";
{url, ?include_headers = 0, ?options = []} = args;
for network_obj in ({$network, @children($network)})
  if (network_obj.site in url)
    return E_INVARG;
  endif
endfor
if (typeof(include_headers) == MAP && options == ([]))
  options = include_headers;
  include_headers = maphaskey(options, "include_headers") ? options["include_headers"] | 0;
endif
if (!maphaskey(options, "include_headers"))
  options["include_headers"] = include_headers;
endif
if (!maphaskey(options, "method"))
  options["method"] = "GET";
endif
if (!maphaskey(options, "tls"))
  options["tls"] = 0;
endif
if (!maphaskey(options, "payload"))
  options["payload"] = "";
endif
if (!maphaskey(options, "timeout"))
  options["timeout"] = 1;
endif
if (!maphaskey(options, "port"))
  if (options["tls"])
    options["port"] = 443;
  else
    options["port"] = 80;
  endif
  "TODO: allow custom ports in the url like GET";
  "if (length(exploded_url = $string_utils:explode(url, \":\")) > 2)";
  " options[\"port\"] = toint(exploded_url[$]);";
  "endif";
endif
if (!maphaskey(options, "content_type"))
  options["content_type"] = "application/json";
endif
if (options["method"] == "POST")
  "TODO: allow http:// and https:// like GET";
  "cleaned_url = $string_utils:explode(url, \"://\");";
  "if (length(cleaned_url) > 1)";
  " cleaned_url = $string_utils:from_list(cleaned_url[2..$]);";
  "else";
  " cleaned_url = url;";
  "endif";
  if (length(path = $string_utils:explode(url, "/")) > 1)
    url_hostname = path[1];
    path = "/" + $string_utils:from_list(path[2..$], "/");
  else
    path = "/";
    url_hostname = url;
  endif
  post = open_network_connection(url_hostname, options["port"], ["tls" -> options["tls"]]);
  content_length = value_bytes(options["payload"]) - value_bytes("");
  set_connection_option(post, "hold-input", 1);
  notify(post, "POST " + path + " HTTP/1.1");
  notify(post, "Host: " + url_hostname);
  notify(post, "Content-Type: " + tostr(options["content_type"]));
  notify(post, "Content-Length: " + tostr(content_length));
  notify(post, "");
  notify(post, options["payload"]);
  notify(post, "");
  headers = {};
  while reading (1)
    try
      headers = {@headers, read(post)};
      if (headers[$] == "")
        headers = headers[^..$ - 1];
        break reading;
      endif
    except error (ANY)
      return error[1];
    endtry
  endwhile
  if (!("401 Unauthorized" in headers[1]))
    try
      results = read(post);
      results = results:parse_json();
    except error (ANY)
      return error[1];
    endtry
  else
    results = {};
  endif
  include_headers = options["method"] == "HEAD" ? 1 | options["include_headers"];
  if (include_headers)
    return {headers, results};
  else
    return results;
  endif
elseif (options["method"] == "GET" || options["method"] == "HEAD")
  include_headers = options["method"] == "HEAD" ? 1 | options["include_headers"];
  results = curl(url, include_headers, options["timeout"]);
  if (typeof(results) == MAP)
    return results;
  else
    results = decode_binary(results);
  endif
  last_10_from_header = 0;
  while (13 in results && 10 in results)
    results = listdelete(results, 13 in results);
    last_10_from_header = 10 in results;
    results = listdelete(results, last_10_from_header);
  endwhile
  while (10 in results)
    results = listdelete(results, 10 in results);
  endwhile
  if (options["method"] == "GET")
    if (last_10_from_header)
      return {results[^..last_10_from_header - 1], $string_utils:from_list(results[last_10_from_header..$], " ")};
    else
      return $string_utils:from_list(results[^..$], " ");
    endif
  elseif (options["method"] == "HEAD")
    return results[^..last_10_from_header - 1];
  endif
endif
