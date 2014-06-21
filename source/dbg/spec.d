/**
 * Dot Manager (dmgr)
 *
 * Authors:   Saneyuki Tadokoro <saneyan@mail.gfunction.com>
 * Copyright: (c) 2014, Saneyuki Tadokoro
 */
module dbg.spec;

import std.stdio;
import std.conv;
import console.font;

private:

alias void delegate() ItLambda;
alias void delegate(void delegate(string, ItLambda)) DescribeLambda;
alias void delegate(void delegate(string, DescribeLambda)) TestLambda;
// TestLambda type is same to:
// void delegate(void delegate(string, void delegate(void delegate(string, void delegate()))));

public:

/**
 * Spec class reports if each test expects correct result in unittest.
 */
class Spec
{
  private:

  /**
   * The module name.
   */
  string _mod;

  /**
   * The file name.
   */
  string _file;

  /**
   * Test count.
   */
  int _count = 0;

  /**
   * Failure count.
   */
  int _failure = 0;

  /**
   * Test a section and reports its result.
   *
   * Params:
   *  desc = Test description.
   *  lambda = Anonymous function which evaluate a test.
   */
  void it(string desc, ItLambda lambda)
  {
    _count++;

    try {
      lambda();
    } catch (Exception e) {
      _failure++;
    }
  }

  /*
   * Describe what test behaves.
   *
   * Params:
   *  desc = Behavioral description.
   *  lambda = Anonymous function which evaluate each tests.
   */
  void describe(string desc, DescribeLambda lambda)
  {
    lambda(&this.it);
  }

  public:

  /**
   * The spec class constructor.
   *
   * Params:
   *  mod = Module name.
   *  file = File name.
   */
  nothrow pure this(string mod, string file) @safe
  {
    _mod = mod; _file = file;
  }

  /**
   * Start whole evaluation.
   *
   * Params:
   *  lambda = Anonymous function which evaluate whole tests.
   */
  void test(TestLambda lambda)
  {
    lambda(&this.describe);

    if (_failure > 0)
      writef("%s%s[ %d of %d tests failed ] %s%s", style.bold, color.red, _failure, _count, style.plain, color.red);
    else
      writef("%s[ %d tests passed ] %s%s", color.green, _count, style.plain, color.green);

    writeln(_mod ~ " (" ~ _file ~ ")" ~ color.black);

    //☓✓
  }
}
