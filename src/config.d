module config;
import std.stdio;
import std.json;
import std.regex;
import std.file;
import std.path;
import path;

private JSONValue jval;
private string jtxt;

bool defaultIgnore(string file)
{
  return !match(file, `/\.git/`).empty();
}

bool ignore(string file)
{
  string confPath = DmgrPath.get("config", true);

  if (exists(confPath)) {
    if (jtxt.length == 0) {
      jtxt = readText(confPath);
      jval = parseJSON(jtxt);
    }

    foreach (ignore; jval.object["ignores"].array) {
      if (DmgrPath.append(ignore.str, "dotfiles", true) == file) {
        return true;
      }
    }
  }

  if (defaultIgnore(file))
    return true;

  return false;
}
