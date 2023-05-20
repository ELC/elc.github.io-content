Title: Python Recursion: Mutual Head to Nested Tail
Date: 2022-10-25
Category: Programming 
Tags: Python, Functional Programming
Slug: recursion-python
Authors: Ezequiel Leonardo Castaño 
Lang: en 
Headerimage: https://elc.github.io/blog/images/recursion/recursive-python_headerimage.png
Status: draft

[![Jupyter Publishing Header Image]({static}images/recursion/recursive-python_headerimage-thumbnail.png){: .b-lazy width=1444 data-src=/blog/images/recursion/recursive-python_headerimage.png }](/blog/images/recursion/recursive-python_headerimage.png)

<!-- PELICAN_BEGIN_SUMMARY -->

Recursion is a key concept of programming. However it is covered superficially
by many courses. There are different ways of having recursion, this post will
explore them by using Python examples, including cases of head, tail, nested and
mutual recursion. For each case the call graph will be shown.

<!-- PELICAN_END_SUMMARY -->


## An old friend: The Factorial

Many if not all programming courses introduce the factorial function at some
point. This function has great mathematical importance and yet it is simple
enough to showcase how recursion works. However, the approach towards it and
recursion in general is usually superficial.

Before digging into recursion, a procedural implementation using for loops and
while loops will be shown.

### Side Note

This post abuses the fact that, in Python, when a function defined multiple
times only the last definition is used for future references. There will be many
refinements over the definitions and to avoid any confusion, names will not be
changed to reflect that, they all do the same. To further reinforce this idea,
an assert statement will be added to show that results do not change even if the
definition changes.

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
visible. The for loop approach is usually the one found in many sources online,
it is short, uses only basic constructs and does the job. Whereas the while
approach uses one extra variable, that being said, both are valid and share the
same time and space complexity.

Another possibility, not as common as the previous ones, is a functional
implementation using `reduce`:

```python
def factorial(n: int) -> int:
    """Factorial function implemented using reduce"""
    return reduce(lambda x, y: x * y, range(1, n + 1), 1)

assert [factorial(i) for i in range(7)] == [1, 1, 2, 6, 24, 120, 720]
```

Since the previous implementations are non-recursive, the [call
graph](https://en.wikipedia.org/wiki/Call_graph){: target="_blank"}  consists of
a single node:

[![Non Recursive Factorial Call Graph]({static}images/recursion/non_recursive_factorial-thumbnail.png){: .narrow .b-lazy width=554 data-src=/blog/images/recursion/non_recursive_factorial.png }](/blog/images/recursion/non_recursive_factorial.png)


## Recursion

After introducing one of the previous definitions of the factorial function, the
"recursive form" is usually presented. A recursive function is a function that
calls itself. There are multiple types of recursion though and understanding
them may have a huge impact on some programming languages. Before showing how
the recursive version of the factorial looks like, it is important to clarify
some concepts.


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

- Direct Recursion (a single function)
- Indirect Recursion (multiple functions, also called mutual recursion)

Besides the previous classification, all recursive function must have a
termination condition or else they would enter in an infinite loop. Even though
it is not necessary that recursive functions are pure (i.e. they do not have
side effects), it is common for recursive functions to be pure, this simplifies
the interpretation. All the examples in this article are pure functions.

## Linear Recursion

Linear recursion refers to functions where there is **only one recursive call**.

Based on the position of the recursive call it could be further subdivided into:

- Head Recursion: recursive call is the first statement.
- Middle Recursion: there are other statements before and after recursive call.
- Tail Recursion: recursive call is the last statement.

There is no difference between Middle Recursion and Head Recursion from an
efficiency and algorithmic perspective. So no further exploration will not be
done on those two.

When a function has more than one recursive call is called Multi Recursion,
Nonlinear Recursion or Exponential Recursion. These case will be covered in a
later section.

The following is an example of a middle recursion implementation of the
factorial function.


```python
def factorial(n: int) -> int:
    """Middle Recursion implementation of the factorial function"""
    if n == 0:
        return 1
    return n * factorial(n - 1)

assert [factorial(i) for i in range(7)] == [1, 1, 2, 6, 24, 120, 720]
```

It is middle recursion because the last statement is a multiplication (`*`) and
not the recursive call itself. Depending on the operation order it could also be
considered head recursion but that difference is not relevant for most contexts.

Another way to better show why this is middle recursion is to use additional
variables to store interim results:

```python
def factorial(n: int) -> int:
    """Middle Recursion implementation of the factorial function"""
    if n == 0:
        return 1
    previous_factorial = factorial(n - 1)
    current_factorial = n * previous_factorial
    return current_factorial

assert [factorial(i) for i in range(7)] == [1, 1, 2, 6, 24, 120, 720]
```

In this more explicit implementation it is clearer that the last logical
statement is the multiplication `n * previous_factorial`. 

The call graph in the case of linear recursive functions is a series a nodes
called sequentially, hence the name:

[![Recursive Factorial Call Graph]({static}images/recursion/recursive_factorial-thumbnail.png){: .narrow .b-lazy width=200 data-src=/blog/images/recursion/recursive_factorial.png }](/blog/images/recursion/recursive_factorial.png)

When the last statement is the recursive call, the function is called tail
recursion, which will be explored in the next section.

## Tail Recursion

Tail recursion is when the return statement of the function is **only a
recursive call**, this means that a function call could be replaced with another
function call directly. Some languages (Python is not one of them), use a
technique named [Tail-Call
Optimization](https://en.wikipedia.org/wiki/Tail_call){: target="_blank"}, which
makes this particular type of recursion very efficient.

One important clarification is that the return **must not be an expression**. An
example of a straightforward function that can be implemented in a tail
recursive way is the `palindrome` function:

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
assert not palindrome("learn")
assert palindrome("rotator")
```

[![Recursive Palindrome]({static}images/recursion/recursive_palindrome-thumbnail.png){: .narrow .b-lazy width=600 data-src=/blog/images/recursion/recursive_palindrome.png }](/blog/images/recursion/recursive_palindrome.png)

To better illustrate the fact that the returning statement must be **only a
function call**, the following implementation is **NOT** a tail recursive
function because the last statement is not a function call, it is a boolean
expression that requires the function call to be executed prior to returning
because the `and` operator needs the value. This implementation is then a middle
recursion.

    [Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20palindrome%28string%3A%20str%29%20-%3E%20bool%3A%0A%20%20%20%20%22Returns%20True%20if%20the%20given%20string%20is%20a%20palindrome.%20Using%20middle%20recursion.%22%0A%20%20%20%20if%20len%28string%29%20%3C%202%3A%0A%20%20%20%20%20%20%20%20return%20True%0A%0A%20%20%20%20first,%20*rest,%20last%20%3D%20string%0A%20%20%20%20return%20first%20%3D%3D%20last%20and%20palindrome%28rest%29%0A%0Aassert%20palindrome%28%22a%22%29%0Aassert%20palindrome%28%22aa%22%29%0Aassert%20palindrome%28%22aba%22%29%0Aassert%20not%20palindrome%28%22learn%22%29%0Aassert%20palindrome%28%22rotator%22%29&cumulative=false&curInstr=0&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false)

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
assert not palindrome("learn")
assert palindrome("rotator")
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

[![Recursive Sum Integer up to N]({static}images/recursion/recursive_sum_integer_up_to_n-thumbnail.png){: .narrow .b-lazy width=400 data-src=/blog/images/recursion/recursive_sum_integer_up_to_n.png }](/blog/images/recursion/recursive_sum_integer_up_to_n.png)

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

[![Recursive Sum Integer up to N]({static}images/recursion/tail_recursive_sum_integer_up_to_n-thumbnail.png){: .narrow .b-lazy width=400 data-src=/blog/images/recursion/tail_recursive_sum_integer_up_to_n.png }](/blog/images/recursion/tail_recursive_sum_integer_up_to_n.png)


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

[![Tail Recursive Factorial]({static}images/recursion/tail_recursive_factorial-thumbnail.png){: .narrow .b-lazy width=300 data-src=/blog/images/recursion/tail_recursive_factorial.png }](/blog/images/recursion/tail_recursive_factorial.png)


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

[![Multi Recursive Fibonacci]({static}images/recursion/recursive_fibonacci-thumbnail.png){: .b-lazy width=2750 data-src=/blog/images/recursion/recursive_fibonacci.png }](/blog/images/recursion/recursive_fibonacci.png)

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

[![Fibonacci Tail Recursive]({static}images/recursion/tail_recursive_fibonacci-thumbnail.png){: .narrow .b-lazy width=300 data-src=/blog/images/recursion/tail_recursive_fibonacci.png }](/blog/images/recursion/tail_recursive_fibonacci.png)

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

[![Tree recursive quicksort]({static}images/recursion/recursive_quicksort-thumbnail.png){: .b-lazy width=2710 data-src=/blog/images/recursion/recursive_quicksort.png }](/blog/images/recursion/recursive_quicksort.png)

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

[![Maximum Linear recursion]({static}images/recursion/recursive_maximum-thumbnail.png){: .narrow .b-lazy width=400 data-src=/blog/images/recursion/recursive_maximum.png }](/blog/images/recursion/recursive_maximum.png)

This function will have as many recursive calls as elements are in the list. A
similar approach as the quicksort algorithm can be used to reduce the number of
calls to a base two logarithm of the length of the list. With this approach the
recursive stack will be much shorter.

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

[![Maximum Tree Recursion]({static}images/recursion/tree_recursive_maximum-thumbnail.png){: .b-lazy width=3260 data-src=/blog/images/recursion/tree_recursive_maximum.png }](/blog/images/recursion/tree_recursive_maximum.png)

This is not always possible, for functions like fibonacci, it is not trivial to
use a tree approach that reduces the number of recursive calls. A known solution
called Fast Doubling has been discovered, finding this implementation requires a
lot of effort and mathmatical derivaiton and may not be applicable to other
functions.

```python
def fibonacci(n: int) -> int:
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

[![Fast Double Fibonacci]({static}images/recursion/fast_double_fibonacci-thumbnail.png){: .narrow .b-lazy width=700 data-src=/blog/images/recursion/fast_double_fibonacci.png }](/blog/images/recursion/fast_double_fibonacci.png)

It is even possible to further reduce the number of recursive calls by
converting the multi recursive function into a linear recursive function by
changing its structure to return two values at once:

```python
def fibonacci(n: int) -> int:
    # based on: https://www.nayuki.io/page/fast-fibonacci-algorithms
    def nth_and_nth_plus_one(n: int) -> tuple[int, int]:
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

[![Linear Recursive Fibonacci]({static}images/recursion/efficient_recursive_fibonacci-thumbnail.png){: .nested .b-lazy width=400 data-src=/blog/images/recursion/efficient_recursive_fibonacci.png }](/blog/images/recursion/efficient_recursive_fibonacci.png)


Even though in these examples with `fibonacci(4)` the difference is not drastic,
the number of total calls in the call graph scales in notoriously different ways
for each implementation, take for example `fibonacci(100)`:

- Typical Multi Recursive Implementation: 1,146,295,688,027,634,168,203 calls ≈ 1 sextillion calls
- Fast Doubles: 163 calls
- Tail Recursive Implementation (Memoization has no effect): 100 calls
- Linear Recursive Implementation (Memoization has no effect): 8 calls


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
and it is the simplest function proved not to be primitive recursive, meaning
that it cannot be expressed in iterative form with for loops.

This functions is currently used to test compilers efficiency at handling really
deep recursive functions. This is a case of a nested recursive function that is
also tail recursive.

```python
def ackermann(m: int, n: int) -> int:
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

[![Recursive Is Even]({static}images/recursion/recursive_is_even-thumbnail.png){: .narrow .b-lazy width=200 data-src=/blog/images/recursion/recursive_is_even.png }](/blog/images/recursion/recursive_is_even.png)

Of course it is also possible to implement a function that computes the same in
a non recursive form, however, this example does not require division or modulo
computation, it is much slower though for big numbers.


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

## Mutual Nested Recursion

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
import math

def lucas(n: int) -> int:
    if n == 0:
        return 2
    if n == 1:
        return 1
    return (
        2 * math.log2(multiply_last_two(n - 1) * multiply_last_two(n - 2))
        - fibonacci(n-1) + lucas(n-2)
    )


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

One dealing with recursive functions, it is important to keep track of the call
stack and to optimize to avoid wasting resources. Many recursive functions call
themselves multiple times with the same parameters in their call graph, these
repeated calls can be cached to avoid (1) continue traversing a recursive tree
and (2) return the result in constant time. This technique of caching previously
computed results is called **memoization**.


Take for example the following call graph for a multi recursive implementation of `fibonacci(5)`:

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/recursive_non_memoized_fibonacci-thumbnail.png){: .b-lazy width=4106 data-src=/blog/images/recursion/recursive_non_memoized_fibonacci.png }](/blog/images/recursion/recursive_non_memoized_fibonacci.png)

When using memoization the total number of calls is reduced significantly (from 15 calls to 9):

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/recursive_memoized_fibonacci-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/recursive_memoized_fibonacci.png }](/blog/images/recursion/recursive_memoized_fibonacci.png)

Depending on the implementation, the effect of memoization is similar to
*linearizing* the multi recursive function, as the tree has much fewer branches
while the depth is kept the same.

If considering the Fibonacci Fast Doubles implementation of `fibonacci(10)`:

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/non_memoized_fast_double_fibonacci-thumbnail.png){: .b-lazy width=4106 data-src=/blog/images/recursion/non_memoized_fast_double_fibonacci.png }](/blog/images/recursion/non_memoized_fast_double_fibonacci.png)

This can also be reduced (from 15 calls to 11):

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_fast_double_fibonacci-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_fast_double_fibonacci.png }](/blog/images/recursion/memoized_fast_double_fibonacci.png)

Memoization can also be applied to nested recursive functions such as the `hofstadter_g(4)`:

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/non_memoized_hofstadter_g-thumbnail.png){: .b-lazy width=4106 data-src=/blog/images/recursion/non_memoized_hofstadter_g.png }](/blog/images/recursion/non_memoized_hofstadter_g.png)

Now memoized (from 19 calls to 9):

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_hofstadter_g-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_hofstadter_g.png }](/blog/images/recursion/memoized_hofstadter_g.png)

Or deeply nested recursive functions like the `hofstadter_h(3)`:

[![Recursive Hofstadter H]({static}images/recursion/recursive_hofstadter_h-thumbnail.png){: .b-lazy width=9794 data-src=/blog/images/recursion/recursive_hofstadter_h.png }](/blog/images/recursion/recursive_hofstadter_h.png)

And now memoized (from 22 to 10 calls)

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_hofstadter_h-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_hofstadter_h.png }](/blog/images/recursion/memoized_hofstadter_h.png)

Same applies for more complex functions like the Ackermann function with `Ackermann(2, 3)`:

[![Recursive Ackerman]({static}images/recursion/recursive_ackermann-thumbnail.png){: .b-lazy width=6185 data-src=/blog/images/recursion/recursive_ackermann.png }](/blog/images/recursion/recursive_ackermann.png)

And now memoized (from 44 calls to 23):

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_ackermann-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_ackermann.png }](/blog/images/recursion/memoized_ackermann.png)


Memoization can also be used for mutual recursive functions, the following examples show the mutual fibonacci-lucas recursion, the hofstadter female-male


Multi recursive fibonacci-lucas:

[![Mutual Recursive Fibonacci]({static}images/recursion/mutual_recursive_fibonacci-thumbnail.png){: .b-lazy width=5365 data-src=/blog/images/recursion/mutual_recursive_fibonacci.png }](/blog/images/recursion/mutual_recursive_fibonacci.png)

And now memoized (from 26 to 13):

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_mutual_recursive_fibonacci-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_mutual_recursive_fibonacci.png }](/blog/images/recursion/memoized_mutual_recursive_fibonacci.png)


And the hofstadter female-male recursion:

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/mutual_recursive_hofstadter_female-thumbnail.png){: .b-lazy width=5290 data-src=/blog/images/recursion/mutual_recursive_hofstadter_female.png }](/blog/images/recursion/mutual_recursive_hofstadter_female.png)

And now memoized (from 15 to 11 calls)

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_hofstadter_female-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_hofstadter_female.png }](/blog/images/recursion/memoized_hofstadter_female.png)


Taking the `fibonacci(100)` example from the previous section, when
incorporating the memoized approaches the results change substantially:

- Typical Multi Recursive Implementation: 1,146,295,688,027,634,168,203 calls ≈ 1 sextillion calls
- Memoized Typical Multi Recursive Implementation: 199 calls
- Fast Doubles: 163 calls
- Tail Recursive Implementation (Memoization has no effect): 100 calls
- Memoized Fast Doubles: 29 calls
- Linear Recursive Implementation (Memoization has no effect): 8 calls

Since the tail recursive and the linear recursive implementation do not have
repeated calls, memoization has no effect.


