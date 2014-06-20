/**
 * Dot Manager (dmgr)
 *
 * Authors:   Saneyuki Tadokoro <saneyan@mail.gfunction.com>
 * Copyright: (c) 2014, Saneyuki Tadokoro
 */

module help.appHelp;

import help.help;

public HelpUsage usage;

static this()
{
  .usage = new HelpUsage();

  .usage.commands = [
    "enable"   : "Enable extensions",
    "disable"  : "Disable extensions",
    "edit"     : "Edit a configuration file",
    "install"  : "Install extensions",
    "uninstall": "Uninstall extensions",
    "update"   : "Update extensions"
  ];

  .usage.options = [
    "-l | --list-files": "List available extensions",
    "-h | --help"      : "Show help"
  ];
}
