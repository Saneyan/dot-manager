/**
 * Dot Manager (dmgr)
 *
 * Authors:   Saneyuki Tadokoro <saneyan@mail.gfunction.com>
 * Copyright: (c) 2014, Saneyuki Tadokoro
 */
module console.font;

immutable static struct Color
{
  string black;
  string blue;
  string green;
  string red;
}

immutable static struct Style
{
  string plain;
  string bold;
};

Color color = {
  black: "\x1B[0m",
  blue:  "\x1B[34m",
  green: "\x1B[32m",
  red:   "\x1B[31m"
};

Style style = {
  plain: "\033[0;0m",
  bold:  "\033[0;1m"
};
