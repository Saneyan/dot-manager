/**
 * Dot Manager (dmgr)
 *
 * Authors:   Saneyuki Tadokoro <saneyan@mail.gfunction.com>
 * Copyright: (c) 2014, Saneyuki Tadokoro
 */
module console.color;

enum palette : string
{
  black = "\x1B[0m",
  blue = "\x1B[34m",
  green = "\x1B[32m",
  red = "\x1B[31m"
};

enum font : string 
{
  plain = "\033[0;0m",
  bold = "\033[0;1m"
}
