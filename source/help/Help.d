/**
 * Dot Manager (dmgr)
 *
 * @author    Saneyuki Tadokoro (@Saneyan) <saneyan@mail.gfunction.com>
 * @copyright Copyright (c) 2014, Saneyuki Tadokoro
 * @module    Help
 */

module Help;

import std.file;
import std.json;
import std.format;
import std.typecons;
import std.exception;
import utils.Array;

public:

/**
 * HelpUsage class
 *
 * Describe command usage with associative arrays. The class can prints
 * the usage including command and option descriptions. The default application
 * version and version are defined depending on package.json.
 *
 * @package Help.HelpUsage
 */
class HelpUsage
{
  /**
   * The package.json path.
   *
   * @const infoPath
   */
  const infoPath = "./package.json";

  /**
   * Usage header.
   *
   * The format must be:
   *   ['name', 'version', 'commandName', 'subCommandName']
   *
   * @const header
   */
  const header = " * %s %s\n\nUsage: %s %s [option]";

  /**
   * Usage section.
   *
   * The format must be:
   *  ['title', ['item', 'value']]
   *
   * @const section
   */
  const section = "%s:\n %(%(%s\t:\t%)\n%)";

  /**
   * The command name.
   *
   * @var string commandName
   */
  immutable string commandName = "dmgr";

  /**
   * The sub command name.
   *
   * @var string subCommandName
   */
  immutable string subCommandName = "<command>";

  /**
   * The application name.
   *
   * @var string name
   */
  immutable string name;

  /**
   * The application version.
   *
   * @var string version
   */
  immutable string version;

  /**
   * The command descriptions.
   *
   * @var string[string] commands
   */
  immutable string[string] subCommands;

  /**
   * The option descriptions.
   *
   * @var string[string] options
   */
  immutable string[string] options;

  /**
   * The class constructor.
   * Apply package info as default if empty props exist.
   */
  this()
  {
    JSONValue info = parseJSON(readText(infoPath));

    if (name.empty) name = info["name"];
    if (version.empty) version = info["version"];
  }

  /**
   * Print help usage.
   *
   * @return void
   */
  void print()
  {
    auto doc = appender!string();

    // Write header of heredoc.
    formattedWrite(doc, docHeader, name, version, commandName, subCommandName);
    // If the help usage includes some sections, append them to doc.
    writeSections(doc, tuple("Commands", subCommands), tuple("Options", options));

    writeln(doc.data);
  }

  /**
   * Write usage sections. At least one item list must be assigned. A section which has no
   * item list is ignored.
   *
   * @param auto doc
   * @param Tuple!(string, string[string]) sections... : First elem must be section title,
   *                                                     and second elem must be item list.
   * @return auto
   */
  private auto writeSections(auto doc, Tuple!(string, string[string]) sections...)
  {
    foreach (section; sections) {
      string title = section[0];
      string[string] items = section[1];

      if (items.length > 0) {
        auto sec = appender!string();
        auto elems = HashMap!((k, v) => [k, v])(items);
        formattedWrite(sec, docSection, title, elems);
        auto doc ~= "\n\n" ~ sec;
      }
    }

    return doc;
  }
}

unittest
{
  Help help = new Help();
  help.print();
}
