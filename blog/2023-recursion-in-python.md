Title: Python Recursion: a Trampoline from the Mutual Head to the Memoized Nested Tail
Date: 2023-05-21
Category: Programming 
Tags: Python, Functional Programming
Slug: recursion-python
Authors: Ezequiel Leonardo Castaño 
Lang: en 
Headerimage: https://elc.github.io/blog/images/recursion/recursive-python_headerimage.png

[![Recursion in Python]({static}images/recursion/recursive-python_headerimage-thumbnail.png){: .b-lazy width=1444 data-src=/blog/images/recursion/recursive-python_headerimage.png }](/blog/images/recursion/recursive-python_headerimage.png){: .gallery }

<!-- PELICAN_BEGIN_SUMMARY -->

Recursion is a key concept of programming. However, it is usually only
superficially explored. There are different ways of having recursion, this post
will illustrate them using Python examples, call graphs and step-by-step runs.
Including cases of head, tail, nested and mutual recursion. For each case, the
call graph will be shown.

<!-- PELICAN_END_SUMMARY -->

Content covered in this post:

- [An old friend: The Factorial](#an-old-friend-the-factorial)
- [Recursion](#recursion)
    - [Why Recursion?](#why-recursion)
- [Direct vs Indirect Recursion](#direct-vs-indirect-recursion)
- [Linear Recursion](#linear-recursion)
    - [Tail Recursion](#tail-recursion)
- [Multi Recursion](#multi-recursion)
    - [General Non-Linear Recursion](#general-non-linear-recursion)
    - [Tree Recursion](#tree-recursion)
    - [Converting non-tree recursion into tree recursion](#converting-non-tree-recursion-into-tree-recursion)
    - [Nested Recursion](#nested-recursion)
    - [Triple Nested Recursion](#triple-nested-recursion)
    - [Nested Recursion with more than one argument](#nested-recursion-with-more-than-one-argument)
- [Indirect Recursion](#indirect-recursion)
    - [Mutual Linear Recursion](#mutual-linear-recursion)
    - [Mutual Multi Recursion](#mutual-multi-recursion)
    - [Mutual Nested Recursion](#mutual-nested-recursion)
    - [Mutual Triple Recursion](#mutual-triple-recursion)
- [Recursion related techniques](#recursion-related-techniques)
    - [Memoization](#memoization)
    - [Memoization Examples](#memoization-examples)
    - [Trampolining](#trampolining)
    - [Call-By-Need](#call-by-need)
- [Conclusion](#conclusion)

## An old friend: The Factorial

Many if not all programming courses introduce the factorial function at some
point. This function has great mathematical importance and yet it is simple
enough to showcase how recursion works. However, the approach towards it and
recursion, in general, is usually superficial.

Before digging into recursion, a procedural implementation using for-loops and
while loops will be shown.

### Side Note

This post abuses the fact that, in Python, when a function is defined multiple
times only the last definition is used for future references. There will be many
refinements over the definitions and to avoid any confusion, names will not be
changed to reflect that, they all do the same. To further reinforce this idea,
an assert statement will be added to show that results do not change even if the
definition changes.

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20factorial%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%22%22%22Factorial%20function%20implemented%20using%20for%3Dloop%22%22%22%0A%20%20%20%20result%20%3D%201%0A%20%20%20%20for%20i%20in%20range%281,%20n%20%2B%201%29%3A%0A%20%20%20%20%20%20%20%20result%20*%3D%20i%0A%20%20%20%20return%20result%0A%0Aactual%20%3D%20%5Bfactorial%28i%29%20for%20i%20in%20range%287%29%5D%0Aexpected%20%3D%20%5B1,%201,%202,%206,%2024,%20120,%20720%5D%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
def factorial(n: int) -> int:
    """Factorial function implemented using for loops"""
    result = 1
    for i in range(1, n + 1):
        result *= i
    return result

assert [factorial(i) for i in range(7)] == [1, 1, 2, 6, 24, 120, 720]
```

And next the while loop equivalent:

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20factorial%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%22%22%22Factorial%20function%20using%20while-loop%22%22%22%0A%20%20%20%20result%20%3D%201%0A%20%20%20%20multiplier%20%3D%20n%0A%20%20%20%20while%20multiplier%20!%3D%200%3A%0A%20%20%20%20%20%20%20%20result%20*%3D%20multiplier%0A%20%20%20%20%20%20%20%20multiplier%20-%3D%201%0A%20%20%20%20return%20result%0A%0Aactual%20%3D%20%5Bfactorial%28i%29%20for%20i%20in%20range%287%29%5D%0Aexpected%20%3D%20%5B1,%201,%202,%206,%2024,%20120,%20720%5D%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
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

Between the for loop and the while loop implementation differences are visible.
The for-loop approach is usually the one found in many sources online, it is
short, uses only basic constructs and does the job. Whereas the while approach
uses one extra variable, that being said, both are valid and share the same time
and space complexity.

Another possibility, not as common as the previous ones, is a functional
implementation using `reduce`:

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=from%20functools%20import%20reduce%0A%0Adef%20factorial%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%22%22%22Factorial%20function%20using%20reduce%22%22%22%0A%20%20%20%20return%20reduce%28%0A%20%20%20%20%20%20%20%20lambda%20x,%20y%3A%20x%20*%20y,%0A%20%20%20%20%20%20%20%20range%281,%20n%20%2B%201%29,%0A%20%20%20%20%20%20%20%201%0A%20%20%20%20%29%0A%0Aactual%20%3D%20%5Bfactorial%28i%29%20for%20i%20in%20range%287%29%5D%0Aexpected%20%3D%20%5B1,%201,%202,%206,%2024,%20120,%20720%5D%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
from functools import reduce

def factorial(n: int) -> int:
    """Factorial function implemented using reduce"""
    return reduce(lambda x, y: x * y, range(1, n + 1), 1)

assert [factorial(i) for i in range(7)] == [1, 1, 2, 6, 24, 120, 720]
```

Since the previous implementations are non-recursive, the [call
graph](https://en.wikipedia.org/wiki/Call_graph){: target="_blank"}  consists of
a single node:

[![Non-Recursive Factorial Call Graph]({static}images/recursion/non_recursive_factorial-thumbnail.png){: .narrow .b-lazy width=554 data-src=/blog/images/recursion/non_recursive_factorial.png }](/blog/images/recursion/non_recursive_factorial.png){: .gallery }


## Recursion

After introducing one of the previous definitions of the factorial function, the
"recursive form" is usually presented. A recursive function is a function that
calls itself. There are multiple types of recursion though, and understanding
them may have a huge impact on some programming languages. Before showing what
the recursive version of the factorial looks like, it is important to clarify
some concepts.


## Why Recursion?

Recursion in and of itself is a wide field in computer science that may attract
scientists and researchers. However, it is sometimes portrayed as a difficult
topic and receives less attention than other techniques. 

Although some may avoid recursion altogether, there are clear and noticeable
benefits of using recursive functions, such as:

- **Declarative style**: Recursive functions are written by thinking about
  **what** the function does instead of **how** it does it. The iterative style
  usually leads the programmer to think about low-level details like indexes and
  pointers whereas recursion brings the whole problem into mind.
- **Simplicity and Readability**: Recursive functions can provide a more elegant
  and concise solution for solving complex problems by breaking them down into
  simpler subproblems. The recursive approach often closely resembles the
  problem's definition, making the code more intuitive and easier to understand.
- **Divide and Conquer**: Recursive functions can leverage the divide and
  conquer technique, where a problem is divided into smaller subproblems that
  are solved independently. This approach simplifies the problem-solving process
  by reducing complex tasks into manageable pieces.
- **Code Reusability**: Recursive functions are often reusable. Once
  implemented, they can be called multiple times with different inputs, allowing
  for efficient and modular code. Recursive functions can be applied to various
  instances of the same problem, enabling code reuse and promoting good software
  engineering practices.
- **Handling Recursive Structures**: Recursive functions are especially useful
  when dealing with recursive data structures, such as trees or linked lists.
  The recursive nature of the data can be mirrored in the recursive functions,
  making it easier to traverse, manipulate, or process such structures.
- **Mathematical and Algorithmic Modeling**: Many mathematical and algorithmic
  problems are naturally defined in terms of recursion. Recursive functions
  provide a natural and direct way to express these problems, making the code
  more closely aligned with the underlying mathematical or algorithmic concepts.
- **Time and Space Optimization**: Recursive functions can often lead to more
  efficient algorithms in terms of time and space complexity. By breaking down a
  problem into smaller subproblems, recursive functions can avoid unnecessary
  computations by reusing previously calculated results (memoization) or
  eliminating redundant iterations.

## Direct vs Indirect Recursion

Most commonly, when one says "recursive function", it is meant "direct recursive
function", that is, the function calls itself. The other way a function could be
recursive is through "indirect recursion" where, instead of calling itself, it
calls another function (or chain of functions) that will in turn call the first
function.

Different types of direct recursions worth mentioning are:

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

Besides the previous classification, all recursive functions must have a
termination condition or else they would enter in an infinite loop. Even though
recursive functions do not need to be pure (i.e. they do not have side effects),
it is common for recursive functions to be pure, this simplifies the
interpretation. All the examples in this article are pure functions.

## Linear Recursion

Linear recursion refers to functions where there is **only one recursive call**.

Based on the position of the recursive call it could be further subdivided into:

- Head Recursion: recursive call is the first statement.
- Middle Recursion: there are other statements before and after a recursive
  call.
- Tail Recursion: recursive call is the last statement.

There is no difference between Middle Recursion and Head Recursion from an
efficiency and algorithmic perspective. So no further exploration will not be
done on those two.

When a function has more than one recursive call is called Multi Recursion,
Nonlinear Recursion or Exponential Recursion. These cases will be covered in a
later section.

The following is an example of a middle recursion implementation of the
factorial function.


[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20factorial%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%22%22%22Middle%20Recursion%20of%20the%20factorial%20function%22%22%22%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20return%20n%20*%20factorial%28n%20-%201%29%0A%0Aactual%20%3D%20%5Bfactorial%28i%29%20for%20i%20in%20range%287%29%5D%0Aexpected%20%3D%20%5B1,%201,%202,%206,%2024,%20120,%20720%5D%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

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

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20factorial%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%22%22%22Middle%20Recursion%20of%20the%20factorial%20function%22%22%22%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20previous_factorial%20%3D%20factorial%28n%20-%201%29%0A%20%20%20%20current_factorial%20%3D%20n%20*%20previous_factorial%0A%20%20%20%20return%20current_factorial%0A%0Aactual%20%3D%20%5Bfactorial%28i%29%20for%20i%20in%20range%287%29%5D%0Aexpected%20%3D%20%5B1,%201,%202,%206,%2024,%20120,%20720%5D%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

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

In this more explicit implementation, it is clearer that the last logical
statement is the multiplication `n * previous_factorial`. 

The call graph in the case of linear recursive functions is a series of nodes
called sequentially, hence the name:

[![Recursive Factorial Call Graph]({static}images/recursion/recursive_factorial-thumbnail.png){: .narrow .b-lazy width=200 data-src=/blog/images/recursion/recursive_factorial.png }](/blog/images/recursion/recursive_factorial.png){: .gallery }

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

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20palindrome%28string%3A%20str%29%20-%3E%20bool%3A%0A%20%20%20%20%22%22%22Returns%20True%20if%20the%20given%20string%20is%20a%20%0A%20%20%20%20palindrome.%20Using%20tail%20recursion.%22%22%22%0A%20%20%20%20if%20len%28string%29%20%3C%202%3A%0A%20%20%20%20%20%20%20%20return%20True%0A%0A%20%20%20%20first,%20*rest,%20last%20%3D%20string%0A%20%20%20%20if%20first%20!%3D%20last%3A%0A%20%20%20%20%20%20%20%20return%20False%0A%20%20%20%20return%20palindrome%28rest%29%0A%0Aassert%20palindrome%28%22a%22%29%0Aassert%20palindrome%28%22aa%22%29%0Aassert%20palindrome%28%22aba%22%29%0Aassert%20not%20palindrome%28%22learn%22%29%0Aassert%20palindrome%28%22rotator%22%29&cumulative=false&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

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

[![Recursive Palindrome]({static}images/recursion/recursive_palindrome-thumbnail.png){: .narrow .b-lazy width=600 data-src=/blog/images/recursion/recursive_palindrome.png }](/blog/images/recursion/recursive_palindrome.png){: .gallery }

To better illustrate the fact that the returning statement must be **only a
function call**, the following implementation is **NOT** a tail recursive
function because the last statement is not a function call, it is a boolean
expression that requires the function call to be executed before returning. The
reason is the `and` operator which needs a value. This implementation is
therefore a middle recursion.

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20palindrome%28string%3A%20str%29%20-%3E%20bool%3A%0A%20%20%20%20%22%22%22Returns%20True%20if%20the%20given%20string%20is%20%0A%20%20%20%20a%20palindrome.%20Using%20middle%20recursion.%22%22%22%0A%20%20%20%20if%20len%28string%29%20%3C%202%3A%0A%20%20%20%20%20%20%20%20return%20True%0A%0A%20%20%20%20first,%20*rest,%20last%20%3D%20string%0A%20%20%20%20return%20first%20%3D%3D%20last%20and%20palindrome%28rest%29%0A%0Aassert%20palindrome%28%22a%22%29%0Aassert%20palindrome%28%22aa%22%29%0Aassert%20palindrome%28%22aba%22%29%0Aassert%20not%20palindrome%28%22learn%22%29%0Aassert%20palindrome%28%22rotator%22%29&cumulative=false&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

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

Sometimes a function that is not expressed in tail-call form can be converted to
that form. For example the following middle recursive function:

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20sum_integer_up_to_n%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%22%22%22Sums%20all%20integers%20from%20zero%20to%20n.%20%0A%20%20%20%20Using%20middle%20recursion%22%22%22%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20%0A%20%20%20%20return%20n%20%2B%20sum_integer_up_to_n%28n%20-%201%29%0A%0Aassert%20sum_integer_up_to_n%281%29%20%3D%3D%201%0Aassert%20sum_integer_up_to_n%283%29%20%3D%3D%206&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
def sum_integer_up_to_n(n: int) -> int:
    """Sums all integers from zero to n. Using middle recursion"""
    if n == 0:
        return 0

    return n + sum_integer_up_to_n(n - 1)

assert sum_integer_up_to_n(1) == 1
assert sum_integer_up_to_n(3) == 6
```

[![Recursive Sum Integer up to N]({static}images/recursion/recursive_sum_integer_up_to_n-thumbnail.png){: .narrow .b-lazy width=400 data-src=/blog/images/recursion/recursive_sum_integer_up_to_n.png }](/blog/images/recursion/recursive_sum_integer_up_to_n.png){: .gallery }

Can be rewritten into tail-recursive form as:


[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20sum_integer_up_to_n%28n%3A%20int,%20total%3A%20int%20%3D%200%29%20-%3E%20int%3A%0A%20%20%20%20%22%22%22Sums%20all%20integers%20from%20zero%20to%20n.%20%0A%20%20%20%20Using%20Tail%20recursion%22%22%22%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%20total%0A%0A%20%20%20%20return%20sum_integer_up_to_n%28n%20-%201,%20total%3Dn%20%2B%20total%29%0A%0Aassert%20sum_integer_up_to_n%281%29%20%3D%3D%201%0Aassert%20sum_integer_up_to_n%283%29%20%3D%3D%206&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
def sum_integer_up_to_n(n: int, total: int = 0) -> int:
    """Sums all integers from zero to n. Using Tail recursion"""
    if n == 0:
        return total

    return sum_integer_up_to_n(n - 1, total=n + total)

assert sum_integer_up_to_n(1) == 1
assert sum_integer_up_to_n(3) == 6
```

[![Recursive Sum Integer up to N]({static}images/recursion/tail_recursive_sum_integer_up_to_n-thumbnail.png){: .narrow .b-lazy width=400 data-src=/blog/images/recursion/tail_recursive_sum_integer_up_to_n.png }](/blog/images/recursion/tail_recursive_sum_integer_up_to_n.png){: .gallery }


This last version uses an additional parameter to pass the total down the call
chain. This compromises readability for performance if the language implements
tail-call optimization. This style of programming is widely used in languages
like Prolog and some purely-functional languages.

In Python however the extra parameter can be *hidden* by using default values,
this makes the implementation more similar to the original but it is implicitly
hiding the way it truly works, which is against many coding styles. Use with
caution.

In the same way as `sum_integer_up_to_n`, the factorial function could be
re-written into a tail recursive form:

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20factorial%28n%3A%20int,%20result%3A%20int%20%3D%201%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%20result%0A%0A%20%20%20%20return%20factorial%28n%20-%201,%20n%20*%20result%29%0A%0Aactual%20%3D%20%5Bfactorial%28i%29%20for%20i%20in%20range%287%29%5D%0Aexpected%20%3D%20%5B1,%201,%202,%206,%2024,%20120,%20720%5D%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
def factorial(n: int, result: int = 1) -> int:
    if n == 0:
        return result

    return factorial(n - 1, n * result)

assert [factorial(i) for i in range(7)] == [1, 1, 2, 6, 24, 120, 720]
```

[![Tail Recursive Factorial]({static}images/recursion/tail_recursive_factorial-thumbnail.png){: .narrow .b-lazy width=300 data-src=/blog/images/recursion/tail_recursive_factorial.png }](/blog/images/recursion/tail_recursive_factorial.png){: .gallery }


When comparing head/middle with tail recursion, the way each approach works
differs and can be illustrated by inspecting the execution step by step: 

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

When there is more than one recursive call, a function is said to be
multi-recursive. Multi-recursive functions can also be middle/head recursive or
tail-recursive. A special case of Multi Recursion is when the recursive call is
one of the arguments, in this case, it is referred to as nested recursive.

## General Non-Linear Recursion

Many functions do not follow a precise pattern and they just use multiple
recursive calls as part of their definition. One such example is a function that
returns the nth Fibonacci number, to call the function two successive recursive
calls are used.

This is the traditional implementation:

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20fibonacci%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20return%20fibonacci%28n-1%29%20%2B%20fibonacci%28n-2%29%0A%0Aactual%20%3D%20%5Bfibonacci%28i%29%20for%20i%20in%20range%287%29%5D%0Aexpected%20%3D%20%5B0,%201,%201,%202,%203,%205,%208%5D%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
def fibonacci(n: int) -> int:
    if n == 0:
        return 0
    if n == 1:
        return 1
    return fibonacci(n - 1) + fibonacci(n - 2)

assert [fibonacci(i) for i in range(7)] == [0, 1, 1, 2, 3, 5, 8]
```

[![Multi Recursive Fibonacci]({static}images/recursion/recursive_fibonacci-thumbnail.png){: .b-lazy width=2750 data-src=/blog/images/recursion/recursive_fibonacci.png }](/blog/images/recursion/recursive_fibonacci.png){: .gallery }

In some cases, multi-recursive functions can be refactored into linear tail
recursive functions.

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20fibonacci%28%0A%20%20%20%20n%3A%20int,%20partial_result%3A%20int%20%3D%200,%20result%3A%20int%20%3D%201%0A%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%20result%0A%20%20%20%20return%20fibonacci%28%0A%20%20%20%20%20%20%20%20n%3Dn%20-%201,%0A%20%20%20%20%20%20%20%20partial_result%3Dresult,%0A%20%20%20%20%20%20%20%20result%3Dpartial_result%20%2B%20result%0A%20%20%20%20%29%0A%0Aactual%20%3D%20%5Bfibonacci%28i%29%20for%20i%20in%20range%287%29%5D%0Aexpected%20%3D%20%5B0,%201,%201,%202,%203,%205,%208%5D%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
def fibonacci(n: int, partial_result: int = 0, result: int = 1) -> int:
    if n == 0:
        return 0
    if n == 1:
        return result
    return fibonacci(n - 1, result, partial_result + result)

assert [fibonacci(i) for i in range(7)] == [0, 1, 1, 2, 3, 5, 8]
```

[![Fibonacci Tail Recursive]({static}images/recursion/tail_recursive_fibonacci-thumbnail.png){: .narrow .b-lazy width=300 data-src=/blog/images/recursion/tail_recursive_fibonacci.png }](/blog/images/recursion/tail_recursive_fibonacci.png){: .gallery }

## Tree Recursion

In the case of multi-recursive functions, it is possible to construct a tree of
the function calls. All multi-recursive functions produce a tree, that being
said, in some cases the definition leverages the divide-and-conquer strategy,
minimizing the depth of the tree. One example of this is the quicksort
algorithm:

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=from%20typing%20import%20Collection,%20List%0A%0Adef%20quicksort%28%0A%20%20%20%20numbers%3A%20Collection%5Bfloat%5D%0A%29%20-%3E%20List%5Bfloat%5D%3A%0A%20%20%20%20if%20len%28numbers%29%20%3C%3D%201%3A%0A%20%20%20%20%20%20%20%20return%20numbers%0A%0A%20%20%20%20first,%20*rest%20%3D%20numbers%0A%0A%20%20%20%20left%20%3D%20%5Bx%20for%20x%20in%20rest%20if%20x%20%3C%20first%5D%0A%20%20%20%20right%20%3D%20%5Bx%20for%20x%20in%20rest%20if%20x%20%3E%3D%20first%5D%0A%20%20%20%20return%20quicksort%28left%29%20%2B%20%5Bfirst%5D%20%2B%20quicksort%28right%29%0A%0Aactual%20%3D%20quicksort%28%5B2,%204,%203,%205,%200,%201%5D%29%0Aexpected%20%3D%20list%28range%286%29%29%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
from typing import Collection

def quicksort(numbers: Collection[float]) -> list[float]:
    if len(numbers) <= 1:
        return numbers

    first, *rest = numbers

    left = [x for x in rest if x < first]
    right = [x for x in rest if x >= first]
    return quicksort(left) + [first] + quicksort(right)

assert quicksort([2, 4, 3, 5, 0, 1]) == list(range(6))
assert quicksort(list(reversed(range(10)))) == list(range(10))
```

[![Tree recursive quicksort]({static}images/recursion/recursive_quicksort-thumbnail.png){: .b-lazy width=2710 data-src=/blog/images/recursion/recursive_quicksort.png }](/blog/images/recursion/recursive_quicksort.png){: .gallery }

Here the function divides the input into two parts and each recursive call gets
one of the parts. This strategy reduces the number of recursive calls by a great
amount.

## Converting non-tree recursion into tree recursion

Some functions that are originally linear recursive can be converted into tree
recursive to reduce the depth of the recursive stack. This is usually easy on
functions that operate on arrays.

Here is a linear recursive implementation of a function that returns the maximum
value of a list:

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=from%20typing%20import%20Iterable%0A%0Adef%20maximum%28numbers%3A%20Iterable%5Bfloat%5D%29%20-%3E%20float%3A%0A%20%20%20%20first,%20*rest%20%3D%20numbers%0A%20%20%20%20if%20not%20rest%3A%0A%20%20%20%20%20%20%20%20return%20first%0A%0A%20%20%20%20rest_max%20%3D%20maximum%28rest%29%0A%20%20%20%20return%20first%20if%20first%20%3E%20rest_max%20else%20rest_max%0A%0Aassert%20maximum%28%5B2,%204,%203,%205,%200,%201%5D%29%20%3D%3D%205%0Aassert%20maximum%28list%28range%2810%29%29%29%20%3D%3D%209&cumulative=false&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
from typing import Iterable

def maximum(numbers: Iterable[float]) -> float:
    first, *rest = numbers
    if not rest:
        return first

    rest_max = maximum(rest)
    return first if first > rest_max else rest_max

assert maximum([2, 4, 3, 5, 0, 1]) == 5
assert maximum(list(range(10))) == 9
```

[![Maximum Linear recursion]({static}images/recursion/recursive_maximum-thumbnail.png){: .narrow .b-lazy width=400 data-src=/blog/images/recursion/recursive_maximum.png }](/blog/images/recursion/recursive_maximum.png){: .gallery }


This holds even if re-written into a tail-recursive form:

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=from%20typing%20import%20Optional,%20Iterable%0A%0Adef%20maximum%28%0A%20%20%20%20numbers%3A%20Iterable%5Bfloat%5D,%0A%20%20%20%20max_value%3A%20Optional%5Bfloat%5D%20%3D%20None%0A%29%20-%3E%20float%3A%0A%20%20%20%20first,%20*rest%20%3D%20numbers%0A%0A%20%20%20%20if%20max_value%20is%20None%20or%20first%20%3E%20max_value%3A%0A%20%20%20%20%20%20%20%20max_value%20%3D%20first%0A%0A%20%20%20%20if%20not%20rest%3A%0A%20%20%20%20%20%20%20%20return%20max_value%0A%0A%20%20%20%20return%20maximum%28rest,%20max_value%29%0A%0Aassert%20maximum%28%5B2,%204,%203,%205,%200,%201%5D%29%20%3D%3D%205&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
from typing import Optional, Iterable

def maximum(numbers: Iterable[float], max_value: Optional[float] = None) -> float:
    first, *rest = numbers

    if max_value is None or first > max_value:
        max_value = first

    if not rest:
        return max_value

    return maximum(rest, max_value)

assert maximum([2, 4, 3, 5, 0, 1]) == 5
```

[![Maximum Linear tail recursion]({static}images/recursion/recursive_maximum_tail-thumbnail.png){: .narrow .b-lazy width=400 data-src=/blog/images/recursion/recursive_maximum_tail.png }](/blog/images/recursion/recursive_maximum_tail.png){: .gallery }

Both implementations will have as many recursive calls as there are elements in
the list. A similar approach to the quicksort algorithm can be used to reduce
the number of calls, halving the length of the list each time. With this
approach, the recursive stack will be shorter.

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=from%20typing%20import%20Collection%0A%0Adef%20maximum%28numbers%3A%20Collection%5Bfloat%5D%29%20-%3E%20float%3A%0A%20%20%20%20first,%20*rest%20%3D%20numbers%0A%20%20%20%20if%20not%20rest%3A%0A%20%20%20%20%20%20%20%20return%20first%0A%0A%20%20%20%20middle%20%3D%20len%28numbers%29%20//%202%0A%20%20%20%20left_max%20%3D%20maximum%28numbers%5B%3Amiddle%5D%29%0A%20%20%20%20right_max%20%3D%20maximum%28numbers%5Bmiddle%3A%5D%29%0A%20%20%20%20%0A%20%20%20%20if%20left_max%20%3E%20right_max%3A%0A%20%20%20%20%20%20%20%20return%20left_max%0A%20%20%20%20return%20right_max%0A%0Aassert%20maximum%28%5B2,%204,%203,%205,%200,%201%5D%29%20%3D%3D%205%0Aassert%20maximum%28list%28range%2810%29%29%29%20%3D%3D%209&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
from typing import Collection

def maximum(numbers: Collection[float]) -> float:
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

[![Maximum Tree Recursion]({static}images/recursion/tree_recursive_maximum-thumbnail.png){: .b-lazy width=3260 data-src=/blog/images/recursion/tree_recursive_maximum.png }](/blog/images/recursion/tree_recursive_maximum.png){: .gallery }

Refactoring functions this way is not always possible, for functions like nth
Fibonacci, it is not trivial to use a tree approach that reduces the number of
recursive calls. A known solution called Fast Doubling has been discovered.
Deriving this implementation requires a lot of effort and mathematical
knowledge, such an approach may not apply to other functions.

The Fast Doubling Implementation is as follows:

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20fibonacci%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%23%20Fast%20Doubling%20Method%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20%0A%20%20%20%20is_odd%20%3D%20n%20%25%202%0A%20%20%20%20m%20%3D%20n%20//%202%20%2B%20is_odd%0A%20%20%20%20fib_m%20%3D%20fibonacci%28m%29%0A%20%20%20%20fib_m_1%20%3D%20fibonacci%28m%20-%201%29%0A%0A%20%20%20%20if%20is_odd%3A%0A%20%20%20%20%20%20%20%20return%20fib_m_1%20**%202%20%2B%20fib_m%20**%202%0A%20%20%20%20return%202%20*%20fib_m%20*%20fib_m_1%20%2B%20fib_m%20**%202%0A%0Aactual%20%3D%20%5Bfibonacci%28i%29%20for%20i%20in%20range%287%29%5D%0Aexpected%20%3D%20%5B0,%201,%201,%202,%203,%205,%208%5D%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

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
        return fib_m_1**2 + fib_m**2
    return 2 * fib_m * fib_m_1 + fib_m**2

assert [fibonacci(i) for i in range(7)] == [0, 1, 1, 2, 3, 5, 8]
```

[![Fast Double Fibonacci]({static}images/recursion/fast_double_fibonacci-thumbnail.png){: .narrow .b-lazy width=700 data-src=/blog/images/recursion/fast_double_fibonacci.png }](/blog/images/recursion/fast_double_fibonacci.png){: .gallery }

It is even possible to further reduce the number of recursive calls by
converting the multi-recursive function into a linear recursive function by
changing its structure to return two values at once:

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=from%20typing%20import%20Tuple%0A%0Adef%20fibonacci%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20def%20nth_and_nth_plus_one%28%0A%20%20%20%20%20%20%20%20n%3A%20int%0A%20%20%20%20%29%20-%3E%20Tuple%5Bint,%20int%5D%3A%0A%20%20%20%20%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20return%200,%201%0A%0A%20%20%20%20%20%20%20%20fib_m,%20fib_m_1%20%3D%20nth_and_nth_plus_one%28n%20//%202%29%0A%20%20%20%20%20%20%20%20nth%20%3D%20fib_m%20*%20fib_m_1%20*%202%20-%20fib_m%20**%202%0A%20%20%20%20%20%20%20%20nth_plus_one%20%3D%20fib_m%20**%202%20%2B%20fib_m_1%20**%202%0A%0A%20%20%20%20%20%20%20%20is_odd%20%3D%20n%20%25%202%0A%20%20%20%20%20%20%20%20if%20is_odd%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20nth_plus_two%20%3D%20nth%20%2B%20nth_plus_one%0A%20%20%20%20%20%20%20%20%20%20%20%20return%20nth_plus_one,%20nth_plus_two%0A%20%20%20%20%20%20%20%20return%20nth,%20nth_plus_one%0A%0A%20%20%20%20nth,%20_%20%3D%20nth_and_nth_plus_one%28n%29%0A%20%20%20%20return%20nth%0A%0Aactual%20%3D%20%5Bfibonacci%28i%29%20for%20i%20in%20range%287%29%5D%0Aexpected%20%3D%20%5B0,%201,%201,%202,%203,%205,%208%5D%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
def fibonacci(n: int) -> int:
    # based on: https://www.nayuki.io/page/fast-fibonacci-algorithms
    def nth_and_nth_plus_one(n: int) -> tuple[int, int]:
        if n == 0:
            return 0, 1

        fib_m, fib_m_1 = nth_and_nth_plus_one(n // 2)
        nth = fib_m * fib_m_1 * 2 - fib_m**2
        nth_plus_one = fib_m**2 + fib_m_1**2

        is_odd = n % 2
        if is_odd:
            nth_plus_two = nth + nth_plus_one
            return nth_plus_one, nth_plus_two
        return nth, nth_plus_one

    nth, _ = nth_and_nth_plus_one(n)
    return nth

assert [fibonacci(i) for i in range(7)] == [0, 1, 1, 2, 3, 5, 8]
```

[![Linear Recursive Fibonacci]({static}images/recursion/efficient_recursive_fibonacci-thumbnail.png){: .narrow .b-lazy width=400 data-src=/blog/images/recursion/efficient_recursive_fibonacci.png }](/blog/images/recursion/efficient_recursive_fibonacci.png){: .gallery }


Even though in these examples with `fibonacci(4)` the difference is not drastic,
the number of total calls in the call graph scales in notoriously different ways
for each implementation, take for example `fibonacci(100)`:

- Typical Multi Recursive Implementation: 1,146,295,688,027,634,168,203 calls ≈ 1 sextillion calls
- Fast Doubles: 163 calls
- Tail Recursive Implementation: 100 calls
- Linear Recursive Implementation: 8 calls


## Nested Recursion

One special case of multi-recursion is when the argument of the recursive call
is itself a recursive call. This is not usual in software development but could
arise in mathematical fields. One example is the [Hofstadter G Sequence](https://mathworld.wolfram.com/HofstadterG-Sequence.html){: target="_blank"}:

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20hofstadter_g%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20return%20n%20-%20hofstadter_g%28hofstadter_g%28n%20-%201%29%29%0A%0Aactual%20%3D%20%5Bhofstadter_g%28i%29%20for%20i%20in%20range%287%29%5D%0Aexpected%20%3D%20%5B0,%201,%201,%202,%203,%203,%204%5D%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
def hofstadter_g(n: int) -> int:
    if n == 0:
        return 0
    return n - hofstadter_g(hofstadter_g(n - 1))

assert [hofstadter_g(i) for i in range(7)] == [0, 1, 1, 2, 3, 3, 4]
```

[![Recursive Hofstadter G]({static}images/recursion/recursive_hofstadter_g-thumbnail.png){: .b-lazy width=3702 data-src=/blog/images/recursion/recursive_hofstadter_g.png }](/blog/images/recursion/recursive_hofstadter_g.png){: .gallery }

Refactoring nested recursion into non-nested multi-recursion or linear recursion
is a non-trivial task and sometimes it may be impossible.

## Triple Nested Recursion

The level of nesting is not limited to just two calls, the [Hofstadter H Sequence](https://mathworld.wolfram.com/HofstadterH-Sequence.html){: target="_blank"}
has triple nesting recursion for example:

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20hofstadter_h%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20return%20n%20-%20hofstadter_h%28%0A%20%20%20%20%20%20%20%20hofstadter_h%28%0A%20%20%20%20%20%20%20%20%20%20%20%20hofstadter_h%28n%20-%201%29%0A%20%20%20%20%20%20%20%20%29%0A%20%20%20%20%29%0A%0Aactual%20%3D%20%5Bhofstadter_h%28i%29%20for%20i%20in%20range%286%29%5D%0Aexpected%20%3D%20%5B0,%201,%201,%202,%203,%204%5D%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
def hofstadter_h(n: int) -> int:
    if n == 0:
        return 0
    return n - hofstadter_h(hofstadter_h(hofstadter_h(n - 1)))

assert [hofstadter_h(i) for i in range(6)] == [0, 1, 1, 2, 3, 4]
```

[![Recursive Hofstadter H]({static}images/recursion/recursive_hofstadter_h-thumbnail.png){: .b-lazy width=9794 data-src=/blog/images/recursion/recursive_hofstadter_h.png }](/blog/images/recursion/recursive_hofstadter_h.png){: .gallery }


## Nested Recursion with more than one argument

Some functions can have multiple arguments and be nested recursive. One example
is the [Ackermann
function](https://mathworld.wolfram.com/AckermannFunction.html){: target="_blank"} grows extremely fast due to this nested recursive definition
and it is the simplest function proved not to be primitive recursive, meaning
that it cannot be expressed in iterative form with for loops.

This function is currently used to test compilers' efficiency at handling really
deep recursive functions. This is a case of a nested recursive function that is
also tail recursive.

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20ackermann%28m%3A%20int,%20n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20m%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%20n%20%2B%201%0A%20%20%20%20if%20m%20%3E%200%20and%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%20ackermann%28m%20-%201,%201%29%20%20%20%20%0A%20%20%20%20return%20ackermann%28m%20-%201,%20ackermann%28m,%20n%20-%201%29%29%0A%0Aactual%20%3D%20%5B%0A%20%20%20%20ackermann%28i,%20j%29%20%0A%20%20%20%20for%20i%20in%20range%283%29%20%0A%20%20%20%20for%20j%20in%20range%283%29%0A%5D%0Aexpected%20%3D%20%5B1,%202,%203,%202,%203,%204,%203,%205,%207%5D%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
def ackermann(m: int, n: int) -> int:
    if m == 0:
        return n + 1
    if m > 0 and n == 0:
        return ackermann(m - 1, 1)    
    return ackermann(m - 1, ackermann(m, n - 1))

assert [ackermann(i, j) for i in range(3) for j in range(3)] == [1, 2, 3, 2, 3, 4, 3, 5, 7]
```

[![Recursive Ackerman]({static}images/recursion/recursive_ackermann-thumbnail.png){: .b-lazy width=6185 data-src=/blog/images/recursion/recursive_ackermann.png }](/blog/images/recursion/recursive_ackermann.png){: .gallery }

## Indirect Recursion

So far, all the examples showed functions that called themselves, this is direct
recursion. An alternative approach is indirect recursion, also known as mutual
recursion. In this case, the same categories could be applied (linear, tail,
head, nested, etc.), but the recursive call is now to another function, that
other function will, in turn, call the original one.
## Mutual Linear Recursion

A simple example of mutual linear tail recursion is a set of functions that
determines if a number is odd or even:  

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20is_even%28n%3A%20int%29%20-%3E%20bool%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%20True%0A%20%20%20%20return%20is_odd%28n%20-%201%29%0A%0Adef%20is_odd%28n%3A%20int%29%20-%3E%20bool%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%20False%0A%20%20%20%20return%20is_even%28n%20-%201%29%0A%0Aactual_even%20%3D%20%5Bis_even%28i%29%20for%20i%20in%20range%286%29%5D%0Aexpected_even%20%3D%20%5BTrue,%20False,%20True,%20False,%20True,%20False%5D%0Aassert%20actual_even%20%3D%3D%20expected_even%0A%0Aactual_odd%20%3D%20%5Bis_odd%28i%29%20for%20i%20in%20range%286%29%5D%0Aexpected_odd%20%3D%20%5BFalse,%20True,%20False,%20True,%20False,%20True%5D%0Aassert%20actual_odd%20%3D%3D%20expected_odd&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

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

[![Recursive Is Even]({static}images/recursion/recursive_is_even-thumbnail.png){: .narrow .b-lazy width=200 data-src=/blog/images/recursion/recursive_is_even.png }](/blog/images/recursion/recursive_is_even.png){: .gallery }

Of course, it is also possible to implement a function that computes the same in
a non-recursive form. However, this example does not require division or modulo
computation, it is much slower for big numbers.


## Mutual Multi Recursion

Mutual recursion can also happen in multi-recursive functions. Take the
following direct multi-recursive function that computes the nth Lucas number:

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20lucas%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%202%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20return%20lucas%28n-1%29%20%2B%20lucas%28n-2%29%0A%0Aactual%20%3D%20%5Blucas%28i%29%20for%20i%20in%20range%287%29%5D%0Aexpected%20%3D%20%5B2,%201,%203,%204,%207,%2011,%2018%5D%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
def lucas(n: int) -> int:
    if n == 0:
        return 2
    if n == 1:
        return 1
    return lucas(n - 1) + lucas(n - 2)

assert [lucas(i) for i in range(7)] == [2, 1, 3, 4, 7, 11, 18]
```

[![Recursive Lucas]({static}images/recursion/recursive_lucas-thumbnail.png){: .b-lazy width=2225 data-src=/blog/images/recursion/recursive_lucas.png }](/blog/images/recursion/recursive_lucas.png){: .gallery }

It is possible to write both the Lucas and the Fibonacci functions in a mutual
recursive form:

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20lucas%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%202%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20return%20%28%0A%20%20%20%20%20%20%20%202%20*%20fibonacci%28n%29%0A%20%20%20%20%20%20%20%20-%20fibonacci%28n-1%29%0A%20%20%20%20%20%20%20%20%2B%20lucas%28n-2%29%0A%20%20%20%20%29%0A%0A%0Adef%20fibonacci%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20return%20%28fibonacci%28n-1%29%20%2B%20lucas%28n-1%29%29%20//%202%0A%0Aactual_lucas%20%3D%20%5Blucas%28i%29%20for%20i%20in%20range%285%29%5D%0Aexpected_lucas%20%3D%20%5B2,%201,%203,%204,%207%5D%0Aassert%20actual_lucas%20%3D%3D%20expected_lucas%0A%0Aactual_fibonacci%20%3D%20%5Bfibonacci%28i%29%20for%20i%20in%20range%285%29%5D%0Aexpected_fibonacci%20%3D%20%5B0,%201,%201,%202,%203%5D%0Aassert%20actual_fibonacci%20%3D%3D%20expected_fibonacci&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
def lucas(n: int) -> int:
    if n == 0:
        return 2
    if n == 1:
        return 1
    return 2 * fibonacci(n) - fibonacci(n - 1) + lucas(n - 2)

def fibonacci(n: int) -> int:
    if n == 0:
        return 0
    if n == 1:
        return 1
    return (fibonacci(n - 1) + lucas(n - 1)) // 2

assert [lucas(i) for i in range(5)] == [2, 1, 3, 4, 7]
assert [fibonacci(i) for i in range(5)] == [0, 1, 1, 2, 3]
```

[![Mutual Recursive Fibonacci]({static}images/recursion/mutual_recursive_fibonacci-thumbnail.png){: .b-lazy width=5365 data-src=/blog/images/recursion/mutual_recursive_fibonacci.png }](/blog/images/recursion/mutual_recursive_fibonacci.png){: .gallery }

This implementation is standalone and does not require any of the two functions
to be defined in a direct recursive way. In practical terms, there is no gain as
it makes the whole computation slower and less efficient, it is just for
demonstration purposes.

Similarly, the sequence defined as the multiplication of the last two terms can
be implemented in a direct multi-recursive form:


[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20multiply_last_two%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%202%0A%20%20%20%20return%20%28%0A%20%20%20%20%20%20%20%20multiply_last_two%28n%20-%201%29%0A%20%20%20%20%20%20%20%20*%20multiply_last_two%28n%20-%202%29%0A%20%20%20%20%29%0A%0Aactual%20%3D%20%5Bmultiply_last_two%28i%29%20for%20i%20in%20range%287%29%5D%0Aexpected%20%3D%20%5B1,%202,%202,%204,%208,%2032,%20256%5D%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
def multiply_last_two(n: int) -> int:
    if n == 0:
        return 1
    if n == 1:
        return 2
    return multiply_last_two(n - 1) * multiply_last_two(n - 2)

assert [multiply_last_two(i) for i in range(7)] == [1, 2, 2, 4, 8, 32, 256]
```

[![Mutual Recursive Fibonacci]({static}images/recursion/recursive_multiply_last_two-thumbnail.png){: .b-lazy width=3988 data-src=/blog/images/recursion/recursive_multiply_last_two.png }](/blog/images/recursion/recursive_multiply_last_two.png){: .gallery }

This again can be used to implement the Fibonacci and the multiply last two as
mutually recursive functions.

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=import%20math%0A%0Adef%20fibonacci%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20return%20int%28%0A%20%20%20%20%20%20%20%20math.log2%28multiply_last_two%28n%20-%201%29%0A%20%20%20%20%20%20%20%20*%20multiply_last_two%28n%20-%202%29%0A%20%20%20%20%20%20%20%20%29%0A%20%20%20%20%29%0A%0Adef%20multiply_last_two%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%202%0A%20%20%20%20return%202%20**%20%28fibonacci%28n-1%29%20%2B%20fibonacci%28n-2%29%29%0A%0A%0Aactual_fibonacci%20%3D%20%5Bfibonacci%28i%29%20for%20i%20in%20range%285%29%5D%0Aexpected_fibonacci%20%3D%20%5B0,%201,%201,%202,%203%5D%0Aassert%20actual_fibonacci%20%3D%3D%20expected_fibonacci%0A%0Aactual%20%3D%20%5Bmultiply_last_two%28i%29%20for%20i%20in%20range%287%29%5D%0Aexpected%20%3D%20%5B1,%202,%202,%204,%208,%2032,%20256%5D%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

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
    return 2 ** (fibonacci(n - 1) + fibonacci(n - 2))

assert [fibonacci(i) for i in range(7)] == [0, 1, 1, 2, 3, 5, 8]
assert [multiply_last_two(i) for i in range(7)] == [1, 2, 2, 4, 8, 32, 256]
```

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/mutual_recursive_fibonacci_alternative-thumbnail.png){: .b-lazy width=3163 data-src=/blog/images/recursion/mutual_recursive_fibonacci_alternative.png }](/blog/images/recursion/mutual_recursive_fibonacci_alternative.png){: .gallery }

## Mutual Nested Recursion

Mutual recursion can also appear in a nested form, as is the case of the
[Hofstadter Female and Male sequences](https://mathworld.wolfram.com/HofstadterMale-FemaleSequences.html#:~:text=are%201%2C%201%2C%202%2C,(OEIS%20A005378).){: target="_blank"} which are mutually nested recursive.

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20hofstadter_f%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20return%20n%20-%20hofstadter_m%28hofstadter_f%28n%20-%201%29%29%0A%0Adef%20hofstadter_m%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20return%20n%20-%20hofstadter_f%28hofstadter_m%28n%20-%201%29%29%0A%0Aactual_female%20%3D%20%5Bhofstadter_f%28i%29%20for%20i%20in%20range%286%29%5D%0Aexpected_female%20%3D%20%5B1,%201,%202,%202,%203,%203%5D%0Aassert%20actual_female%20%3D%3D%20expected_female%0A%0Aactual_male%20%3D%20%5Bhofstadter_m%28i%29%20for%20i%20in%20range%286%29%5D%0Aexpected_male%20%3D%20%5B0,%200,%201,%202,%202,%203%5D%0Aassert%20actual_male%20%3D%3D%20expected_male&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
def hofstadter_female(n: int) -> int:
    if n == 0:
        return 1
    return n - hofstadter_male(hofstadter_female(n - 1))

def hofstadter_male(n: int) -> int:
    if n == 0:
        return 0
    return n - hofstadter_female(hofstadter_male(n - 1))

assert [hofstadter_female(i) for i in range(6)] == [1, 1, 2, 2, 3, 3]
assert [hofstadter_male(i) for i in range(6)] == [0, 0, 1, 2, 2, 3]
```

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/mutual_recursive_hofstadter_female-thumbnail.png){: .b-lazy width=5290 data-src=/blog/images/recursion/mutual_recursive_hofstadter_female.png }](/blog/images/recursion/mutual_recursive_hofstadter_female.png){: .gallery }

## Mutual Triple Recursion

Indirect recursion is not limited to only two functions, the following example
combines the Lucas, Fibonacci and multiply last two functions in a triple mutual
recursive form, where each function uses the other two and itself.

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=import%20math%0A%0Adef%20lucas%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%202%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20return%20%28%0A%20%20%20%20%20%20%20%202%20*%20math.log2%28multiply_last_two%28n%20-%201%29%20%0A%20%20%20%20%20%20%20%20*%20multiply_last_two%28n%20-%202%29%29%0A%20%20%20%20%20%20%20%20-%20fibonacci%28n-1%29%20%2B%20lucas%28n-2%29%0A%20%20%20%20%29%0A%0A%0Adef%20fibonacci%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20return%20%28fibonacci%28n-1%29%20%2B%20lucas%28n-1%29%29%20//%202%0A%0A%0Adef%20multiply_last_two%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%202%0A%20%20%20%20return%202%20**%20%28%0A%20%20%20%20%20%20%20%201.5%20*%20fibonacci%28n-2%29%20%2B%200.5%20*%20lucas%28n-2%29%0A%20%20%20%20%29%0A%0A%0Aactual_lucas%20%3D%20%5Blucas%28i%29%20for%20i%20in%20range%285%29%5D%0Aexpected_lucas%20%3D%20%5B2,%201,%203,%204,%207%5D%0Aassert%20actual_lucas%20%3D%3D%20expected_lucas%0A%0Aactual_fibonacci%20%3D%20%5Bfibonacci%28i%29%20for%20i%20in%20range%285%29%5D%0Aexpected_fibonacci%20%3D%20%5B0,%201,%201,%202,%203%5D%0Aassert%20actual_fibonacci%20%3D%3D%20expected_fibonacci%0A%0Aactual%20%3D%20%5Bmultiply_last_two%28i%29%20for%20i%20in%20range%285%29%5D%0Aexpected%20%3D%20%5B1,%202,%202,%204,%208%5D%0Aassert%20actual%20%3D%3D%20expected&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
import math

def lucas(n: int) -> int:
    if n == 0:
        return 2
    if n == 1:
        return 1
    return (
        2 * math.log2(multiply_last_two(n - 1) * multiply_last_two(n - 2))
        - fibonacci(n - 1)
        + lucas(n - 2)
    )

def fibonacci(n: int) -> int:
    if n == 0:
        return 0
    if n == 1:
        return 1
    return (fibonacci(n - 1) + lucas(n - 1)) // 2

def multiply_last_two(n: int) -> int:
    if n == 0:
        return 1
    if n == 1:
        return 2
    return 2 ** (1.5 * fibonacci(n - 2) + 0.5 * lucas(n - 2))

assert [lucas(i) for i in range(6)] == [2, 1, 3, 4, 7, 11]
assert [fibonacci(i) for i in range(6)] == [0, 1, 1, 2, 3, 5]
assert [multiply_last_two(i) for i in range(6)] == [1, 2, 2, 4, 8, 32]
```

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/mutual_triple_recursive_fibonacci-thumbnail.png){: .b-lazy width=6969 data-src=/blog/images/recursion/mutual_triple_recursive_fibonacci.png }](/blog/images/recursion/mutual_triple_recursive_fibonacci.png){: .gallery }


## Recursion related techniques

Recursion is a wide field, and due to language, compilers and general developer
experience limitations, several tools and techniques have been developed to
improve recursion support and performance.

## Memoization

When dealing with recursive functions, it is important to keep track of the call
stack and optimize it to avoid wasting resources. Many recursive functions call
themselves multiple times with the same parameters in their call graph, these
repeated calls can be cached (assuming the function is pure) to avoid (1)
continuing traversing a recursive tree unnecessarily and (2) returning the
result in constant time. This technique of caching previously computed results
is called [**memoization**](https://en.wikipedia.org/wiki/Memoization){: target="_blank"}.

Memoization is easy to implement in Python, both from scratch and using the
standard library. 

The from-scratch implementation can be written using decorators:

```python
from functools import wraps
from typing import Callable, TypeVar, ParamSpec

T = TypeVar("T")
P = ParamSpec("P")

def memoize(function: Callable[P, T]) -> Callable[P, T]:
    cache: dict[str, T] = {}

    @wraps(function)
    def wrapper(*args: P.args, **kwargs: P.kwargs) -> T:
        nonlocal cache

        cacheable_args = str(tuple(sorted(args)) + tuple(sorted(kwargs.items())))
        if cacheable_args not in cache:
            cache[cacheable_args] = function(*args, **kwargs)
        return cache[cacheable_args]

    return wrapper
```

Another possibility is to use the standard library, which has support for
memoization through `functools.cache`, this function is available in Python 3.9
or later. For older versions, it is also possible to use `functools.lru_cache`,
which also adds the capability of setting a max limit of cached entries.

## Memoization Examples

This section will show what the call graph of the above examples looks like when
memoization is applied.

Take for example the following call graph for a multi-recursive implementation
of `fibonacci(5)`:

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/recursive_non_memoized_fibonacci-thumbnail.png){: .b-lazy width=4106 data-src=/blog/images/recursion/recursive_non_memoized_fibonacci.png }](/blog/images/recursion/recursive_non_memoized_fibonacci.png){: .gallery }

When using memoization the total number of calls is reduced significantly (from
15 calls to 9):

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=from%20functools%20import%20wraps%0Afrom%20typing%20import%20Callable,%20TypeVar,%20Any%0A%0AT%20%3D%20TypeVar%28%22T%22%29%0A%0A%23%20With%20Scratch%20Implementation%0Adef%20memoize%28function%3A%20Callable%5B...,%20T%5D%29%20-%3E%20Callable%5B...,%20T%5D%3A%0A%20%20%20%20cache%3A%20dict%5Bstr,%20T%5D%20%3D%20%7B%7D%0A%0A%20%20%20%20%40wraps%28function%29%0A%20%20%20%20def%20wrapper%28*args,%20**kwargs%29%20-%3E%20T%3A%0A%20%20%20%20%20%20%20%20nonlocal%20cache%0A%20%20%20%20%0A%20%20%20%20%20%20%20%20cacheable_args%20%3D%20str%28tuple%28sorted%28args%29%29%20%2B%20tuple%28sorted%28kwargs.items%28%29%29%29%29%0A%20%20%20%20%20%20%20%20if%20cacheable_args%20not%20in%20cache%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20cache%5Bcacheable_args%5D%20%3D%20function%28*args,%20**kwargs%29%0A%20%20%20%20%20%20%20%20return%20cache%5Bcacheable_args%5D%0A%0A%20%20%20%20return%20wrapper%0A%0A%40memoize%0Adef%20fibonacci_memoize%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20return%20fibonacci_memoize%28n-1%29%20%2B%20fibonacci_memoize%28n-2%29%0A%0Aassert%20fibonacci_memoize%285%29%20%3D%3D%205%0Aassert%20fibonacci_memoize%285%29%20%3D%3D%205%0A%0A%0A%23%20With%20Functools%20Implementation%0Afrom%20functools%20import%20lru_cache%0A%0A%40lru_cache%28maxsize%3DNone%29%0Adef%20fibonacci_lru%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20return%20fibonacci_lru%28n-1%29%20%2B%20fibonacci_lru%28n-2%29%0A%0Aassert%20fibonacci_lru%285%29%20%3D%3D%205%0Aassert%20fibonacci_lru%285%29%20%3D%3D%205%0A&cumulative=false&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/recursive_memoized_fibonacci-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/recursive_memoized_fibonacci.png }](/blog/images/recursion/recursive_memoized_fibonacci.png){: .gallery }

Depending on the implementation, the effect of memoization is similar to
*linearizing* the multi-recursive function, as the tree has much fewer branches
while the depth is kept the same.

If considering the Fibonacci Fast Doubles implementation of `fibonacci(10)`:

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/non_memoized_fast_double_fibonacci-thumbnail.png){: .b-lazy width=4106 data-src=/blog/images/recursion/non_memoized_fast_double_fibonacci.png }](/blog/images/recursion/non_memoized_fast_double_fibonacci.png){: .gallery }

This can also be reduced (from 15 calls to 11):

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=from%20functools%20import%20wraps%0Afrom%20typing%20import%20Callable,%20TypeVar,%20Any%0A%0AT%20%3D%20TypeVar%28%22T%22%29%0A%0A%23%20With%20Scratch%20Implementation%0Adef%20memoize%28function%3A%20Callable%5B...,%20T%5D%29%20-%3E%20Callable%5B...,%20T%5D%3A%0A%20%20%20%20cache%3A%20dict%5Bstr,%20T%5D%20%3D%20%7B%7D%0A%0A%20%20%20%20%40wraps%28function%29%0A%20%20%20%20def%20wrapper%28*args,%20**kwargs%29%20-%3E%20T%3A%0A%20%20%20%20%20%20%20%20nonlocal%20cache%0A%20%20%20%20%0A%20%20%20%20%20%20%20%20cacheable_args%20%3D%20str%28tuple%28sorted%28args%29%29%20%2B%20tuple%28sorted%28kwargs.items%28%29%29%29%29%0A%20%20%20%20%20%20%20%20if%20cacheable_args%20not%20in%20cache%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20cache%5Bcacheable_args%5D%20%3D%20function%28*args,%20**kwargs%29%0A%20%20%20%20%20%20%20%20return%20cache%5Bcacheable_args%5D%0A%0A%20%20%20%20return%20wrapper%0A%0A%0A%40memoize%0Adef%20fibonacci_memoize%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%23%20Fast%20Doubling%20Method%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20%0A%20%20%20%20is_odd%20%3D%20n%20%25%202%0A%20%20%20%20m%20%3D%20n%20//%202%20%2B%20is_odd%0A%20%20%20%20fib_m%20%3D%20fibonacci_memoize%28m%29%0A%20%20%20%20fib_m_1%20%3D%20fibonacci_memoize%28m%20-%201%29%0A%0A%20%20%20%20if%20is_odd%3A%0A%20%20%20%20%20%20%20%20return%20fib_m_1%20**%202%20%2B%20fib_m%20**%202%0A%20%20%20%20return%202%20*%20fib_m%20*%20fib_m_1%20%2B%20fib_m%20**%202%0A%0Aassert%20fibonacci_memoize%285%29%20%3D%3D%205%0Aassert%20fibonacci_memoize%285%29%20%3D%3D%205%0A%0A%0A%23%20With%20Functools%20Implementation%0Afrom%20functools%20import%20lru_cache%0A%0A%40lru_cache%28maxsize%3DNone%29%0Adef%20fibonacci_lru%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%23%20Fast%20Doubling%20Method%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20%0A%20%20%20%20is_odd%20%3D%20n%20%25%202%0A%20%20%20%20m%20%3D%20n%20//%202%20%2B%20is_odd%0A%20%20%20%20fib_m%20%3D%20fibonacci_lru%28m%29%0A%20%20%20%20fib_m_1%20%3D%20fibonacci_lru%28m%20-%201%29%0A%0A%20%20%20%20if%20is_odd%3A%0A%20%20%20%20%20%20%20%20return%20fib_m_1%20**%202%20%2B%20fib_m%20**%202%0A%20%20%20%20return%202%20*%20fib_m%20*%20fib_m_1%20%2B%20fib_m%20**%202%0A%0Aassert%20fibonacci_lru%285%29%20%3D%3D%205%0Aassert%20fibonacci_lru%285%29%20%3D%3D%205%0A&cumulative=false&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_fast_double_fibonacci-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_fast_double_fibonacci.png }](/blog/images/recursion/memoized_fast_double_fibonacci.png){: .gallery }

Memoization can also be applied to nested recursive functions such as the
`hofstadter_g(4)`:

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/non_memoized_hofstadter_g-thumbnail.png){: .b-lazy width=4106 data-src=/blog/images/recursion/non_memoized_hofstadter_g.png }](/blog/images/recursion/non_memoized_hofstadter_g.png){: .gallery }

Now memoized (from 19 calls to 9):

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=from%20functools%20import%20wraps%0Afrom%20typing%20import%20Callable,%20TypeVar,%20Any%0A%0AT%20%3D%20TypeVar%28%22T%22%29%0A%0A%23%20With%20Scratch%20Implementation%0Adef%20memoize%28function%3A%20Callable%5B...,%20T%5D%29%20-%3E%20Callable%5B...,%20T%5D%3A%0A%20%20%20%20cache%3A%20dict%5Bstr,%20T%5D%20%3D%20%7B%7D%0A%0A%20%20%20%20%40wraps%28function%29%0A%20%20%20%20def%20wrapper%28*args,%20**kwargs%29%20-%3E%20T%3A%0A%20%20%20%20%20%20%20%20nonlocal%20cache%0A%20%20%20%20%0A%20%20%20%20%20%20%20%20cacheable_args%20%3D%20str%28tuple%28sorted%28args%29%29%20%2B%20tuple%28sorted%28kwargs.items%28%29%29%29%29%0A%20%20%20%20%20%20%20%20if%20cacheable_args%20not%20in%20cache%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20cache%5Bcacheable_args%5D%20%3D%20function%28*args,%20**kwargs%29%0A%20%20%20%20%20%20%20%20return%20cache%5Bcacheable_args%5D%0A%0A%20%20%20%20return%20wrapper%0A%0A%0A%40memoize%0Adef%20hofstadter_g_memoize%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20return%20n%20-%20hofstadter_g_memoize%28hofstadter_g_memoize%28n%20-%201%29%29%0A%0Aassert%20hofstadter_g_memoize%285%29%20%3D%3D%203%0Aassert%20hofstadter_g_memoize%285%29%20%3D%3D%203%0A%0A%0A%23%20With%20Functools%20Implementation%0Afrom%20functools%20import%20lru_cache%0A%0A%40lru_cache%28maxsize%3DNone%29%0Adef%20hofstadter_g_lru%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20return%20n%20-%20hofstadter_g_lru%28hofstadter_g_lru%28n%20-%201%29%29%0A%0Aassert%20hofstadter_g_lru%285%29%20%3D%3D%203%0Aassert%20hofstadter_g_lru%285%29%20%3D%3D%203%0A&cumulative=false&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_hofstadter_g-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_hofstadter_g.png }](/blog/images/recursion/memoized_hofstadter_g.png){: .gallery }

Or deeply nested recursive functions like the `hofstadter_h(3)`:

[![Recursive Hofstadter H]({static}images/recursion/recursive_hofstadter_h-thumbnail.png){: .b-lazy width=9794 data-src=/blog/images/recursion/recursive_hofstadter_h.png }](/blog/images/recursion/recursive_hofstadter_h.png){: .gallery }

And now memoized (from 22 to 10 calls)

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=from%20functools%20import%20wraps%0Afrom%20typing%20import%20Callable,%20TypeVar,%20Any%0A%0AT%20%3D%20TypeVar%28%22T%22%29%0A%0A%23%20With%20Scratch%20Implementation%0Adef%20memoize%28function%3A%20Callable%5B...,%20T%5D%29%20-%3E%20Callable%5B...,%20T%5D%3A%0A%20%20%20%20cache%3A%20dict%5Bstr,%20T%5D%20%3D%20%7B%7D%0A%0A%20%20%20%20%40wraps%28function%29%0A%20%20%20%20def%20wrapper%28*args,%20**kwargs%29%20-%3E%20T%3A%0A%20%20%20%20%20%20%20%20nonlocal%20cache%0A%20%20%20%20%0A%20%20%20%20%20%20%20%20cacheable_args%20%3D%20str%28tuple%28sorted%28args%29%29%20%2B%20tuple%28sorted%28kwargs.items%28%29%29%29%29%0A%20%20%20%20%20%20%20%20if%20cacheable_args%20not%20in%20cache%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20cache%5Bcacheable_args%5D%20%3D%20function%28*args,%20**kwargs%29%0A%20%20%20%20%20%20%20%20return%20cache%5Bcacheable_args%5D%0A%0A%20%20%20%20return%20wrapper%0A%0A%0A%40memoize%0Adef%20hofstadter_h_memoize%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20return%20n%20-%20hofstadter_h_memoize%28hofstadter_h_memoize%28hofstadter_h_memoize%28n%20-%201%29%29%29%0A%0Aassert%20hofstadter_h_memoize%285%29%20%3D%3D%204%0Aassert%20hofstadter_h_memoize%285%29%20%3D%3D%204%0A%0A%0A%23%20With%20Functools%20Implementation%0Afrom%20functools%20import%20lru_cache%0A%0A%40lru_cache%28maxsize%3DNone%29%0Adef%20hofstadter_h_lru%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20return%20n%20-%20hofstadter_h_lru%28hofstadter_h_lru%28hofstadter_h_lru%28n%20-%201%29%29%29%0A%0Aassert%20hofstadter_h_lru%285%29%20%3D%3D%204%0Aassert%20hofstadter_h_lru%285%29%20%3D%3D%204%0A&cumulative=false&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_hofstadter_h-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_hofstadter_h.png }](/blog/images/recursion/memoized_hofstadter_h.png){: .gallery }

The same applies to more complex functions like the Ackermann function with
`Ackermann(2, 3)`:

[![Recursive Ackerman]({static}images/recursion/recursive_ackermann-thumbnail.png){: .b-lazy width=6185 data-src=/blog/images/recursion/recursive_ackermann.png }](/blog/images/recursion/recursive_ackermann.png){: .gallery }

And now memoized (from 44 calls to 23):

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=from%20functools%20import%20wraps%0Afrom%20typing%20import%20Callable,%20TypeVar,%20Any%0A%0AT%20%3D%20TypeVar%28%22T%22%29%0A%0A%23%20With%20Scratch%20Implementation%0Adef%20memoize%28function%3A%20Callable%5B...,%20T%5D%29%20-%3E%20Callable%5B...,%20T%5D%3A%0A%20%20%20%20cache%3A%20dict%5Bstr,%20T%5D%20%3D%20%7B%7D%0A%0A%20%20%20%20%40wraps%28function%29%0A%20%20%20%20def%20wrapper%28*args,%20**kwargs%29%20-%3E%20T%3A%0A%20%20%20%20%20%20%20%20nonlocal%20cache%0A%20%20%20%20%0A%20%20%20%20%20%20%20%20cacheable_args%20%3D%20str%28tuple%28sorted%28args%29%29%20%2B%20tuple%28sorted%28kwargs.items%28%29%29%29%29%0A%20%20%20%20%20%20%20%20if%20cacheable_args%20not%20in%20cache%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20cache%5Bcacheable_args%5D%20%3D%20function%28*args,%20**kwargs%29%0A%20%20%20%20%20%20%20%20return%20cache%5Bcacheable_args%5D%0A%0A%20%20%20%20return%20wrapper%0A%0A%0A%40memoize%0Adef%20ackermann_memoize%28m%3A%20int,%20n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20m%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%20n%20%2B%201%0A%20%20%20%20if%20m%20%3E%200%20and%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%20ackermann_memoize%28m%20-%201,%201%29%20%20%20%20%0A%20%20%20%20return%20ackermann_memoize%28m%20-%201,%20ackermann_memoize%28m,%20n%20-%201%29%29%0A%0Aassert%20ackermann_memoize%282,%202%29%20%3D%3D%207%0Aassert%20ackermann_memoize%282,%202%29%20%3D%3D%207%0A%0A%0A%23%20With%20Functools%20Implementation%0Afrom%20functools%20import%20lru_cache%0A%0A%40lru_cache%28maxsize%3DNone%29%0Adef%20ackermann_lru%28m%3A%20int,%20n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20m%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%20n%20%2B%201%0A%20%20%20%20if%20m%20%3E%200%20and%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%20ackermann_lru%28m%20-%201,%201%29%20%20%20%20%0A%20%20%20%20return%20ackermann_lru%28m%20-%201,%20ackermann_lru%28m,%20n%20-%201%29%29%0A%0Aassert%20ackermann_lru%282,%202%29%20%3D%3D%207%0Aassert%20ackermann_lru%282,%202%29%20%3D%3D%207%0A&cumulative=false&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_ackermann-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_ackermann.png }](/blog/images/recursion/memoized_ackermann.png){: .gallery }


Memoization can also be used for mutual recursive functions, the following
examples show the mutual fibonacci-lucas recursion and  the Hofstadter
female-male


Multi recursive fibonacci-lucas:

[![Mutual Recursive Fibonacci]({static}images/recursion/mutual_recursive_fibonacci-thumbnail.png){: .b-lazy width=5365 data-src=/blog/images/recursion/mutual_recursive_fibonacci.png }](/blog/images/recursion/mutual_recursive_fibonacci.png){: .gallery }

And now memoized (from 26 to 13):

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=from%20functools%20import%20wraps%0Afrom%20typing%20import%20Callable,%20TypeVar,%20Any%0A%0AT%20%3D%20TypeVar%28%22T%22%29%0A%0A%23%20With%20Scratch%20Implementation%0Adef%20memoize%28function%3A%20Callable%5B...,%20T%5D%29%20-%3E%20Callable%5B...,%20T%5D%3A%0A%20%20%20%20cache%3A%20dict%5Bstr,%20T%5D%20%3D%20%7B%7D%0A%0A%20%20%20%20%40wraps%28function%29%0A%20%20%20%20def%20wrapper%28*args,%20**kwargs%29%20-%3E%20T%3A%0A%20%20%20%20%20%20%20%20nonlocal%20cache%0A%20%20%20%20%0A%20%20%20%20%20%20%20%20cacheable_args%20%3D%20str%28tuple%28sorted%28args%29%29%20%2B%20tuple%28sorted%28kwargs.items%28%29%29%29%29%0A%20%20%20%20%20%20%20%20if%20cacheable_args%20not%20in%20cache%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20cache%5Bcacheable_args%5D%20%3D%20function%28*args,%20**kwargs%29%0A%20%20%20%20%20%20%20%20return%20cache%5Bcacheable_args%5D%0A%0A%20%20%20%20return%20wrapper%0A%0A%0A%40memoize%0Adef%20lucas_memoize%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%202%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20return%202%20*%20fibonacci_memoize%28n%29%20-%20fibonacci_memoize%28n-1%29%20%2B%20lucas_memoize%28n-2%29%0A%0A%40memoize%0Adef%20fibonacci_memoize%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20return%20%28fibonacci_memoize%28n-1%29%20%2B%20lucas_memoize%28n-1%29%29%20//%202%0A%0Aassert%20lucas_memoize%284%29%20%3D%3D%207%0Aassert%20lucas_memoize%284%29%20%3D%3D%207%0Aassert%20fibonacci_memoize%284%29%20%3D%3D%203%0Aassert%20fibonacci_memoize%284%29%20%3D%3D%203%0A%0A%0A%23%20With%20Functools%20Implementation%0Afrom%20functools%20import%20lru_cache%0A%0A%40lru_cache%28maxsize%3DNone%29%0Adef%20lucas_lru%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%202%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20return%202%20*%20fibonacci_lru%28n%29%20-%20fibonacci_lru%28n-1%29%20%2B%20lucas_lru%28n-2%29%0A%0A%40lru_cache%28maxsize%3DNone%29%0Adef%20fibonacci_lru%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20return%20%28fibonacci_lru%28n-1%29%20%2B%20lucas_lru%28n-1%29%29%20//%202%0A%0Aassert%20lucas_lru%284%29%20%3D%3D%207%0Aassert%20lucas_lru%284%29%20%3D%3D%207%0Aassert%20fibonacci_lru%284%29%20%3D%3D%203%0Aassert%20fibonacci_lru%284%29%20%3D%3D%203%0A&cumulative=false&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_mutual_recursive_fibonacci-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_mutual_recursive_fibonacci.png }](/blog/images/recursion/memoized_mutual_recursive_fibonacci.png){: .gallery }


And the hofstadter female-male recursion:

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/mutual_recursive_hofstadter_female-thumbnail.png){: .b-lazy width=5290 data-src=/blog/images/recursion/mutual_recursive_hofstadter_female.png }](/blog/images/recursion/mutual_recursive_hofstadter_female.png){: .gallery }

And now memoized (from 15 to 11 calls)

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=from%20functools%20import%20wraps%0Afrom%20typing%20import%20Callable,%20TypeVar,%20Any%0A%0AT%20%3D%20TypeVar%28%22T%22%29%0A%0A%23%20With%20Scratch%20Implementation%0Adef%20memoize%28function%3A%20Callable%5B...,%20T%5D%29%20-%3E%20Callable%5B...,%20T%5D%3A%0A%20%20%20%20cache%3A%20dict%5Bstr,%20T%5D%20%3D%20%7B%7D%0A%0A%20%20%20%20%40wraps%28function%29%0A%20%20%20%20def%20wrapper%28*args,%20**kwargs%29%20-%3E%20T%3A%0A%20%20%20%20%20%20%20%20nonlocal%20cache%0A%20%20%20%20%0A%20%20%20%20%20%20%20%20cacheable_args%20%3D%20str%28tuple%28sorted%28args%29%29%20%2B%20tuple%28sorted%28kwargs.items%28%29%29%29%29%0A%20%20%20%20%20%20%20%20if%20cacheable_args%20not%20in%20cache%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20cache%5Bcacheable_args%5D%20%3D%20function%28*args,%20**kwargs%29%0A%20%20%20%20%20%20%20%20return%20cache%5Bcacheable_args%5D%0A%0A%20%20%20%20return%20wrapper%0A%0A%0A%40memoize%0Adef%20hofstadter_female_memoize%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20return%20n%20-%20hofstadter_male_memoize%28hofstadter_female_memoize%28n%20-%201%29%29%0A%0A%40memoize%0Adef%20hofstadter_male_memoize%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20return%20n%20-%20hofstadter_female_memoize%28hofstadter_male_memoize%28n%20-%201%29%29%0A%0Aassert%20hofstadter_female_memoize%284%29%20%3D%3D%203%0Aassert%20hofstadter_female_memoize%284%29%20%3D%3D%203%0Aassert%20hofstadter_male_memoize%284%29%20%3D%3D%202%0Aassert%20hofstadter_male_memoize%284%29%20%3D%3D%202%0A%0A%0A%23%20With%20Functools%20Implementation%0Afrom%20functools%20import%20lru_cache%0A%0A%40lru_cache%28maxsize%3DNone%29%0Adef%20hofstadter_female_lru%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%201%0A%20%20%20%20return%20n%20-%20hofstadter_male_lru%28hofstadter_female_lru%28n%20-%201%29%29%0A%0A%40lru_cache%28maxsize%3DNone%29%0Adef%20hofstadter_male_lru%28n%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20return%20n%20-%20hofstadter_female_lru%28hofstadter_male_lru%28n%20-%201%29%29%0A%0Aassert%20hofstadter_female_memoize%284%29%20%3D%3D%203%0Aassert%20hofstadter_female_memoize%284%29%20%3D%3D%203%0Aassert%20hofstadter_male_memoize%284%29%20%3D%3D%202%0Aassert%20hofstadter_male_memoize%284%29%20%3D%3D%202%0A&cumulative=false&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

[![Mutual Recursive Fibonacci Alternative]({static}images/recursion/memoized_hofstadter_female-thumbnail.png){: .b-lazy width=2125 data-src=/blog/images/recursion/memoized_hofstadter_female.png }](/blog/images/recursion/memoized_hofstadter_female.png){: .gallery }


Taking the `fibonacci(100)` example from the previous section, when
incorporating the memoized approach the results change substantially:

- Typical Multi Recursive Implementation: 1,146,295,688,027,634,168,203 calls ≈
  1 sextillion calls
- Memoized Typical Multi-Recursive Implementation: 199 calls
  (0.00000000000000002% of the original)
- Fast Doubles: 163 calls
- Tail Recursive Implementation (Memoization has no effect): 100 calls
- Memoized Fast Doubles: 29 calls (17.79% of the original)
- Linear Recursive Implementation (Memoization has no effect): 8 calls

Since the tail recursive and the linear recursive implementation do not have
repeated calls, memoization has no effect.

## Trampolining

Another restriction that many languages (such as Python) have is call stack
overflow, this happens when there are too many recursive calls in the call
stack. It is possible with minimal modifications to the original functions to
surpass this limitation and make the language treat the recursive function as an
iteration and thus bypass the overflow. This technique is called
[**trampoline**](https://en.wikipedia.org/wiki/Trampoline_(computing)){: target="_blank"} and requires the function to be implemented in
**tail-recursive** form.

Moreover, the function should **defer the evaluation** of the tail call by using
an anonymous function (in Python called `lambda`s). This step is needed to
simulate a lazy evaluation.

The following is an example of how to implement the tail recursive Fibonacci
using trampolining for `fibonacci(10000)` which would normally cause
[`RecursionError`](https://docs.python.org/3/library/exceptions.html#RecursionError){: target="_blank"}.

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20trampoline%28function_or_result%29%3A%0A%20%20%20%20if%20not%20callable%28function_or_result%29%3A%0A%20%20%20%20%20%20%20%20return%20function_or_result%0A%0A%20%20%20%20while%20callable%28function_or_result%29%3A%0A%20%20%20%20%20%20%20%20function_or_result%20%3D%20function_or_result%28%29%0A%0A%20%20%20%20return%20function_or_result%0A%0A%0Adef%20fibonacci%28%0A%20%20%20%20n%3A%20int,%20partial_result%3A%20int%20%3D%200,%20result%3A%20int%20%3D%201%0A%29%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%20result%0A%0A%20%20%20%20return%20lambda%3A%20fibonacci%28n%20-%201,%20result,%20partial_result%20%2B%20result%29%0A%0A%0Aassert%20trampoline%28fibonacci%2830%29%29%20%3D%3D%20832040&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
from __future__ import annotations

from typing import TypeVar, Callable, TypeAlias

T = TypeVar("T")
TrampolineFunction: TypeAlias = "Callable[[], T | TrampolineFunction[T]]"

def trampoline(function_or_result: T | TrampolineFunction[T]) -> T:
    if not callable(function_or_result):
        return function_or_result

    while callable(function_or_result):
        function_or_result = function_or_result()

    return function_or_result

def fibonacci(
    n: int, partial_result: int = 0, result: int = 1
) -> int | TrampolineFunction[int]:
    if n == 0:
        return 0
    if n == 1:
        return result

    return lambda: fibonacci(n - 1, result, partial_result + result)

assert str(trampoline(fibonacci(10000))).startswith("3364476487")
```

This way of programming has several similarities with the [continuation passing
style](https://en.wikipedia.org/wiki/Continuation-passing_style){:target="_blank"}
since instead of executing the command, the function defers the execution to
another function which in the end runs the command. In Object Oriented
Programming similar behavior could have been achieved using the [Command
Pattern](https://en.wikipedia.org/wiki/Command_pattern){:target="_blank"}.

This particular implementation has a significant drawback, it hinders debugging
and makes it less transparent, as can be seen in the run step-by-step example.
This is the reason why the author of Python [rejected the
proposal](http://neopythonic.blogspot.com/2009/04/tail-recursion-elimination.html){:target="_blank"}
to incorporate tail call optimization into the language.

The implementation above using `lambda`s is typical of other languages like
Javascript. In Python, it is possible to implement it in a different way
following [Guido's
approach](http://neopythonic.blogspot.com/2009/04/final-words-on-tail-calls.html){:target="_blank"}
which makes debugging easier and less cryptic. On the other hand, types become a
bit more convoluted.

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=def%20trampoline%28function,%20args%29%3A%0A%20%20%20%20result%20%3D%20function%28*args%29%0A%0A%20%20%20%20while%20hasattr%28result,%20%22__iter__%22%29%3A%0A%20%20%20%20%20%20%20%20function,%20args%20%3D%20result%0A%20%20%20%20%20%20%20%20result%20%3D%20function%28*args%29%0A%0A%20%20%20%20return%20result%0A%0Adef%20fibonacci%28%0A%20%20%20%20n%3A%20int,%20partial_result%3A%20int%20%3D%200,%20result%3A%20int%20%3D%201%0A%29%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%20result%0A%20%20%20%20%0A%20%20%20%20args%20%3D%20%28n-1,%20result,%20partial_result%20%2B%20result%29%0A%20%20%20%20return%20fibonacci,%20args%0A%0Aassert%20trampoline%28fibonacci,%20%2830,%20%29%29%20%3D%3D%20832040&cumulative=false&heapPrimitives=nevernest&mode=edit&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
from __future__ import annotations

from typing import TypeVar, Callable, TypeAlias, Iterable, cast

T = TypeVar("T")

TrampolineFunction: TypeAlias = "Callable[..., T | TrampolineResult[T] | T]"
TrampolineArgs = Iterable[T]
TrampolineResult: TypeAlias = "tuple[TrampolineFunction[T], TrampolineArgs[T]]"

def trampoline(function: TrampolineFunction[T], args: TrampolineArgs[T]) -> T:
    result = function(*args)

    while isinstance(result, Iterable):
        result = cast("TrampolineResult[T]", result)
        function, args = result
        result = function(*args)

    return result

def fibonacci(
    n: int, partial_result: int = 0, result: int = 1
) -> tuple[TrampolineFunction[int], tuple[int, int, int]] | int:
    if n == 0:
        return 0
    if n == 1:
        return result

    return fibonacci, (n - 1, result, partial_result + result)

assert str(trampoline(fibonacci, (10000,))).startswith("3364476487")
```

A combination of the previous two approaches can also be achieved by using
[partial
evaluation](https://en.wikipedia.org/wiki/Partial_evaluation?oldformat=true){:target="_blank"}
through `functools.partial`. This way, the code is simpler and more similar to
what one could find in other languages while still being easy to debug:

[Run Step by Step Online](https://pythontutor.com/visualize.html#code=from%20functools%20import%20partial%0A%0Adef%20trampoline%28function_or_result%29%3A%0A%20%20%20%20if%20not%20callable%28function_or_result%29%3A%0A%20%20%20%20%20%20%20%20return%20function_or_result%0A%0A%20%20%20%20while%20callable%28function_or_result%29%3A%0A%20%20%20%20%20%20%20%20function_or_result%20%3D%20function_or_result%28%29%0A%0A%20%20%20%20return%20function_or_result%0A%0Adef%20fibonacci%28%0A%20%20%20%20n%3A%20int,%20partial_result%3A%20int%20%3D%200,%20result%3A%20int%20%3D%201%0A%29%3A%0A%20%20%20%20if%20n%20%3D%3D%200%3A%0A%20%20%20%20%20%20%20%20return%200%0A%20%20%20%20if%20n%20%3D%3D%201%3A%0A%20%20%20%20%20%20%20%20return%20result%0A%0A%20%20%20%20return%20partial%28%0A%20%20%20%20%20%20%20%20fibonacci,%0A%20%20%20%20%20%20%20%20n%3Dn%20-%201,%0A%20%20%20%20%20%20%20%20partial_result%3Dresult,%0A%20%20%20%20%20%20%20%20result%3Dpartial_result%20%2B%20result%0A%20%20%20%20%29%0A%0Aassert%20trampoline%28fibonacci%2830%29%29%20%3D%3D%20832040&cumulative=false&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false){: target="_blank"}

```python
from __future__ import annotations

from functools import partial
from typing import TypeVar, Callable, TypeAlias

T = TypeVar("T")
TrampolineFunction: TypeAlias = "Callable[[], T | TrampolineFunction[T]]"

def trampoline(function: T | TrampolineFunction[T]) -> T:
    if not callable(function):
        return function

    while callable(function):
        function = function()

    return function

def fibonacci(
    n: int, partial_result: int = 0, result: int = 1
) -> int | TrampolineFunction[int]:
    if n == 0:
        return 0
    if n == 1:
        return result

    return partial(
        fibonacci, n=n - 1, partial_result=result, result=partial_result + result
    )

assert str(trampoline(fibonacci(10000))).startswith("3364476487")
```

Trampolines allow to convert of recursive function calls into iterations. There
is no built-in support like with the memoized technique and due to technical
limitations, it is not possible to implement them as decorators, which would
reduce the changes needed on the original function. The different
implementations shown should give a grasp of what is possible and how it could
be applied to other functions.

It is also possible to modify the default configuration of the interpreter to
allow deeper recursions though. This can be done by setting a higher value to
the
[`sys.setrecursionlimit`](https://docs.python.org/3/library/sys.html#sys.setrecursionlimit){:target="_blank"}.
This method requires however access to the `sys` module which may not be always
available or editable.

## Call-By-Need

Some programming languages execute instructions following a [non-strict binding
strategy](https://en.wikipedia.org/wiki/Evaluation_strategy#Non-strict_binding_strategies){: target="_blank"}, that is, the parameters of a function are not evaluated before
the function is called. One such strategy is called
[call-by-need](https://en.wikipedia.org/wiki/Evaluation_strategy#Call_by_need),
which only evaluates the parameters when needed in the body of the function and
caches them in case they are re-used.

When using recursive functions in languages that support call-by-need (like
Haskell or R), the execution could be optimized as only a subset of all the
recursive calls might be evaluated, thus reducing the cost of recursive
functions.

## Conclusion

Recursion is a diverse topic that can be used as leverage to overcome
challenging problems, improve readability and facilitate the use of recursive
data structures. In Python, it is possible to use recursion with some
limitations, those could be mitigated by using memoization or trampolines. Other
languages may use different strategies such as call-by-need or tail-call
optimization.

Every program written in iterative form can be rewritten in recursive form, it
is a good exercise to practice and gain intuition about recursion and when it
can be applied.

In the end, recursion is another tool, it can be used everywhere but that is not
necessarily the best decision always, analyzing the context and the
cost-benefits is important.

If recursion is the way to go, aim for tail recursion if possible or to leverage
memoization.

Some challenges for the reader to practice recursion:

- Write a function that determines if a number is prime
- Write the addition, multiplication and exponentiation functions
- Write a function that computes a running average of a sequence of numbers
