/**
 * Dot Manager (dmgr)
 *
 * @author    Saneyuki Tadokoro (@Saneyan) <saneyan@mail.gfunction.com>
 * @copyright Copyright (c) 2014, Saneyuki Tadokoro
 * @module    Array
 */

module Array;

public:

template HashMap(auto lambda)
{
  auto hmap(auto assoc)
  {
    int i = 0;
    auto result = new auto[assoc.keys.length - 1];

    foreach (key; assoc.keys)
      result[i++] = lambda(key, assoc[key]);

    return result;
  }

  return &hmap;
}

unittest
{
  assert(HashMap!(a => a * a)(2) == 4);
}
