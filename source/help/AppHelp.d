/**
 * Dot Manager (dmgr)
 *
 * @author    Saneyuki Tadokoro <saneyan@mail.gfunction.com>
 * @copyright Copyright (c) 2014, Saneyuki Tadokoro
 * @module    AppHelp
 */

module AppHelp;
import Help;

class AppHelpUsage : HelpUsage
{
  string[string] subCommands = [
    "enable"   : "Enable extensions",
    "disable"  : "Disable extensions",
    "edit"     : "Edit a configuration file",
    "install"  : "Install extensions",
    "uninstall": "Uninstall extensions",
    "update"   : "Update extensions"
  ];

  string[string] options = [
    "-l | --list-files": "List available extensions",
    "-h | --help"      : "Show help"
  ];
}
