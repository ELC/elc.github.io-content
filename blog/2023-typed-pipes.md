Title: Type-Safe Pipelines and Compose
Date: 2023-09-23
Category: Programming 
Tags: Python, Types, Pipelines
Slug: typed-pipes
Authors: Ezequiel Leonardo Castaño 
Lang: en 
Headerimage: https://elc.github.io/blog/images/typed-pipes/type_pipes_headerimage.png

[![Typed Pipes in Python]({static}images/typed-pipes/type_pipes_headerimage-thumbnail.png){: .b-lazy width=1683 data-src=/blog/images/typed-pipes/type_pipes_headerimage.png }](/blog/images/typed-pipes/type_pipes_headerimage.png){: .gallery }

<!-- PELICAN_BEGIN_SUMMARY -->

When dealing with multiple transformations that run sequentially, one could
leverage the compose function to create pipelines. This article shows different
way to implement them in a type-safe way. All the code was written using pure
Python 3.11 and MyPy 1.5.1 and PyLance v2023.9.20

<!-- PELICAN_END_SUMMARY -->

## Function Composition

There are two notations for function composition one with a right-to-left
direction and one with a left-to-right direction. Namely:

Right to left:

$$f∘g = f(g(x))$$

Left to right:

$$f∘g = g(f(x))$$

The traditional notation in math is the right-to-left one. Some languages like
Haskell has built-in syntax for both. In Haskell the usual way to do composition
is with `.` which is right-to-left, it is also possible to use `>>>` for
left-to-right composition. 

On the other hand, one of the most common ways to compose functions in
programming is through Unix Pipes which use the `|` operator, which conversely
is left-to-right composition.

That means that when implementing a `compose` or a `pipe` function is not
trivial which orientation to choose as they are competing notations. In the
context of programming the left to right orientation is more common.

All the examples here will use the left-to-right orientation.

## The compose function

The compose function is a function that takes two functions `f` and `g` and
returns a new function that performs `g` and then `f`. In Python, a generic
implementation looks like this:

```python
def compose(f, g):
    def inner(*args, **kwargs):
        return g(f(*args, **kwargs))
    return inner
```

For this to work, it is necessary that the output of `f` matches the input of
`g`, or otherwise the execution may fail. To enforce this relationship a typed
version of the composed can be written as follows:

```python
from typing import Callable, ParamSpec, TypeVar

T = TypeVar("T")
U = TypeVar("U")
P = ParamSpec("P")

def compose(f: Callable[P, T], g: Callable[[T], U]) -> Callable[P, U]:
    def inner(*args: P.args, **kwargs: P.kwargs) -> U:
        return g(f(*args, **kwargs))
    return inner
```

This implementation uses Python 3.10's `ParamSpec`, which allows typing `*args`
and `**kwargs`.

Having a typed version is important as one typical case is composing multiple
functions and if the types are not enforced, unexpected behavior could arise.

One example of using this compose implementation is the following:

```python
def add_one(x: int) -> int:
    return x + 1

def convert_to_string(x: int) -> str:
    return str(x)

composed_functions = compose(add_one, convert_to_string)
```

When using the typed version, both MyPy and Pyright can infer the resulting type:

Pyright (through Pylance)

[![Alt Text]({static}images/typed-pipes/compose_pylance-thumbnail.png){: .b-lazy .narrow width=870 data-src=/blog/images/typed-pipes/compose_pylance.png }](/blog/images/typed-pipes/compose_pylance.png){: .gallery }

MyPy

[![Alt Text]({static}images/typed-pipes/compose_mypy-thumbnail.png){: .b-lazy width=1070 data-src=/blog/images/typed-pipes/compose_mypy.png }](/blog/images/typed-pipes/compose_mypy.png){: .gallery }


One important aspect of function composition is that it is not commutative, that
is $$f∘g \neq g∘f$$. There may be cases where both are equivalent but most of
the time it is not.

This is helpful when programming as the IDE can automatically detect and flag
types' incompatibility. Take for example trying to `add_one` to the result of
`convert_to_string`.

```python
composed_incorrect = compose(convert_to_string, add_one)
```

Pyright (through Pylance)

[![Alt Text]({static}images/typed-pipes/compose_pylance_error-thumbnail.png){: .b-lazy .narrow width=771 data-src=/blog/images/typed-pipes/compose_pylance_error.png }](/blog/images/typed-pipes/compose_pylance_error.png){: .gallery }

MyPy

[![Alt Text]({static}images/typed-pipes/compose_mypy_error-thumbnail.png){: .b-lazy .narrow width=926 data-src=/blog/images/typed-pipes/compose_mypy_error.png }](/blog/images/typed-pipes/compose_mypy_error.png){: .gallery }

The error from MyPy may not be descriptive enough but it at least points in the
right direction. Pyright can identify the exact cause of the problem:
`add_one` takes an `int` but it receives an `str` as the output of
`convert_to_string`.

## Extension to multiple functions

With that generic `compose` function, it is possible to compose any number of
functions, however, the syntax is a little convoluted. These are the three
sample functions to compose, one is `int` to `int`, another one is `int` to
`str` and the last one is `str` to `str`, it is also interesting to use built-in
functions such as `len` and `str` instead of user-defined ones.

```python
def add_one(x: int) -> int:
    return x + 1

def convert_to_string(x: int) -> str:
    return str(x)

def sort_characters(x: str) -> str:
    return "".join(sorted(x))
```

The composition of interest is the one that would be equivalent to doing:

```python
def user_defined_composition(x: int) -> int:
    return str(len(sort_characters(convert_to_string(add_one(x)))))
```

It is valid Python to create a function like that, but, it is difficult to read
and to change since the "application order" as well as the final "type mapping"
is hardcoded. Any variation would require a different signature and invocation
order.

To leverage the generic `compose`, one alternative would be to write:

```python
user_defined_composition = compose(
    compose(compose(compose(add_one, convert_to_string), sort_characters), len), str
)
assert user_defined_composition(2) == "1"
```

Or equivalently:

```python
user_defined_composition = (
    compose(
        compose(
            compose(
                compose(add_one, convert_to_string),
                sort_characters
            ),
            len
        ),
        str
    )
)
assert user_defined_composition(2) == "1"
```

**Note**: both approaches are valid and threw no errors when scanned with MyPy,
nevertheless, Pyright is not able to fully detect the types.

Pyright:

[![Alt Text]({static}images/typed-pipes/compose_test_pyright_types-thumbnail.png){: .b-lazy .narrow width=795 data-src=/blog/images/typed-pipes/compose_test_pyright_types.png }](/blog/images/typed-pipes/compose_test_pyright_types.png){: .gallery }

[![Alt Text]({static}images/typed-pipes/compose_test_pyright_problems-thumbnail.png){: .b-lazy width=1095 data-src=/blog/images/typed-pipes/compose_test_pyright_problems.png }](/blog/images/typed-pipes/compose_test_pyright_problems.png){: .gallery }

MyPy:

[![Alt Text]({static}images/typed-pipes/compose_test_mypy_type-thumbnail.png){: .b-lazy width=1072 data-src=/blog/images/typed-pipes/compose_test_mypy_type.png }](/blog/images/typed-pipes/compose_test_mypy_type.png){: .gallery }

Neither of the previous is any easier to read than the original one. Some
languages do have a compact syntax for this use case. Haskell's `.` is an
example of clear and concise syntax (Haskell has right to left application):

```haskell
user_defined_composition = str . len . sort_characters . convert_to_string . add_one
```

This by no means implies that Python is not a good fit for composing functions,
it just lacks built-in syntax to make it more approachable. Even though the
previous example would work without issues, in the following sections easier and
more practical alternatives will be introduced.

## Naive Iterative Pipe

The simplest evolution of `compose` to multiple functions in a cleaner way would
be to wrap it in a for-loop:

```python
from typing import Any, Callable

def pipe_iterative(*functions: Callable[..., Any]) -> Callable[..., Any]:
    composed_function, *rest = functions
    for function in rest:
        composed_function = compose(composed_function, function)
    return composed_function

user_defined_composition = pipe_iterative(
    add_one,
    convert_to_string,
    sort_characters,
    len,
    str
)
assert user_defined_composition(2) == "1"
```

This approach, albeit it will work, loses all the type information.

Pyright:

[![Alt Text]({static}images/typed-pipes/pipe_iterative_test_pyright_types-thumbnail.png){: .b-lazy .narrow width=691 data-src=/blog/images/typed-pipes/pipe_iterative_test_pyright_types.png }](/blog/images/typed-pipes/pipe_iterative_test_pyright_types.png){: .gallery }

MyPy:
[![Alt Text]({static}images/typed-pipes/pipe_iterative_test_mypy_types-thumbnail.png){: .b-lazy .narrow width=825 data-src=/blog/images/typed-pipes/pipe_iterative_test_mypy_types.png }](/blog/images/typed-pipes/pipe_iterative_test_mypy_types.png){: .gallery }

At the moment, it is not possible to type `*functions` so that Python infers
that each of the functions will have an output type that will match the next
functions's input type.

It is possible though to type the `pipe_iterative` function if we assume that
all input and output types will be the same:

```python
from typing import Callable, TypeVar

T = TypeVar("T")

def pipe_iterative(*functions: Callable[[T], T]) -> Callable[[T], T]:
    ...
```

This signature is only applicable to a small subset of the possible function
compositions and will throw several errors with the functions used in the
previous examples.

Pyright:

In this case, the types are compatible with the `pipe_iterative` signature but
are not what the function will expect.

[![Alt Text]({static}images/typed-pipes/pipe_iterative_test_same_type_pyright_types-thumbnail.png){: .b-lazy .narrow width=707 data-src=/blog/images/typed-pipes/pipe_iterative_test_same_type_pyright_types.png }](/blog/images/typed-pipes/pipe_iterative_test_same_type_pyright_types.png){: .gallery }

[![Alt Text]({static}images/typed-pipes/pipe_iterative_test_same_type_pyright_problems-thumbnail.png){: .b-lazy .narrow width=938 data-src=/blog/images/typed-pipes/pipe_iterative_test_same_type_pyright_problems.png }](/blog/images/typed-pipes/pipe_iterative_test_same_type_pyright_problems.png){: .gallery }

MyPy

MyPy detects the conflicting types and assumes `Any` will be the input and
output types.

[![Alt Text]({static}images/typed-pipes/pipe_iterative_test_same_type_mypy_types-thumbnail.png){: .b-lazy width=1074 data-src=/blog/images/typed-pipes/pipe_iterative_test_same_type_mypy_types.png }](/blog/images/typed-pipes/pipe_iterative_test_same_type_mypy_types.png){: .gallery }

[![Alt Text]({static}images/typed-pipes/pipe_iterative_test_same_type_mypy_problems-thumbnail.png){: .b-lazy .narrow width=924 data-src=/blog/images/typed-pipes/pipe_iterative_test_same_type_mypy_problems.png }](/blog/images/typed-pipes/pipe_iterative_test_same_type_mypy_problems.png){: .gallery }

Disagreeing two typing tools like this may be misleading and can cause issues
down the line. Pylance's error message is much more detailed and helpful in this
instance.

If this type of composition is required though, there is a cleaner way of using
the `functools` module.

## Reduced Pipe

When a function takes an input type `T`, returns the same type, and has one
identity element, it is said to be a *Monoid*. It is a common word in the
Functional Programming jargon. The last signature of `pipe_iterative` follows
this pattern since it always keeps its outputs and inputs within the type `T`.

**Note**: The definition of a *Monoid* includes the identity element, since
pipes operate over functions, the identity element is a function that can be
composed without altering the result. This is trivially doable in Python:

```python
from typing import TypeVar

T = TypeVar("T")

def identity(x: T) -> T:
    return x
```

There is a function that achieves the same and is built-in, the
`functools.reduce`. The pipe function can then be rewritten as follows:

```python
from functools import reduce
from typing import Any, Callable

def pipe(*functions: Callable[..., Any]) -> Callable[..., Any]:
    return reduce(compose, functions)

user_defined_composition = pipe(
    add_one,
    convert_to_string,
    sort_characters,
    len,
    str
)
assert user_defined_composition(2) == "1"
```

The same considerations could be made about the signature, this implementation
can either be type-safe and only operate on a single type `T` or it could be
used more generically as the previous `pipe_iterative` while losing type
information.

Since the signature is the same, MyPy and Pyright show the same messages.

There is a way to circumvent this issue and that is through the use of
`Generic`s. Where types become an additional parameter. In Python, `Generic`s
can only be used in classes, therefore the next sections will migrate to an
object-oriented programming style.

## Why Types matter

If the previous is a working implementation, why bother with adding types? There
is a rising number of articles and online material arguing in favor of adding
types. A summary could be the following.

Reasons to add types:

- Typed code produces fewer bugs
- Typed code enables enforcement of input and output compatibility 
- Typed code can be checked statically, i.e. without running the code
- Typed code is easier to test comprehensively
- Typed code is easier to validate. See Pydantic for example
- Typed code is less ambiguous

There are also some reasons not to add types, namely:

- Types make the code more verbose
- Types make the learning curve for a codebase steeper
- <strike>Types are not supported in all versions</strike>. All stable versions support types
  (3.8+).
- <strike>Some Type constructs, like ParamSpec are not available in old versions</strike>.
  Use `typing_extensions` if something is not supported

And it is also important to clarify some myths

- Types will not make the code slower, they are ignored at runtime
- Types are not checked at runtime, they are just used by tools like IDEs and
  Linters

## Eager Monoidal Pipe

Before diving too deep into different alternatives, the first step would be to
replicate what the previous `pipe` function achieved but now supporting
different types.

```python
from __future__ import annotations

from dataclasses import dataclass
from typing import Callable, Generic, TypeVar

T = TypeVar("T")
U = TypeVar("U")

@dataclass
class PipeEagerSameType(Generic[T]):
    x: T

    def then(self, f: Callable[[T], T]) -> PipeEagerSameType[T]:
        self.x = f(self.x)
        return self

    def __call__(self) -> T:
        return self.x

user_defined_composition = (
    PipeEagerSameType(2)
    .then(add_one)
    .then(convert_to_string)
    .then(sort_characters)
    .then(len)
    .then(str)
)
assert user_defined_composition() == "1"
assert user_defined_composition.x == "1"
```

The implementation is straightforward, the class stores the initial value `x`,
and then when `then` is called, that value is transformed and saved. This method
returns `self` to provide a 
[**Fluent Interface**](https://en.wikipedia.org/wiki/Fluent_interface){: target="_blank"}.
that makes the code easier to read. 


The result at the end could be obtained by either calling the instance and thus
executing `__call__` or by simply accessing `x`. The former approach makes the
instance behave like a function and the latter like a plain object.

This first implementation using object-oriented programming produces similar yet
different messages from both Pyright and MyPy:

Pyright:

The errors are analogous to the implementation using `reduce`.

[![Alt Text]({static}images/typed-pipes/pipe_eager_same_type_pyright_types-thumbnail.png){: .b-lazy .narrow width=793 data-src=/blog/images/typed-pipes/pipe_eager_same_type_pyright_types.png }](/blog/images/typed-pipes/pipe_eager_same_type_pyright_types.png){: .gallery }

[![Alt Text]({static}images/typed-pipes/pipe_eager_same_type_pyright_problems-thumbnail.png){: .b-lazy .narrow width=679 data-src=/blog/images/typed-pipes/pipe_eager_same_type_pyright_problems.png }](/blog/images/typed-pipes/pipe_eager_same_type_pyright_problems.png){: .gallery }

MyPy:

This time the errors are much more descriptive and resemble those produced by
Pyright.

[![Alt Text]({static}images/typed-pipes/pipe_eager_same_type_mypy_types-thumbnail.png){: .b-lazy width=1064 data-src=/blog/images/typed-pipes/pipe_eager_same_type_mypy_types.png }](/blog/images/typed-pipes/pipe_eager_same_type_mypy_types.png){: .gallery }

[![Alt Text]({static}images/typed-pipes/pipe_eager_same_type_mypy_problems-thumbnail.png){: .b-lazy width=1357 data-src=/blog/images/typed-pipes/pipe_eager_same_type_mypy_problems.png }](/blog/images/typed-pipes/pipe_eager_same_type_mypy_problems.png){: .gallery }

Now, whenever we inspect the type, both pyright and Mypy will output the class
name and the type will be encoded in the `Generic`, i.e. the type now is
`PipeEagerSameType[int]` and it is the `[int]` part which tells the actual type.
In this case, it is the final return type which is inaccurate because the
assumption that all functions return the same type and the first one returns
`int`.

The next step would be to try to keep the same easy-to-read syntax while at the
same time being able to pass functions with different signatures.

The `Eager` in the class name is no coincidence, the previous examples using
`compose` were not eagerly evaluated, they had a lazy evaluation strategy. This
implementation though transforms the value at each step. In the case of lazy
evaluation, all the transformations are defined first and evaluated only at the
end. Lazy implementations for this Pipe class will be introduced later on.

## Eager Multitype Pipe

Due to the way `Generic`s work, each instance can only hold a reference to a
single type `T`. To support multiple types there are two possible solutions,
either use as many `TypeVar`s as types needed or use as many instances as types
needed. The latter is more straightforward. The implementation looks like the
following:

```python
from __future__ import annotations

from dataclasses import dataclass
from typing import Callable, Generic, TypeVar

T = TypeVar("T")
U = TypeVar("U")

@dataclass
class PipeEager(Generic[T]):
    x: T

    def then(self, f: Callable[[T], U]) -> PipeEager[U]:
        return PipeEager(f(self.x))

    def __call__(self) -> T:
        return self.x

user_defined_composition = (
    PipeEager(2)
    .then(add_one)
    .then(convert_to_string)
    .then(sort_characters)
    .then(len)
    .then(str)
)

assert user_defined_composition() == "1"
assert user_defined_composition.x == "1"
```

This time, instead of returning `self`, a new instance is created, with the
updated value. Each instance now has information on the current step (through
`T`), and the following step (through `U`). The following step is not defined at
instantiation and therefore it is not needed to add `U` to the `Generic`.

From the outside, the API is preserved, with the additional support for
functions with different types.

Both Pyright and MyPy reflect types are properly inferred:

Pyright:

[![Alt Text]({static}images/typed-pipes/pipe_eager_pyright_types-thumbnail.png){: .b-lazy .narrow width=858 data-src=/blog/images/typed-pipes/pipe_eager_pyright_types.png }](/blog/images/typed-pipes/pipe_eager_pyright_types.png){: .gallery }

MyPy:

[![Alt Text]({static}images/typed-pipes/pipe_eager_mypy_types-thumbnail.png){: .b-lazy width=1019 data-src=/blog/images/typed-pipes/pipe_eager_mypy_types.png }](/blog/images/typed-pipes/pipe_eager_mypy_types.png){: .gallery }

Now, with a compatible implementation, the type has become `PipeEager[str]`,
correctly inferring that calling the instance will return a `str` object.

The next step is to make a Lazy implementation resemble the first ones built
with `compose`.

## Lazy Pipe with Start

To make a lazy implementation, the value should not be stored and
transformed, it will be provided last. Therefore what needs to be stored and
mapped are the transformations.

To achieve this, a similar approach to the Eager classes can be used, but
replacing the value `x` with a function `f`:

```python
from __future__ import annotations

from dataclasses import dataclass
from typing import Callable, Generic, ParamSpec, TypeVar

T = TypeVar("T")
U = TypeVar("U")
P = ParamSpec("P")

@dataclass
class PipeLazyWithStart(Generic[P, T]):
    f: Callable[P, T]

    def then(self, g: Callable[[T], U]) -> PipeLazyWithStart[P, U]:
        return PipeLazyWithStart(compose(self.f, g))

    def __call__(self, *args: P.args, **kwargs: P.kwargs) -> T:
        return self.f(*args, **kwargs)

user_defined_composition = (
    PipeLazyWithStart(add_one)
    .then(convert_to_string)
    .then(sort_characters)
    .then(len)
    .then(str)
)

assert user_defined_composition(2) == "1"
```

In this case, rather than applying a transformation to the value and storing the
transformed result, an instance is created with a new transformation which is
the current and the next one composed. This allows the creation of new instances
each composing on the previous ones.

The API is kept somewhat similar, it now resembles the approach with
`pipe_iterative`, where all the functions are passed first and then evaluated on
a particular value.

Pyright:

[![Alt Text]({static}images/typed-pipes/pipe_lazy_with_start_pyright_types-thumbnail.png){: .b-lazy width=1143 data-src=/blog/images/typed-pipes/pipe_lazy_with_start_pyright_types.png }](/blog/images/typed-pipes/pipe_lazy_with_start_pyright_types.png){: .gallery }

MyPy:

[![Alt Text]({static}images/typed-pipes/pipe_lazy_with_start_mypy_types-thumbnail.png){: .b-lazy width=1445 data-src=/blog/images/typed-pipes/pipe_lazy_with_start_mypy_types.png }](/blog/images/typed-pipes/pipe_lazy_with_start_mypy_types.png){: .gallery }

With the lazy implementation, the types have changed slightly, now the type is
`PipeLazyWithStart[(x: int), str]`, which means that it takes a single parameter
called `x` of type `int` and returns a single value of type `str`. The `x` name
comes from the instance variable with the same name in the class.

In case the advantages of lazy evaluation are unclear, one of the following
sections will explain the pros and cons succinctly.

The next step would be to simplify the class so that it can be instantiated
without an initial function, this could be helpful for many reasons, one example
is testing.

## Lazy Pipe

To remove the initial function, the first impression would be to mark `f` as
`Optional`, however,  has lots of caveats, and MyPy and Pyright will complain. A
simple alternative is to create a helper class that surrogates the initial
creation of the LazyPipeline.

```python
from dataclasses import dataclass
from typing import Callable, Generic, ParamSpec, TypeVar

T = TypeVar("T")
P = ParamSpec("P")

@dataclass
class PipeLazy(Generic[P, T]):
    def then(self, f: Callable[P, T]) -> PipeLazyWithStart[P, T]:
        return PipeLazyWithStart(f)

user_defined_composition = (
    PipeLazy[[int], int]()
    .then(add_one)
    .then(convert_to_string)
    .then(sort_characters)
    .then(len)
    .then(str)
)
assert user_defined_composition(2) == "1"
```

This modification makes the implementation easily generalizable, being able to
pass yet uninstantiated pipelines down the line. It also forces the user to
specify the first input and output types of a given pipeline rather than
infering it which could help prevent bugs as things are more explicit now.

Pyright:

[![Alt Text]({static}images/typed-pipes/pipe_lazy_pyright_types-thumbnail.png){: .b-lazy width=1095 data-src=/blog/images/typed-pipes/pipe_lazy_pyright_types.png }](/blog/images/typed-pipes/pipe_lazy_pyright_types.png){: .gallery }

MyPy:

[![Alt Text]({static}images/typed-pipes/pipe_lazy_mypy_types-thumbnail.png){: .b-lazy width=1398 data-src=/blog/images/typed-pipes/pipe_lazy_mypy_types.png }](/blog/images/typed-pipes/pipe_lazy_mypy_types.png){: .gallery }

Now the type is identical to the previous one but without specifying the `x`,
that is because, at the moment of instantiation, the `PipeLazy` object takes no
arguments. And even after being initialized with `[[int], int]` it accurately
updated the return type to `str` by following the chain of compositions.

So far this implementation checks all the boxes, however, there is yet another
way to implement similar behavior leveraging less common Python features. The
next section will evolve this implementation to add support for decorators and
operator overloading.

## Composable Objects

This section is kept to showcase some of the features of the language, but it
may result in code that is harder to read.

Classes as decorators is an intermediate-advanced concept in Python, in fact,
`PipeLazyWithStart` can already be used as a decorator since it only takes `f`
which is a function.

The other feature of the language that can be used is operator overloading, in
this case, the `>>` operator (also known as right shift) which resembles the
`>>>` in Haskell for left-to-right composition. Other valid alternatives could
have been the `|` or the `&` (bitwise or and bitwise and respectively). Python
does not support the definition of custom operators so having a new `>>>`
operator is not feasible.

To overload the `>>` operator one needs to define a `__rshift__` method, which
in this case will have the same functionality as the `then` method. The only
difference would be that it would need to handle functions and objects of the
same class.

The implementation looks like the following:

```python
from __future__ import annotations

from dataclasses import dataclass
from typing import Callable, Generic, ParamSpec, TypeVar

T = TypeVar("T")
U = TypeVar("U")
P = ParamSpec("P")
Q = ParamSpec("Q")

@dataclass
class Composable(Generic[P, T]):
    f: Callable[P, T]

    def __rshift__(self, other: Callable[Q, U]) -> Composable[P, U]:
        if not isinstance(other, Composable):
            other = Composable(other)
        return Composable(compose(self.f, other.f))

    def __call__(self, *args: P.args, **kwargs: P.kwargs) -> T:
        return self.f(*args, **kwargs)

@Composable
def convert_to_string_decorated(x: int) -> str:
    return str(x)

user_defined_composition = (
    Composable(add_one)
    >> convert_to_string_decorated
    >> Composable(sort_characters)
    >> len
    >> str
)
assert user_defined_composition(2) == "1"
```

The resulting syntax with `>>` is something *new*, in some cases, like when
building a framework or an SDK, introducing new syntax like this could have
great benefit. One project that does this is Apache Airflow. However, most often
it results in niche uses that, without proper documentation could make the code
harder to read and maintain.

Pyright:

[![Alt Text]({static}images/typed-pipes/composable_pyright_types-thumbnail.png){: .b-lazy width=1033 data-src=/blog/images/typed-pipes/composable_pyright_types.png }](/blog/images/typed-pipes/composable_pyright_types.png){: .gallery }

MyPy:

[![Alt Text]({static}images/typed-pipes/composable_mypy_types-thumbnail.png){: .b-lazy width=1174 data-src=/blog/images/typed-pipes/composable_mypy_types.png }](/blog/images/typed-pipes/composable_mypy_types.png){: .gallery }

[![Alt Text]({static}images/typed-pipes/composable_mypy_problems-thumbnail.png){: .b-lazy .narrow width=787 data-src=/blog/images/typed-pipes/composable_mypy_problems.png }](/blog/images/typed-pipes/composable_mypy_problems.png){: .gallery }

The types are identical to those of `PipeLazyWithStart`, however, Mypy complains
about not being able to infer the type of the first parameter of `compose`,
which is unexpected. This may have been due to the interaction between
`ParamSpec`s and `TypeVars` in an edge case.

## Why does Lazy Evaluation matter?

Eager vs. Lazy evaluation is a topic that would deserve an article on its own.
There are tools like `polars` and `pandas` that use eager evaluation and at the
same time other tools like `pyspark` use lazy evaluation.

The following are some key questions to help decide which is better for each
case:

- Speed - Either
- Easy to read code - Either
- Easy to test code - Either
- Easy to debug code / interactive programming - Eager
- Optimized transformations - Lazy
- Flexibility - Lazy
- Separation of transformations from data - Lazy


## Conclusion

There are scenarios where certain operations need to be applied sequentially,
that is a hint for the pipeline pattern which can be implemented with either an
Eager or a Lazy evaluation approach.

Knowing when to use which depends on the scenario but the key aspect is to
structure the code so that the final result is easy to read, easy to test and
easy to maintain.

On a personal note, I believe that unless required, the LazyPipe would suffice
most of the time, and in case it doesn't switching to the Eager version is a
minor change that should not introduce any breaks down the line.

If dealing with a lot of error handling, these pipelines could be combined with
Railway Oriented Programming to streamline processes end to end.
