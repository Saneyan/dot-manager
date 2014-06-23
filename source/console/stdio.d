/**
 * Dot Manager (dmgr)
 *
 * Authors:   Saneyuki Tadokoro <saneyan@mail.gfunction.com>
 * Copyright: (c) 2014, Saneyuki Tadokoro
 */
module console.stdio;

import std.stdio;
import console.font;

pragma(msg, "Using: " ~ __MODULE__ ~ " (" ~ __FILE__ ~ ")");

/**
 * Add white space to string.
 *
 * Template params:
 *  num = The number of white space.
 *  A = Type of variable (AUTO)
 *
 * Params:
 *  str = A string.
 */
string indent(alias num, A)(A str)
{
  auto result = "";

  for (int i = 0; i < num; i++)
    result ~= " ";

  return result ~ str;
}

/**
 * Set font color or style or both.
 *
 * Params:
 *  fontconfig... = Font parameters.
 */
void fontset(string[] fontconfig...)
{
  writef("%-(%s%)", fontconfig);
}

/**
 * Reset default font color and style. The default values are configured
 * in console.font module.
 */
void reset()
{
  fontset(defaultColor, defaultStyle);
}

/**
 * Output string to the console with a font parameter.
 *
 * Template params:
 *  ffp = First font parameter. It should be color or style.
 *  A... = Argument types (AUTO).
 *
 * Params:
 *  args = Arguments for write function.
 */
void log(alias ffp, A...)(A args)
{
  fontset(ffp);
  args.write;
  reset;
}

/**
 * The function is similar to log template function but two template
 * arguments has. Two font parameters should have style or color.
 *
 * Template params:
 *  ffp = First font parameter.
 *  sfp = Second font parameter.
 *  A... = Argument types(AUTO).
 *
 * Params:
    args = Arguments for write function.
 */
void log(alias ffp, alias sfp, A...)(A args)
{
  fontset(ffp, sfp);
  args.write;
  reset;
}

/**
 * Output string and line break to the console with a font parameter.
 *
 * Template params:
 *  ffp = First font parameter. It shold be color or style.
 *  A... = Argument types (AUTO).
 *
 * Params:
*   args = Arguments for writeln function.
*/
void logln(alias ffp, A...)(A args)
{
  fontset(ffp);
  args.writeln;
  reset;
}

/**
 * The function is similar to logln template function but two template
 * arguments has. Two font parameters should have style or color.
 *
 * Template params:
 *  ffp = First font parameter.
 *  sfp = Second font parameter.
 *
 * Params:
 *  args = Arguments for writeln function.
 */
void logln(alias ffp, alias sfp, A...)(A args)
{
  fontset(ffp, sfp);
  args.writeln;
  reset;
}

void logf(alias fcolor, A...)(A args)
{
  fontset(fcolor);
  args.writef;
  reset;
}

void logf(alias fcolor, alias fstyle, A...)(A args)
{
  fontset(fcolor, fstyle);
  args.writef;
  reset;
}

void logfln(alias fcolor, A...)(A args)
{
  fontset(fcolor);
  args.writefln;
  reset;
}

void logfln(alias fcolor, alias fstyle, A...)(A args)
{
  fontset(fcolor, fstyle);
  args.writefln;
  reset;
}
