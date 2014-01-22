/*
 * Dot Manager entry point.
 */

module main;
import std.stdio;
import std.c.stdlib;
import std.getopt;
import std.file;
import std.path;
import path;
import config;

private const string emsg = "See 'dmgr -h'.";
private const string usage = """ * Dot Manager v0.0.1

Usage: dmgr <command> [option]

Commands:
  link : Make symbolic links of dotfile
  repo : Operate repository of dotfiles
  type : Change dotfile type

Options:
  -l | --list-files : List available dotfiles
  -h | --help       : Show help""";

private void listFiles()
{
  auto files = dirEntries(DmgrPath.get("dotfiles", true), "*", SpanMode.depth, false);

  foreach (string file; files) {
    if (!ignore(file))
      writeln(file);
  }

  exit(0);
}

private void printUsage()
{
  writeln(usage);
  exit(0);
}

int main(string[] args)
{
  string[] argv = args.length <= 1 ? args ~ ["-h"] : args;

  try {
    getopt(
      argv,
      std.getopt.config.caseSensitive,
      std.getopt.config.noPassThrough,
      "l|list-files", &listFiles,
      "h|help", &printUsage);
  }
  catch (Exception e) {
    stderr.writef("dmgr: %s ", e.msg);
    stderr.writeln(emsg);
    exit(1);
  }

  const string cmd = argv[1];

  if (cmd == "link") {
    import link;
    linkMain(argv);
  } else if (cmd == "repo") {
    import repo;
    repoMain(argv);
  } else if (cmd == "type") {
    import type;
    typeMain(argv);
  } else {
    stderr.writef("dmgr: '%s' is not a dmgr command. ", cmd);
    stderr.writeln(emsg);
  }

  return 1;
}
