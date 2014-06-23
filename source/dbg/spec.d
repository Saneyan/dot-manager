/**
 * Dot Manager (dmgr)
 *
 * Authors:   Saneyuki Tadokoro <saneyan@mail.gfunction.com>
 * Copyright: (c) 2014, Saneyuki Tadokoro
 */
module dbg.spec;

import std.conv;
import core.exception;
import console.stdio;
import console.font;

pragma(msg, "Using: " ~ __MODULE__ ~ " (" ~ __FILE__ ~ ")");

private:

alias void delegate() ItLambda;
alias void delegate(void delegate(string, ItLambda)) DescribeLambda;
alias void delegate(void delegate(string, DescribeLambda)) TestLambda;

bool _started;

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

    logln!(color.green)(indent!(3)(desc));

    try {
      lambda();
    } catch (AssertError e) {
      // Increment failure count and report an error message.
      _failure++;
      logfln!(color.red)(indent!(3)("(error) %s\n"), e.msg);
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
    logln!(color.green)(indent!(1)(desc));
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
    if (!_started) {
      logln!(color.black)("\nStarting to test...\n");
      _started = true;
    }

    logfln!(color.blue)("> %s (%s)\n", _mod, _file,);

    lambda(&this.describe);

    // If an error occured, another test must be continued to find out whole process.
    if (_failure > 0)
      logfln!(style.bold, color.red)("\n × [ %d of %d tests failed ]\n", _failure, _count);
    else
      logfln!(color.green)("\n ✓ [ %d tests passed ]\n", _count);
  }
}
