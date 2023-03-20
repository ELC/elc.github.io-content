Title: Python Recursion: Head to Tail, mutual and nested
Date: 2022-10-25
Category: Programming 
Tags: Python, Functional Programming
Slug: functional-python
Authors: Ezequiel Leonardo Castaño 
Lang: en 
Headerimage: https://elc.github.io/blog/images/streamlit-lessons/streamlit-lessons_headerimage.png
Status: draft

[![Jupyter Publishing Header Image]({static}images/streamlit-lessons/streamlit-lessons_headerimage-thumbnail.png){: .b-lazy width=1444 data-src=/blog/images/streamlit-lessons/streamlit-lessons_headerimage.png }](/blog/images/streamlit-lessons/streamlit-lessons_headerimage.png)

<!-- PELICAN_BEGIN_SUMMARY -->

...

<!-- PELICAN_END_SUMMARY -->


## Disclaimer


Arity
Higher Order Functions
Closure
Partial Application
Currying
Function Composition
Pure Function
Side effects
Idempotent
Point-Free Style
Predicate
Referential Transparency

## Sidenote before deep diving

This article is heavily inspired by [Mike Vanier
post](https://mvanier.livejournal.com/2897.html), however examples there are
written in the Scheme programming language and this posts uses Python.
Moreover, the approach taken is different since it is mostly focused to
programmers that have little to no background on Functional Programming (FP)
concepts and focuses more on showing different FP concepts which ends in the Y
combinator, instead of using it to drive the narrative.

## An old friend

Many if not all programming courses introduce the factorial function at some
point. This function has great mathematical importance and yet it is simple
enough to showcase how recursion works. However, the approach towards this
function and recursion in general is superficial.

Starting from some common ground, the factorial function can be defined in a
non-recursive way with for loops or while loops.

### Sidenote

This post abuses the fact that, in Python, when a function defined multiple
times only the last definition is used for future references. There will be
many refinements over the definition and to avoid any confusion names will not
be changed to reflect that, they all do the same. To further reinforce this
idea, an assert statement will be added to show that results do not change even
if the definition changes.

```python
def factorial(n: int) -> int:
    """Factorial function implemented using for loops"""
    result = 1
    for i in range(1, n + 1):
        result *= i
    return result

assert [factorial(i) for i in range(7)] == [1, 1, 2, 6, 24, 120, 720]

def factorial(n: int) -> int:
    """Factorial function implemented using while loops"""
    result = 1
    multiplier = n
    while multiplier != 0:
        result *= multiplier
        multiplier -= 1
    return result

assert [factorial(i) for i in range(7)] == [1, 1, 2, 6, 24, 120, 720]
```

Between the for loop and the while loop implementation differences are clearly
visible. The for loop approach is usually the one found in many posts online,
it is short, uses only basic constructs and does the job. Whereas the while
approach uses one extra variable, that being said, both are valid.

Another possibility that is not as common is the functional implementation using
reduce:

```python
def factorial(n: int) -> int:
    """Factorial function implemented using reduce"""
    return reduce(lambda x, y: x * y, range(1, n + 1), 1)

assert [factorial(i) for i in range(7)] == [1, 1, 2, 6, 24, 120, 720]
```

Since the previous implementations are non-recursive, the [call
graph](https://en.wikipedia.org/wiki/Call_graph){: target="_blank"}  consists of
a single node:

[![Non Recursive Factorial Call Graph]({static}images/recursion/non_recursive_factorial-thumbnail.png){: .b-lazy width=554 data-src=/blog/images/recursion/non_recursive_factorial.png }](/blog/images/recursion/non_recursive_factorial.png)


## Recursion

After introducing one of the previous two definitions of factorials, the
"recursive form" is usually presented. A recursive function is a function that
calls itself. There are multiple types of recursion though and understanding
them may have a huge impact on some programming languages.


## Direct vs Indirect Recursion

Most commonly, when one says "recursive function", it is meant "direct recursive
function", that is, the function calls itself. The other way a function could be
recursive is through "indirect recursion" where, instead of calling itself, it
calls another function (or chain of functions) that will in turn call the first
function.

There are different types of direct recursions that are worth mentioning,
namely:

Based on where the recursive call is done:

- Head Recursion
- Middle Recursion
- Tail Recursion

Based on the number of recursive calls:

- Linear Recursion
- Multi Recursion (also called nonlinear or exponential recursion)
    - Tree Recursion (also called bifurcating recursion)
    - Nested Recursion
    - General Non-Linear Recursion

Based on the number of functions involved:

- Direct Recursion
- Indirect Recursion (also called mutual recursion)


## Linear Recursion

Linear recursion refers to functions where there is **only one recursive call**.

Based on the position of the recursive call it could be further subdivided into:

- Head Recursion: recursive call is the first statement.
- Middle Recursion: there are other statements before and after recursive call.
- Tail Recursion: recursive call is the last statement.

There is no difference between Middle Recursion and Head Recursion from an
efficiency and algorithmic perspective. So no further exploration will be done
on those two.

When a function has more than one recursive call is called Multi Recursion,
Nonlinear Recursion or Exponential Recursion.

The following is an example of a middle recursion implementation of the
factorial function.


```python
def factorial(n: int) -> int:
    if n == 0:
        return 1
    return n * factorial(n - 1)

assert [factorial(i) for i in range(7)] == [1, 1, 2, 6, 24, 120, 720]
```

It is middle recursion because the last statement is a multiplication (`*`) and
not the recursive call itself. Dependending on the operation order it could also
be considered head recursion but that difference is not relevant for most
contexts.

The call graph in the case of linear recursive functions is a series a nodes
called sequentially:

[![Recursive Factorial Call Graph]({static}images/recursion/recursive_factorial-thumbnail.png){: .b-lazy width=554 data-src=/blog/images/recursion/recursive_factorial.png }](/blog/images/recursion/recursive_factorial.png)


## Tail Recursion

Tail recursion is when the return statement of the function is **only a
recursive call**, this means that a function call could be replace with another
function call directly. Some languages (Python is not one of them), use a
technique named [Tail-Call
Optimization](https://en.wikipedia.org/wiki/Tail_call), which makes this
particular type of recursion very efficient.

One important clarification is that the return **must not be an expression**.

```python
def palindrome(string: str) -> bool:
    "Returns True if the given string is a palindrome. Using tail recursion."
    if len(string) < 2:
        return True

    first, *rest, last = string
    if first != last:
        return False
    return palindrome(rest)

assert palindrome("a")
assert palindrome("aa")
assert palindrome("aba")
assert not palindrome("abca")
assert palindrome("tattarrattat")
```

[![Recursive Palindrome]({static}images/recursion/recursive_palindrome-thumbnail.png){: .b-lazy width=1604 data-src=/blog/images/recursion/recursive_palindrome.png }](/blog/images/recursion/recursive_palindrome.png)

To better illustrate the fact that the returning statement must be **only a
function call**, the following implementation is **NOT** a tail recursive
function because the last statement is not a function call, it is a boolean
expression that requires the function call to be executed prior to returning
because the `and` operator needs the value. This implementation is then a middle
recursion.

```python
def palindrome(string: str) -> bool:
    "Returns True if the given string is a palindrome. Using middle recursion."
    if len(string) < 2:
        return True

    first, *rest, last = string
    return first == last and palindrome(rest)

assert palindrome("a")
assert palindrome("aa")
assert palindrome("aba")
assert not palindrome("abca")
```

Sometimes a function that is not expressed in tail-call form can be converted
to that form. For example the following middle recursion:

```python
def sum_integer_up_to_n(n: int) -> int:
    """Sums all integers from zero to n. Using middle recursion"""
    if n == 0:
        return 0
    
    return n + sum_integer_up_to_n(n - 1)

assert sum_integer_up_to_n(0) == 0
assert sum_integer_up_to_n(1) == 1
assert sum_integer_up_to_n(3) == 6
assert sum_integer_up_to_n(5) == 15
```

[![Recursive Sum Integer up to N]({static}images/recursion/recursive_sum_integer_up_to_n-thumbnail.png){: .b-lazy width=971 data-src=/blog/images/recursion/recursive_sum_integer_up_to_n.png }](/blog/images/recursion/recursive_sum_integer_up_to_n.png)

Can be rewritten into tail recursive form as:


```python
def sum_integer_up_to_n(n: int, total: int = 0) -> int:
    """Sums all integers from zero to n. Using Tail recursion"""
    if n == 0:
        return total

    return sum_integer_up_to_n(n - 1, total=n + total)

assert sum_integer_up_to_n(1) == 1
assert sum_integer_up_to_n(3) == 6
```

[![Recursive Sum Integer up to N]({static}images/recursion/tail_recursive_sum_integer_up_to_n-thumbnail.png){: .b-lazy width=1275 data-src=/blog/images/recursion/tail_recursive_sum_integer_up_to_n.png }](/blog/images/recursion/tail_recursive_sum_integer_up_to_n.png)


This last version uses an additional paramenter to pass the total down the call
chain. This compromises readability for performance if the language implements
tail-call optimization. This style of programming is widely used in languages
like Prolog. 

In Python however the extra parameter can be *hidden* by using
default values, this makes this modified implementation more similar to the
original but it is implicitly hidding the way it truly works, which is against
many coding styles. Use with caution.

In the same way as `sum_integer_up_to_n`, the factorial function could be
re-written into tail recursive form:

```python
def factorial(n: int, result: int = 1) -> int:
    if n == 0:
        return result

    return factorial(n - 1, n * result)

assert [factorial(i) for i in range(7)] == [1, 1, 2, 6, 24, 120, 720]
```

[![Recursive Sum Integer up to N]({static}images/recursion/tail_recursive_factorial-thumbnail.png){: .b-lazy width=704 data-src=/blog/images/recursion/tail_recursive_factorial.png }](/blog/images/recursion/tail_recursive_factorial.png)


When comparing head/middle and tail recursion, the way each approach works can be
illustrated by inspecting step by step: 

```python
# Head/Middle Recursion
factorial(3)
3 * factorial(3 - 1)
3 * factorial(2)
3 * 2 * factorial(2 - 1)
3 * 2 * factorial(1)
3 * 2 * 1 * factorial(1 - 1)
3 * 2 * 1 * factorial(0)
3 * 2 * 1 * 1
6
```

```python
# Tail Recursion
factorial(3)
factorial(3 - 1, 3 * 1)
factorial(2, 3)
factorial(2 - 1, 3 * 2)
factorial(1, 6)
factorial(1 - 1, 6 * 1)
factorial(0, 6)
6
```


## Multi Recursion

When there are more than one recursive call, a function is said to be multi
recursive. Multi recursive functions can also be middle/head recursive or tail
recursive. An special case of Multi Recursion is when the recursive call is one
of the arguments, in this case it is referred to as nested recursive.

## General Non Linear

Many functions do not follow a precise pattern and they just use multiple
recursive calls as part of their definition. One such example is the fibonacci
numbers, to call the function two successive recursive calls are used.

This is the traditional implementaiton of the fibonacci function that returns the nth fibonacci number:

```python
def fibonacci(n: int) -> int:
    if n == 0:
        return 0
    if n == 1:
        return 1
    return fibonacci(n-1) + fibonacci(n-2)

assert [fibonacci(i) for i in range(7)] == [0, 1, 1, 2, 3, 5, 8]
```

[![Recursive Sum Integer up to N]({static}images/recursion/recursive_fibonacci-thumbnail.png){: .b-lazy width=2750 data-src=/blog/images/recursion/recursive_fibonacci.png }](/blog/images/recursion/recursive_fibonacci.png)

In some cases, multi recursive functions can be refactor into linear tail
recursive functions.

```python
def fibonacci(n: int, partial_result: int = 0, result: int = 1) -> int:
    if n == 0:
        return 0
    if n == 1:
        return result
    return fibonacci(n-1, result, partial_result+result)

assert [fibonacci(i) for i in range(7)] == [0, 1, 1, 2, 3, 5, 8]
```

[![Recursive Sum Integer up to N]({static}images/recursion/tail_recursive_fibonacci-thumbnail.png){: .b-lazy width=729 data-src=/blog/images/recursion/tail_recursive_fibonacci.png }](/blog/images/recursion/tail_recursive_fibonacci.png)

## Tree Recursion

In the case of multi recursive functions, it is possible to construct a tree of
the function calls. All multi recursive functions produce a tree, however, in
some cases the definition leverages the divide-and-conquer strategy, minimizing
the depth of the tree. One example of this is the quicksort algorithm:

```python
def quicksort(numbers: list[float]) -> list[float]:
    if len(numbers) <= 1:
        return numbers

    first, *rest = numbers

    left = [x for x in rest if x < first]
    right = [x for x in rest if x >= first]
    return quicksort(left) + [first] + quicksort(right)

assert quicksort([2, 4, 3, 5, 0, 1]) == list(range(6))
assert quicksort(list(reversed(range(10)))) == list(range(10))
```

[![Recursive Sum Integer up to N]({static}images/recursion/recursive_quicksort-thumbnail.png){: .b-lazy width=2710 data-src=/blog/images/recursion/recursive_quicksort.png }](/blog/images/recursion/recursive_quicksort.png)

Here the function divides the input into two parts and each recursive call is
sent one of the parts. This strategy reduces the number of recursive calls.


## Converting non-tree recursion into tree recursion

Some functions that are originally linear recursive can be converted to tree
recursive to reduce the depth of the recursive stack. This is usually easy on
functions that operates on arrays.

Here is a linear recursive implementation of a function that returns the maximum
value of a list:

```python
def maximum(numbers: list[float]) -> float:
    first, *rest = numbers
    if not rest:
        return first

    rest_max = maximum(rest)
    return first if first > rest_max else rest_max

assert maximum([2, 4, 3, 5, 0, 1]) == 5
assert maximum(list(range(10))) == 9
```

[![Recursive Sum Integer up to N]({static}images/recursion/recursive_maximum-thumbnail.png){: .b-lazy width=1033 data-src=/blog/images/recursion/recursive_maximum.png }](/blog/images/recursion/recursive_maximum.png)

This function will have as many recursive calls as elements are in the list. A
similar approach as the quicksort algorithm can be used to reduce the number of
calls to a base two logarithm of the length of the list. The number of total
calls will be the same, however the recursive stack will be much shorter.

```python
def maximum(numbers: list[float]) -> float:
    first, *rest = numbers
    if not rest:
        return first

    middle = len(numbers) // 2
    left_max = maximum(numbers[:middle])
    right_max = maximum(numbers[middle:])
    return left_max if left_max > right_max else right_max

assert maximum([2, 4, 3, 5, 0, 1]) == 5
assert maximum(list(range(10))) == 9
```

[![Recursive Sum Integer up to N]({static}images/recursion/tree_recursive_maximum-thumbnail.png){: .b-lazy width=3260 data-src=/blog/images/recursion/tree_recursive_maximum.png }](/blog/images/recursion/tree_recursive_maximum.png)

This is not always possible, for functions like fibonacci, it is not trivial to
use a tree approach that reduces the number of recursive calls. A known solution
called Fast Doubling has been discovered, finding this implementation requires a
lot of effort and mathmatical derivaiton and may not be applicable to other
functions.

```python
def fibonacci(n):
    # Fast Doubling Method
    if n == 0:
        return 0
    if n == 1:
        return 1
    
    is_odd = n % 2
    m = n // 2 + is_odd
    fib_m = fibonacci(m)
    fib_m_1 = fibonacci(m - 1)

    if is_odd:
        return fib_m_1 ** 2 + fib_m ** 2
    return 2 * fib_m * fib_m_1 + fib_m ** 2

    
assert [fibonacci(i) for i in range(7)] == [0, 1, 1, 2, 3, 5, 8]
```

[![Recursive Sum Integer up to N]({static}images/recursion/fast_double_fibonacci-thumbnail.png){: .b-lazy width=1508 data-src=/blog/images/recursion/fast_double_fibonacci.png }](/blog/images/recursion/fast_double_fibonacci.png)

It is even possible to further reduce the number of recursive calls by
converting the multi recursive function into a linear recursive function by
changing its structure to return two values at once:

```python
def fibonacci(n):
    # based on: https://www.nayuki.io/page/fast-fibonacci-algorithms
    def nth_and_nth_plus_one(n):
        if n == 0:
            return 0, 1
        a, b = nth_and_nth_plus_one(n // 2)
        c = a * b * 2 - a ** 2
        d = a ** 2 + b ** 2
        nth, nth_plus_one = (c, d) if n % 2 == 0 else (d, c + d)
        return nth, nth_plus_one
    
    nth, _ = nth_and_nth_plus_one(n)
    return nth

assert [fibonacci(i) for i in range(7)] == [0, 1, 1, 2, 3, 5, 8]
```

[![Recursive Sum Integer up to N]({static}images/recursion/efficient_recursive_fibonacci-thumbnail.png){: .b-lazy width=1004 data-src=/blog/images/recursion/efficient_recursive_fibonacci.png }](/blog/images/recursion/efficient_recursive_fibonacci.png)

## Nested Recursion

One special case of multi recursion is when the argument of the recursive call
is itself a recursive call. This is not usual in software development but could
arise in mathmatical fields. One example is the Hofstadter G Sequence:

```python
def hofstadter_g(n: int) -> int:
    if n == 0:
        return 0
    return n - hofstadter_g(hofstadter_g(n - 1))

assert [hofstadter_g(i) for i in range(7)] == [0, 1, 1, 2, 3, 3, 4]
```

[![Recursive Hofstadter G]({static}images/recursion/recursive_hofstadter_g-thumbnail.png){: .b-lazy width=3702 data-src=/blog/images/recursion/recursive_hofstadter_g.png }](/blog/images/recursion/recursive_hofstadter_g.png)

Refactoring nested recursion into non-nested multi recursion or linear recursion
is a non-trivial task and sometimes it may be impossible.

## Triple Nested Recursion

The level of nesting is not limited to just two calls, the Hofstadter H Sequence
has triple nesting recursion for example:

```python
def hofstadter_h(n: int) -> int:
    if n == 0:
        return 0
    return n - hofstadter_h(hofstadter_h(hofstadter_h(n - 1)))

assert [hofstadter_h(i) for i in range(7)] ==  [0, 1, 1, 2, 3, 4, 4]
```

[![Recursive Hofstadter H]({static}images/recursion/recursive_hofstadter_h-thumbnail.png){: .b-lazy width=9794 data-src=/blog/images/recursion/recursive_hofstadter_h.png }](/blog/images/recursion/recursive_hofstadter_h.png)


## Nested Recursion with more than one argument

Some functions can have multiple arguments and be nested recursive. The
Ackermann function grows extremely fast due to this nested recursive definition
and it is the simplest functions proved not to be primitive recursive, meaning
that it cannot be expressed in iterative form with for loops.

This functions is currently used to test compilers efficiency at handling really
deep recursive functions. This is a case of a nested recursive function that is
also tail recursive.

```python
def ackermann(m, n):
    if m == 0:
        return n + 1
    if m > 0 and n == 0:
        return ackermann(m - 1, 1)    
    return ackermann(m - 1, ackermann(m, n - 1))

assert [ackermann(i, j) for i in range(4) for j in range(4)] == [1, 2, 3, 4, 2, 3, 4, 5, 3, 5, 7, 9, 5, 13, 29, 61]
```

[![Recursive Ackerman]({static}images/recursion/recursive_ackermann-thumbnail.png){: .b-lazy width=6185 data-src=/blog/images/recursion/recursive_ackermann.png }](/blog/images/recursion/recursive_ackermann.png)

## Indirect Recursion

So far, all the examples showed functions that called themselves, this is direct
recursion. An alternative approach is indirect recursion, also known as mutual
recursion. In this case the same categories could be applied (linear, tail,
head, nested, etc.), but a recursive call now may be the same function or other
function, with the condition that the other function must also be mutually
recursive.

## Mutual Linear Recursion

A simple example of mutual linear tail recursion is a set of functions that
determines if a number is odd or even:  

```python
def is_even(n: int) -> bool:
    if n == 0:
        return True
    return is_odd(n - 1)

def is_odd(n: int) -> bool:
    if n == 0:
        return False
    return is_even(n - 1)

assert [is_even(i) for i in range(6)] == [True, False, True, False, True, False]
assert [is_odd(i) for i in range(6)] == [False, True, False, True, False, True]
```

[![Recursive Is Even]({static}images/recursion/recursive_is_even-thumbnail.png){: .b-lazy width=538 data-src=/blog/images/recursion/recursive_is_even.png }](/blog/images/recursion/recursive_is_even.png)

Of course it is also possible to implement a function that computes the same in
a non recursive form, however, this example does not require division or modulo
computation, it is much slower thougn for big numbers.


## Mutual Multi Recursion

Mutual recursion can also happen in multi recursive functions. Take the
following direct multi recursive function that computes the nth lucas number:

```python
def lucas(n: int) -> int:
    if n == 0:
        return 2
    if n == 1:
        return 1
    return lucas(n-1) + lucas(n-2)

assert [lucas(i) for i in range(7)] == [2, 1, 3, 4, 7, 11, 18]
```

[![Recursive Lucas]({static}images/recursion/recursive_lucas-thumbnail.png){: .b-lazy width=2225 data-src=/blog/images/recursion/recursive_lucas.png }](/blog/images/recursion/recursive_lucas.png)

It is possible to write both the lucas and the fibonacci functions in a mutual
recursive form:

```python
def lucas(n: int) -> int:
    if n == 0:
        return 2
    if n == 1:
        return 1
    return 2 * fibonacci(n) - fibonacci(n-1) + lucas(n-2)


def fibonacci(n: int) -> int:
    if n == 0:
        return 0
    if n == 1:
        return 1
    return (fibonacci(n-1) + lucas(n-1)) // 2

assert [lucas(i) for i in range(7)] == [2, 1, 3, 4, 7, 11, 18]

assert [fibonacci(i) for i in range(7)] == [0, 1, 1, 2, 3, 5, 8]
```

[![Mutual Recursive Fibonacci]({static}images/recursion/mutual_recursive_fibonacci-thumbnail.png){: .b-lazy width=5365 data-src=/blog/images/recursion/mutual_recursive_fibonacci.png }](/blog/images/recursion/mutual_recursive_fibonacci.png)

This implementation is standalone and does not require any of the two funtions
to be defined in a direct recursive way. In practical terms, there is no gain as
it makes the whole computation slower and less efficient, it is just for
demonstration purposes.


Similarly, the sequence defined as the multiplication of the last two terms can
be implemented in a direct multi recursive form:


```python
def multiply_last_two(n: int) -> int:
    if n == 0:
        return 1
    if n == 1:
        return 2
    return multiply_last_two(n - 1) * multiply_last_two(n - 2)


assert [multiply_last_two(i) for i in range(7)] == [1, 2, 2, 4, 8, 32, 256]
```

[![Mutual Recursive Fibonacci]({static}images/recursion/recursive_multiply_last_two-thumbnail.png){: .b-lazy width=3988 data-src=/blog/images/recursion/recursive_multiply_last_two.png }](/blog/images/recursion/recursive_multiply_last_two.png)

This again can be used to implement the fibonacci and the multiply last two as
mutually recursive functions.

```python
import math

def fibonacci(n: int) -> int:
    if n == 0:
        return 0
    if n == 1:
        return 1
    return int(math.log2(multiply_last_two(n - 1) * multiply_last_two(n - 2)))

def multiply_last_two(n: int) -> int:
    if n == 0:
        return 1
    if n == 1:
        return 2
    return 2 ** (fibonacci(n-1) + fibonacci(n-2))


assert [fibonacci(i) for i in range(7)] == [0, 1, 1, 2, 3, 5, 8]
assert [multiply_last_two(i) for i in range(7)] == [1, 2, 2, 4, 8, 32, 256]
```

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/mutual_recursive_fibonacci_alternative-thumbnail.png){: .b-lazy width=3163 data-src=/blog/images/recursion/mutual_recursive_fibonacci_alternative.png }](/blog/images/recursion/mutual_recursive_fibonacci_alternative.png)

## Mutual Mested Recursion

Mutual recursion can also appear in nested form, as it is the case of the
Hofstadter Female and Male sequences which are mutual nested recursive.

```python
def hofstadter_female(n: int) -> int:
    if n == 0:
        return 1
    return n - hofstadter_male(hofstadter_female(n - 1))

def hofstadter_male(n: int) -> int:
    if n == 0:
        return 0
    return n - hofstadter_female(hofstadter_male(n - 1))

assert [hofstadter_female(i) for i in range(7)] == [1, 1, 2, 2, 3, 3, 4]
assert [hofstadter_male(i) for i in range(7)] == [0, 0, 1, 2, 2, 3, 4]
```

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/mutual_recursive_hofstadter_female-thumbnail.png){: .b-lazy width=5290 data-src=/blog/images/recursion/mutual_recursive_hofstadter_female.png }](/blog/images/recursion/mutual_recursive_hofstadter_female.png)

## Mutual Triple Recursion

Indirect recursion is not limited to only two functions, the following example
combines the lucas, fibonacci and multiply last two functions in a triple mutual
recursive form, where each function uses at the other two and itself.

```python
# Mutual Nonlineal bifurcating Triple Recursion

import math

def lucas(n: int) -> int:
    if n == 0:
        return 2
    if n == 1:
        return 1
    return 2 * math.log2(multiply_last_two(n - 1) * multiply_last_two(n - 2)) - fibonacci(n-1) + lucas(n-2)


def fibonacci(n: int) -> int:
    if n == 0:
        return 0
    if n == 1:
        return 1
    return (fibonacci(n-1) + lucas(n-1)) // 2


def multiply_last_two(n: int) -> int:
    if n == 0:
        return 1
    if n == 1:
        return 2
    return 2 ** (1.5 * fibonacci(n-2) + 0.5 * lucas(n-2))


assert [lucas(i) for i in range(7)] == [2, 1, 3, 4, 7, 11, 18]

assert [fibonacci(i) for i in range(7)] == [0, 1, 1, 2, 3, 5, 8]

assert [multiply_last_two(i) for i in range(7)] == [1, 2, 2, 4, 8, 32, 256]
```

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/mutual_triple_recursive_fibonacci-thumbnail.png){: .b-lazy width=6969 data-src=/blog/images/recursion/mutual_triple_recursive_fibonacci.png }](/blog/images/recursion/mutual_triple_recursive_fibonacci.png)


## Recursion related techniques

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/recursive_non_memoized_fibonacci-thumbnail.png){: .b-lazy width=4106 data-src=/blog/images/recursion/recursive_non_memoized_fibonacci.png }](/blog/images/recursion/recursive_non_memoized_fibonacci.png)

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/recursive_memoized_fibonacci-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/recursive_memoized_fibonacci.png }](/blog/images/recursion/recursive_memoized_fibonacci.png)



[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/non_memoized_fast_double_fibonacci-thumbnail.png){: .b-lazy width=4106 data-src=/blog/images/recursion/non_memoized_fast_double_fibonacci.png }](/blog/images/recursion/non_memoized_fast_double_fibonacci.png)

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_fast_double_fibonacci-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_fast_double_fibonacci.png }](/blog/images/recursion/memoized_fast_double_fibonacci.png)



[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/non_memoized_hofstadter_g-thumbnail.png){: .b-lazy width=4106 data-src=/blog/images/recursion/non_memoized_hofstadter_g.png }](/blog/images/recursion/non_memoized_hofstadter_g.png)

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_hofstadter_g-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_hofstadter_g.png }](/blog/images/recursion/memoized_hofstadter_g.png)


[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_hofstadter_h-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_hofstadter_h.png }](/blog/images/recursion/memoized_hofstadter_h.png)

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_ackermann-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_ackermann.png }](/blog/images/recursion/memoized_ackermann.png)

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_mutual_recursive_fibonacci-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_mutual_recursive_fibonacci.png }](/blog/images/recursion/memoized_mutual_recursive_fibonacci.png)

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_hofstadter_female-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_hofstadter_female.png }](/blog/images/recursion/memoized_hofstadter_female.png)

## Memoization

## Trampoline








































```python
# Traditional Recursive Form
def factorial(n):
    if n == 0:
        return 1
    
    return n * factorial(n - 1)

assert factorial(6) == 720
```
# factorial(3)
# 3 * factorial(3 - 1)
# 3 * factorial(2)
# 3 * 2 * factorial(2 - 1)
# 3 * 2 * factorial(1)
# 3 * 2 * 1 * factorial(1 - 1)
# 3 * 2 * 1 * factorial(0)
# 3 * 2 * 1 * 1
```python
# Remove direct recursion using mutual recursion
def aux(n):
    return factorial(n)

def factorial(n):
    if n == 0:
        return 1
    
    return n * aux(n - 1)

assert factorial(6) == 720
```
# factorial(3)
# 3 * aux(3 - 1)
# 3 * aux(2)
# 3 * factorial(2)
# 3 * 2 * aux(2 - 1)
# 3 * 2 * aux(1)
# 3 * 2 * factorial(1)
# 3 * 2 * 1 * aux(1 - 1)
# 3 * 2 * 1 * aux(0)
# 3 * 2 * 1 * factorial(0)
# 3 * 2 * 1 * 1

```python
# Remove hardcoded references in aux
def aux(f, n):
    return f(n)

def factorial(n):
    if n == 0:
        return 1
    
    return n * aux(factorial, n - 1)

assert factorial(6) == 720
```

# factorial(3)
# 3 * aux(factorial, 3 - 1)
# 3 * aux(factorial, 2)
# 3 * factorial(2)
# 3 * 2 * aux(factorial, 2 - 1)
# 3 * 2 * aux(factorial, 1)
# 3 * 2 * factorial(1)
# 3 * 2 * 1 * aux(factorial, 1 - 1)
# 3 * 2 * 1 * aux(factorial, 0)
# 3 * 2 * 1 * factorial(0)
# 3 * 2 * 1 * 1

```python
# Remove hardcoded references in factorial
def aux(f, n):
    return f(f, n)


def factorial(f, n):
    if n == 0:
        return 1
    
    return n * f(f, n - 1)

assert aux(factorial, 6) == 720
```

# aux(factorial, 3)
# factorial(factorial, 3)
# 3 * factorial(factorial, 3 - 1)
# 3 * factorial(factorial, 2)
# 3 * 2 * factorial(factorial, 2 - 1)
# 3 * 2 * factorial(factorial, 1)
# 3 * 2 * 1 * factorial(factorial, 1 - 1)
# 3 * 2 * 1 * factorial(factorial, 0)
# 3 * 2 * 1 * 1

```python
# Change to single parameter form
def aux(f):
    def aux_2(n):
        return f(aux_2)(n)
    return aux_2

def factorial(f):
    def factorial_step(n):
        if n == 0:
            return 1
        
        return n * f(n - 1)
    return factorial_step

assert aux(factorial)(6) == 720
```
# aux(factorial)(3)
# aux_2(3)
# factorial(aux_2)(3)
# factorial_step(3)
# 3 * aux_2(3 - 1)
# 3 * aux_2(2)
# 3 * factorial(aux_2)(2)
# 3 * factorial_step(2)
# 3 * 2 * aux_2(2 - 1)
# 3 * 2 * aux_2(1)
# 3 * 2 * factorial(aux_2)(1)
# 3 * 2 * factorial_step(1)
# 3 * 2 * 1 * aux_2(1 - 1)
# 3 * 2 * 1 * aux_2(0)
# 3 * 2 * 1 * factorial(aux_2)(0)
# 3 * 2 * 1 * factorial_step(0)
# 3 * 2 * 1 * 1

```python
# Remove recursion from aux_2

def aux(f-factorial):
    def aux_3(f_2=aux_3):
        def aux_2(n):
            return f_2(f_2)(n)
        return f(aux_2)
    return aux_3(aux_3)

def factorial(f):
    def factorial_step(n):
        if n == 0:
            return 1
        
        return n * f(n - 1)
    return factorial_step

assert aux(factorial)(6) == 720
```

# aux(factorial)(3)
# aux_3(aux_3)(3)
# factorial(aux_2)(3)
# factorial_step(3)
# 3 * aux_2(3 - 1)
# 3 * aux_2(2)
# 3 * aux_3(aux_3)(2)
# 3 * factorial(aux_2)(2)
# 3 * factorial_step(2)
# 3 * 2 * aux_2(2 - 1)
# 3 * 2 * aux_2(1)
# 3 * 2 * aux_3(aux_3)(1)
# 3 * 2 * factorial(aux_2)(1)
# 3 * 2 * factorial_step(1)
# 3 * 2 * 1 * aux_2(1 - 1)
# 3 * 2 * 1 * aux_2(0)
# 3 * 2 * 1 * aux_3(aux_3)(0)
# 3 * 2 * 1 * factorial(aux_2)(0)
# 3 * 2 * 1 * factorial_step(0)
# 3 * 2 * 1 * 1

```python
# Change factorial_step into lambda form

def aux(f):
    def aux_3(f_2):
        def aux_2(n):
            return f_2(f_2)(n)
        return f(aux_2)
    return aux_3(aux_3)

def factorial(f):
    return lambda n: 1 if n == 0 else n * f(n-1)

assert aux(factorial)(6) == 720
```
# aux(factorial)(3)
# aux_3(aux_3)(3)
# factorial(aux_2)(3)
# (lambda n: 1 if n == 0 else n * aux_2(n-1))(3)
# 3 * aux_2(3 - 1)
# 3 * aux_2(2)
# 3 * aux_3(aux_3)(2)
# 3 * factorial(aux_2)(2)
# 3 * (lambda n: 1 if n == 0 else n * aux_2(n-1))(2)
# 3 * 2 * aux_2(2 - 1)
# 3 * 2 * aux_2(1)
# 3 * 2 * aux_3(aux_3)(1)
# 3 * 2 * factorial(aux_2)(1)
# 3 * 2 * (lambda n: 1 if n == 0 else n * aux_2(n-1))(1)
# 3 * 2 * 1 * aux_2(1 - 1)
# 3 * 2 * 1 * aux_2(0)
# 3 * 2 * 1 * aux_3(aux_3)(0)
# 3 * 2 * 1 * factorial(aux_2)(0)
# 3 * 2 * 1 * (lambda n: 1 if n == 0 else n * aux_2(n-1))(0)
# 3 * 2 * 1 * 1

```python
# Change factorial into lambda form

def aux(f):
    def aux_3(f_2):
        def aux_2(n):
            return f_2(f_2)(n)
        return f(aux_2)
    return aux_3(aux_3)

factorial = lambda f: lambda n: 1 if n == 0 else n * f(n-1)

assert aux(factorial)(6) == 720
```
# aux(factorial)(3)
# aux(lambda f: lambda n: 1 if n == 0 else n * f(n-1))(3)
# aux_3(aux_3)(3)
# (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(aux_2)(3)
# (lambda n: 1 if n == 0 else n * aux_2(n-1))(3)
# 3 * aux_2(3 - 1)
# 3 * aux_2(2)
# 3 * aux_3(aux_3)(2)
# 3 * (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(aux_2)(2)
# 3 * (lambda n: 1 if n == 0 else n * aux_2(n-1))2)
# 3 * 2 * aux_2(2 - 1)
# 3 * 2 * aux_2(1)
# 3 * 2 * aux_3(aux_3)(1)
# 3 * 2 * (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(aux_2)(1)
# 3 * 2 * (lambda n: 1 if n == 0 else n * aux_2(n-1))(1)
# 3 * 2 * 1 * aux_2(1 - 1)
# 3 * 2 * 1 * aux_2(0)
# 3 * 2 * 1 * aux_3(aux_3)(0)
# 3 * 2 * 1 * (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(aux_2)(0)
# 3 * 2 * 1 * (lambda n: 1 if n == 0 else n * aux_2(n-1))(0)
# 3 * 2 * 1 * 1

```python
# Change aux_2 into lambda form
def aux(f):
    def aux_3(f_2):
        return f(lambda n: f_2(f_2)(n))
    return aux_3(aux_3)

factorial = lambda f: lambda n: 1 if n == 0 else n * f(n-1)

assert aux(factorial)(6) == 720
```

# aux(factorial)(3)
# aux(lambda f: lambda n: 1 if n == 0 else n * f(n-1))(3)
# aux_3(aux_3)(3)
# (lambda f: lambda n: 1 if n == 0 else n * f(n-1))((lambda n: aux_3(aux_3)(n)))(3)
# (lambda n: 1 if n == 0 else n * (lambda n: aux_3(aux_3)(n))(n-1))(3)
# 3 * (lambda n: aux_3(aux_3)(n))(3 - 1)
# 3 * (lambda n: aux_3(aux_3)(n))(2)
# 3 * aux_3(aux_3)(2)
# 3 * (lambda f: lambda n: 1 if n == 0 else n * f(n-1))((lambda n: aux_3(aux_3)(n)))(2)
# 3 * (lambda n: 1 if n == 0 else n * (lambda n: aux_3(aux_3)(n))(n-1))(2)
# 3 * 2 * (lambda n: aux_3(aux_3)(n))(2 - 1)
# 3 * 2 * (lambda n: aux_3(aux_3)(n))(1)
# 3 * 2 * aux_3(aux_3)(1)
# 3 * 2 * (lambda f: lambda n: 1 if n == 0 else n * f(n-1))((lambda n: aux_3(aux_3)(n)))(1)
# 3 * 2 * (lambda n: 1 if n == 0 else n * (lambda n: aux_3(aux_3)(n))(n-1))(1)
# 3 * 2 * 1 * (lambda n: aux_3(aux_3)(n))(1 - 1)
# 3 * 2 * 1 * (lambda n: aux_3(aux_3)(n))(0)
# 3 * 2 * 1 * aux_3(aux_3)(0)
# 3 * 2 * 1 * (lambda f: lambda n: 1 if n == 0 else n * f(n-1))((lambda n: aux_3(aux_3)(n)))(0)
# 3 * 2 * 1 * (lambda n: 1 if n == 0 else n * (lambda n: aux_3(aux_3)(n))(n-1))(0)
# 3 * 2 * 1 * 1

```python
# Change aux_3 into lambda form
def aux(f):
    aux_3 = lambda f_2: f(lambda n: f_2(f_2)(n))
    return aux_3(aux_3)

factorial = lambda f: lambda n: 1 if n == 0 else n * f(n-1)

assert aux(factorial)(6) == 720
```
# aux(factorial)(3)
# aux(lambda f: lambda n: 1 if n == 0 else n * f(n-1))(3)
# aux_3(aux_3)(3)
# (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))(lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))(3)
# (lambda f: lambda n: 1 if n == 0 else n * f(n-1))((lambda n: (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))((lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n))))(n)))(3)
# (lambda n: 1 if n == 0 else n * (lambda n: (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))((lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n))))(n))(n-1))(3)
# 3 * (lambda n: (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))((lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n))))(n))(3 - 1)
# 3 * (lambda n: (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))((lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n))))(n))(2)
# 3 * (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))((lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n))))(2)
# 3 * (lambda f: lambda n: 1 if n == 0 else n * f(n-1))((lambda n: (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))((lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n))))(n)))(2)
# 3 * (lambda n: 1 if n == 0 else n * (lambda n: (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))((lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n))))(n))(n-1))(2)
# 3 * 2 * (lambda n: (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))((lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n))))(n))(2 - 1)
# 3 * 2 * (lambda n: (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))((lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n))))(n))(1)
# 3 * 2 * (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))((lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n))))(1)
# 3 * 2 * (lambda f: lambda n: 1 if n == 0 else n * f(n-1))((lambda n: (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))((lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n))))(n)))(1)
# 3 * 2 * (lambda n: 1 if n == 0 else n * (lambda n: (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))((lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n))))(n))(n-1))(1)
# 3 * 2 * 1 * (lambda n: (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))((lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n))))(n))(1 - 1)
# 3 * 2 * 1 * (lambda n: (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))((lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n))))(n))(0)
# 3 * 2 * 1 * (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))((lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n))))(0)
# 3 * 2 * 1 * (lambda f: lambda n: 1 if n == 0 else n * f(n-1))((lambda n: (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))((lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n))))(n)))(0)
# 3 * 2 * 1 * (lambda n: 1 if n == 0 else n * (lambda n: (lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n)))((lambda f_2: (lambda f: lambda n: 1 if n == 0 else n * f(n-1))(lambda n: f_2(f_2)(n))))(n))(n-1))(0)
# 3 * 2 * 1 * 1

```python
# Remove named references
def aux(f):
    return (lambda f_2: f(lambda n: f_2(f_2)(n)))(lambda f_2: f(lambda n: f_2(f_2)(n)))

factorial = lambda f: lambda n: 1 if n == 0 else n * f(n-1)

assert aux(factorial)(6) == 720
```
```python
# Change aux into lambda form
aux = lambda f:(lambda f_2: f(lambda n: f_2(f_2)(n)))(lambda f_2: f(lambda n: f_2(f_2)(n)))

factorial = lambda f: lambda n: 1 if n == 0 else n * f(n-1)

assert aux(factorial)(6) == 720
```

```python
# Add Loop function to avoid duplicated code
def aux(f):
    def loop(z):
        return z(z)
    aux_3 = lambda f_2: f(lambda n: f_2(f_2)(n))
    return loop(aux_3)

factorial = lambda f: lambda n: 1 if n == 0 else n * f(n-1)

assert aux(factorial)(6) == 720
```

```python
# Change loop into lambda form
def aux(f):
    loop = lambda z: z(z)
    aux_3 = lambda f_2: f(lambda n: f_2(f_2)(n))
    return loop(aux_3)

factorial = lambda f: lambda n: 1 if n == 0 else n * f(n-1)

assert aux(factorial)(6) == 720
```
```python
# Remove named references in aux
def aux(f):
    return (lambda z: z(z))(lambda f_2: f(lambda n: f_2(f_2)(n)))

factorial = lambda f: lambda n: 1 if n == 0 else n * f(n-1)

assert aux(factorial)(6) == 720
```
```python
# Change aux into lambda form
aux = lambda f: (lambda z: z(z))(lambda f_2: f(lambda n: f_2(f_2)(n)))

factorial = lambda f: lambda n: 1 if n == 0 else n * f(n-1)

assert aux(factorial)(6) == 720
```

# Y(factorial)(3)
# self_apply(self_apply)(3)
# outer_function(recursive_step)(3)
# factorial(recursive_step)(3)
# factorial_compute(3)
# 3 * recursion(3 - 1)
# 3 * recursion(2)
# 3 * recursive_step(2)
# 3 * x(x)(2)
# 3 * self_apply(self_apply)(2)
# 3 * outer_function(recursive_step)(2)
# 3 * factorial(recursive_step)(2)
# 3 * factorial_compute(2)
# 3 * 2 * recursion(2 - 1)
# 3 * 2 * recursion(1)
# 3 * 2 * recursive_step(1)
# 3 * 2 * x(x)(1)
# 3 * 2 * self_apply(self_apply)(1)
# 3 * 2 * outer_function(recursive_step)(1)
# 3 * 2 * factorial(recursive_step)(1)
# 3 * 2 * factorial_compute(1)
# 3 * 2 * 1

```python
# Alternative non-pure version
aux = lambda f: (lambda z: z(z))(lambda f_2: f(lambda *args, **kwargs: f_2(f_2)(*args, **kwargs)))

factorial = lambda f: lambda n: 1 if n == 0 else n * f(n-1)

assert aux(factorial)(6) == 720
```
```python
# Alternative non-pure version compatible with multiple parameters
aux = lambda f: (lambda z: z(z))(lambda f_2: f(lambda *args, **kwargs: f_2(f_2)(*args, **kwargs)))

def modified_factorial(f):
    def factorial_step(n, /, x, *, p):
        if n == 0:
            return 1
        
        return n * f(n - 1, x, p=p) + x + p
    return factorial_step

assert aux(modified_factorial)(6, 2, p=3) == 6905
```