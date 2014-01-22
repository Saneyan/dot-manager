module repo;
import std.stdio;
import std.c.stdlib;

const string usage = """ * Dot Manager (update command)

Usage: update [option]

update options:
  -l | --pull : Pull repository
  -u | --push : Push commits of repository
  -h | --help : Show help""";

static void repoMain(string[] args) {
  writeln("repo");
  exit(0);
}
