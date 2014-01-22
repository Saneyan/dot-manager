module link;
import std.stdio;
import std.c.stdlib;

private const string usage = """ * Dot Manager - link command

Usage: link [option]

Options:
  -m | --make-sym-links : Make symbolic links of dotfiles
  -h | --help           : Show help""";

private void printUsage()
{
  writeln(usage);
}

public void linkMain(string[] args)
{
  exit(0);
}
