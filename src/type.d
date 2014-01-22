module type;
import std.stdio;
import std.c.stdlib;

const string usage = """ * Dot Manager (type command)

Usage: type [option]

type options:
  -c | --change : Change dotfile type
  -s | --show   : Show current type
  -h | --help   : Show help""";

static void typeMain(string[] args) {
  writeln("type:type");
  exit(0);
}
