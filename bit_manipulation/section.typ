#import "../lib.typ": *

// TODO: Revisar página 'Bit Manipulation' de cp-algorithms y agregar lo que falte: https://cp-algorithms.com/algebra/bit-manipulation.html

= Bit Manipulation

== Bit mask
A _bit mask_ of the form `1 << k` has a one bit in position $k$ and all other bits are zero (zero-indexed from right to left). For `long long`, use `1LL << k`.

*Manipulating individual bits:*
/ `x | (1 << k)`: Sets the $k$th bit of `x` to one.
/ `x & ~(1 << k)`: Sets the $k$th bit of `x` to zero.
/ `x ^ (1 << k)`: Inverts the $k$th bit of `x`.

*Working with the rightmost 1-bit:*
/ `x & -x`: Isolates the rightmost set bit (keeps only the least significant bit that is 1, sets all others to 0).
/ `x & (x - 1)`: Removes the rightmost set bit from `x` (turns the rightmost 1 to 0).
/ `x | (x - 1)`: Sets all trailing zeros of `x` to 1.

*Creating useful bit masks:*
/ `(1 << n) - 1`: Creates a bit mask with the first $n$ bits set to 1.

*Common bit manipulation tricks:*
- A positive number `x` is a power of two exactly when `x & (x - 1) = 0`.
/ `x ^ A ^ B`: Determines which is not the current value of `x` between `A` and `B`.

*Bit operations as math alternatives:*
/ `x << k`: equivalent to `x * pow(2, k)`
/ `x >> k`: equivalent to `x / pow(2, k)` (integer division)
/ `x & ((1 << k) - 1)`: equivalent to `x % pow(2, k)`
/ `A + B`: equivalent to `(A ^ B) + 2 * (A & B)` or `(A | B) + (A & B)`

*GNU C++ compiler built-in functions:*
/ `__builtin_clz(x)`: the number of leading zeros (zeros on the left side of the bit representation).
/ `__builtin_ctz(x)`: the number of trailing zeros (zeros on the right side of the bit representation).
/ `__builtin_popcount(x)`: the number of ones in the bit representation.
/ `__builtin_parity(x)`: the parity (even or odd) of the number of ones in the bit representation.

#codly(header: [Example of use])
```
int x = 5328; // 00000000000000000001010011010000
cout << __builtin_clz(x) << "\n";     // 19
cout << __builtin_ctz(x) << "\n";     // 4
cout << __builtin_popcount(x) << "\n"; // 5
cout << __builtin_parity(x) << "\n";   // 1
```
#note-box[
    The above functions only support `int` numbers, but there are also `long long` versions of the functions available with the suffix `ll` (e.g. `__builtin_popcountll(x)`).
]

== Representing Sets
Every subset of a set ${0, 1, 2, . . . , n − 1}$ can be represented as an $n$ bit integer whose one bits indicate which elements belong to the subset.

#example[
    The bit representation of the set ${1, 3, 4, 8}$ is
  $ 00000000000000000000000100011010 $
]
#codly(header: [Prints the size of the set ${1, 3, 4, 8}$])
```
int x = 0;
x |= (1<<1);
x |= (1<<3);
x |= (1<<4);
x |= (1<<8);
cout << __builtin_popcount(x) << "\n"; // 4
```

#codly(header: [Prints all elements that belong to the set])
```
for (int i = 0; i < 32; i++) {
    if (x&(1<<i)) cout << i << " ";
}
// output: 1 3 4 8
```

/ Set operations:
  #align(
    center,
    table(
      columns: 3,
      align: left+horizon,
      table.header([*Operation*], [*Set syntax*], [*Bit syntax*]),
      [Intersection], [$a inter b$]      , [`a & b`],
      [Union]       , [$a union b$]      , [`a | b`],
      [Complement]  , [$overline(a)$]       , [`~a`],
      [Difference]  , [$a backslash b$] , [`a & (~b)`],
    )
  )
  
  #codly(header: [Goes through the subsets of ${0, 1, dots, n − 1}$])
  ```
  for (int b = 0; b < (1<<n); b++) {
      // process subset b
  }
  ```
  
  #codly(header: [Goes through the subsets with exactly $k$ elements])
  ```
  for (int b = 0; b < (1<<n); b++) {
      if (__builtin_popcount(b) == k) {
          // process subset b
      }
  }
  ```
  
  #codly(header: [Goes through the subsets of a set x])
  ```
  int b = 0;
  do {
      // process subset b
  } while (b=(b-x)&x);
  ```
  The idea is that the formula $b − x$ detects the rightmost one bit in $x$ that is zero in $b$. This bit becomes one and all bits after it become zero. Then the and operation ensures that the resulting value is a subset of $x$. Note that $b − x$ equals $−(x − b)$ so we can think that we first remove all one bits that appear in $b$ and then invert the value and add one.
/ C++ Bitsets: The `bitset` structure corresponds to an array whose each value is either 0 or 1.
  #codly(header: [Creates a bitset of 10 elements])
  ```
  bitset<10> s;
  s[1] = 1;
  s[3] = 1;
  s[4] = 1;
  s[7] = 1;
  cout << s[4] << "\n"; // 1
  cout << s[5] << "\n"; // 0
  ```
  #codly(header: [Returns the number of one bits in the bitset])
  ```
  cout << s.count() << "\n"; // 4
  ```
  #codly(header: [Bit operations can be directly used to manipulate bitsets])
  ```
  bitset<10> a, b;
  // ...
  bitset<10> c = a&b;
  bitset<10> d = a|b;
  bitset<10> e = a^b;
  ```
