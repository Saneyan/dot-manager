module path;
import std.path;
import std.regex;

public class DmgrPath
{
  public const string root = "~/.dmgr";

  private static string[][] tupleSrc = [
    ["dotfiles", "dotfiles"],
    ["config", "config/dmgr.conf.json"]
  ];

  public static string full(string path)
  {
    string withRoot = root ~ (match(path, `^/`).empty() ? "/" ~ path : path);
    return expandTilde(withRoot);
  }

  public static string get(string name, bool fill)
  {
    foreach (src; tupleSrc) {
      if (src[0] == name)
        return fill ? full(src[1]) : src[1];
    }

    return null;
  }

  public static string append(string path, string name, bool fill)
  {
    return get(name, fill) ~ (match(path, `^/`).empty() ? "/" ~ path : path);
  }
}
