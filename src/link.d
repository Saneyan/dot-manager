module link;
import std.stdio;
import std.getopt;
import std.c.stdlib;

private const string usage = """ * Dot Manager - link command

Usage: link [option]

Options:
  -m | --make-sym-links : Make symbolic links of dotfiles
  -h | --help           : Show help""";

private void makeSymLinks()
{
  exit(0);
}

private void printUsage()
{
  writeln(usage);
  exit(0);
}

void linkMain(string[] args)
{
  string[] argv = args.length <= 2 ? args ~ ["-h"] : args;

  getopt(
    argv,
    std.getopt.config.caseSensitive,
    std.getopt.config.noPassThrough,
    "m|make-sym-links", &makeSymLinks,
    "h|help", &printUsage);

  exit(1);
}
