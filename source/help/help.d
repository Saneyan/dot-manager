/**
 * Dot Manager (dmgr)
 *
 * Authors:   Saneyuki Tadokoro, saneyan@mail.gfunction.com
 * Copyright: (c) 2014, Saneyuki Tadokoro
 */

module help.help;

import std.file;
import std.json;
import std.format;
import std.typecons;
import std.array;
import std.stdio;
import utils.array;
import dbg.spec;

private:

alias Tuple!(string, string[string]) Sect;
alias Appender!string Apndr;

public:

/**
 * HelpUsage class
 *
 * Describe command usage with associative arrays. The class can prints
 * the usage including command and option descriptions. The default application
 * version and version are defined depending on package.json.
 */
class HelpUsage
{
  /**
   * The package.json path.
   */
  static const infoPath = "../package.json";

  /**
   * Usage header.
   *
   * Examples:
   * // Appender!string writer;
   * // string appName, appVersion, commandName, subCommnadName;
   * formattedWrite(writer, appName, appVersion, commandName, subCommandName);
   * writeln(writer.data);
   *
   * Example of output:
   *
   *  * appName appVersion
   *  
   *  Usage: commandName subCommandName [option]
   */
  static const header = "\n * %s %s\n\nUsage: %s %s [option]";

  /**
   * Usage section.
   *
   * Examples:
   *  // Appender!string writer;
   *  // string title, item, value;
   *  formattedWrite(writer, title, [[item, value], ...]);
   *  writeln(writer.data);
   *
   * Example of output:
   *  title:
   *  item : value
   */
  static const section = "\n\n%s:\n%(  %-(%s : %)\n%)";

  /**
   * The command name.
   */
  string commandName = "dmgr";

  /**
   * The sub command name.
   */
  string subCommandName = "<command>";

  /**
   * The application name.
   */
  string appName;

  /**
   * The application version.
   */
  string appVersion;

  /**
   * The command descriptions.
   */
  string[string] commands;

  /**
   * The option descriptions.
   */
  string[string] options;

  /**
   * The class constructor.
   * Apply package info as default if empty props exist.
   */
  this()
  {
    JSONValue info = parseJSON(readText(infoPath));

    if (appName.empty)
      appName = info.object["name"].str;
    if (appVersion.empty)
      appVersion= info.object["version"].str;
  }

  /**
   * Print help usage.
   */
  void print()
  {
    Apndr doc = appender!string();

    // Write header of heredoc.
    formattedWrite(doc, header, appName, appVersion, commandName, subCommandName);
    // If the help usage includes some sections, append them to doc.
    writeSections(doc, tuple("Commands", commands), tuple("Options", options));

    writeln(doc.data);
  }

  /**
   * Write usage sections. At least one item list must be assigned. A section which has no
   * item list is ignored.
   *
   * Params:
   *  doc = The string writer.
   *  sections... = First elem must be section title, and second elem must be item list.
   *
   * Returns: The string writer.
   */
  private pure Apndr writeSections(Apndr doc, Sect[] sects...)
  {
    foreach (sect; sects) {
      string title = sect[0];
      string[string] items = sect[1];

      if (items.length > 0) {
        string[][] elems = HashExpander!(string[], (k, v) => [k, v])(items);
        formattedWrite(doc, section, title, elems);
      }
    }

    return doc;
  }
}

unittest
{
  Spec spec = new Spec(__MODULE__, __FILE__);

  spec.test((describe) {
    describe("Usage test", (it) {
      HelpUsage usage = new HelpUsage();

      usage.commands = [
        "command_1": "The first command.",
        "command_2": "The second command.",
        "command_3": "The third command."
      ];

      usage.options = [
        "-f": "The first option",
        "-s": "The second option",
        "-t": "The third option"
      ];

      it("should print help usage correctly.", {
        usage.print;
      });
    });
  });
}
