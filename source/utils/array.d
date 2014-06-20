/**
 * Dot Manager (dmgr)
 *
 * Authors:   Saneyuki Tadokoro (@Saneyan) <saneyan@mail.gfunction.com>
 * Copyright: (c) 2014, Saneyuki Tadokoro
 */

module utils.array;

import std.stdio;
import dbg.spec;

/**
 * Assign a key and value of each associative array element to an
 * anonymous function.
 *
 * Template params:
 *  T = Array of value type.
 *  lambda = An anonymous function.
 *  I = A function argument type.
 *
 * Function params:
 *  hash = Associative array.
 *
 * Returns: Expanded array.
 */
nothrow pure auto HashExpander(T, alias lambda, I)(I hash)
{
  int i = 0;
  T[] result = new T[hash.length];

  foreach (key; hash.keys)
    result[i++] = lambda(key, hash[key]);

  return result;
}

/**
 * Assign a key and value of each associative array element to an
 * anonymous function.
 *
 * Template params:
 *  T = Array of value type.
 *  lambda = An anonymous function which handles each array element.
 *  I = A function argument type.
 *
 * Function params:
 *  hash = Associative array.
 *
 * Returns: Transduced array.
 */
nothrow pure auto HashHandler(T, alias lambda, I)(I hash)
{
  T result;

  foreach (key; hash.keys) {
    T handled = lambda(key, hash[key]);
    foreach (hkey; handled.keys)
      result[hkey] = handled[hkey];
  }

  return result;
}

unittest
{
  Spec spec = new Spec(__MODULE__, __FILE__);

  spec.test((describe) {
    describe("Array test", (it) {
      it("should expand associative array", {
        assert(HashExpander!(string, (a, b) => a ~ ":" ~ b)(["key": "value"]) == ["key:value"]);
      });

      it("should transduce associative array", {
        assert(HashHandler!(string[string], (a, b) => [b: a])(["key": "value"]) == ["value" :"key"]);
      });
    });
  });
}
