Title: TIL - Type Safe Pipes and the Compose Function
Date: 2023-09-23
Category: Programming 
Tags: Python, Type
Slug: typed-pipes
Authors: Ezequiel Leonardo Castaño 
Lang: en 
Status: draft

<!-- PELICAN_BEGIN_SUMMARY -->

Different ways to type compose and pipe functionality using several Python
Features.

<!-- PELICAN_END_SUMMARY -->

## Function Composition

There are two notations for function composition one with a right to left
direction and one with a left to right direction. Namely:

Right to left:

$$f∘g = f(g(x))$$

Left to right:

$$f∘g = g(f(x))$$

The traditional notation in math is the right to left one. Some languages like
Haskell have built-in syntax for both. In Haskell the usual way to do
composition is with `.` which is right ot left, it is also possible to use `>>>`
for left to right composition. 

On the other hand, one of the most common ways to compose functions in
programming is through Unix Pipes which use the `|` operator, which conversely
is left to right composition.

That means that when implementing a `compose` or a `pipe` function is not
trivial which orientation to choose as they are competing notations. In the
context of programming the left to right orientation is more common.

All the examples here will use the left to right orientation.

## The compose function

The compose function is a function that takes two functions `f` and `g` and
returns a new functions that performs `g` and then `f`. In Python a generic
implementation looks like this:

[![Alt Text]({static}images/til-typed-pipes/compose-thumbnail.png){: .b-lazy width=1724 data-src=/blog/images/til-typed-pipes/compose.png }](/blog/images/til-typed-pipes/compose.png){: .gallery }

For this to work, it is necessary that the output of `f` matches the input of
`g`, or otherwise the execution may fail. To enforced this relationship a typed
version of composed can be written as follows:

[![Alt Text]({static}images/til-typed-pipes/compose_typed-thumbnail.png){: .b-lazy width=1724 data-src=/blog/images/til-typed-pipes/compose_typed.png }](/blog/images/til-typed-pipes/compose_typed.png){: .gallery }

This implementation uses Python 3.10's `ParamSpec`, which allows to type `*args`
and `**kwargs`.

Having a typed version is important as one typical case is composing multiple
functions and if the types are not enforced, unexpected behaviour could arise.

One example of using this compose implementation is the following:

[![Alt Text]({static}images/til-typed-pipes/compose_example-thumbnail.png){: .b-lazy width=1724 data-src=/blog/images/til-typed-pipes/compose_example.png }](/blog/images/til-typed-pipes/compose_example.png){: .gallery }

When using the typed version, both MyPy and Pyright can infer the resulting type:

PyRight (through Pylance)
[![Alt Text]({static}images/til-typed-pipes/compose_pylance-thumbnail.png){: .b-lazy width=870 data-src=/blog/images/til-typed-pipes/compose_pylance.png }](/blog/images/til-typed-pipes/compose_pylance.png){: .gallery }

MyPy
[![Alt Text]({static}images/til-typed-pipes/compose_mypy-thumbnail.png){: .b-lazy width=1070 data-src=/blog/images/til-typed-pipes/compose_mypy.png }](/blog/images/til-typed-pipes/compose_mypy.png){: .gallery }


One important aspect of function composition is that it is not commutative, that
is $$f∘g \neq g∘f$$. There may be cases where both are equivalent but most of
the times it is not.

And this is helpful when programming as the IDE can automatically detects and
flag types imcompatibility. Take for example trying to `add_one` to the result
of `convert_to_string`.

[![Alt Text]({static}images/til-typed-pipes/compose_error-thumbnail.png){: .b-lazy width=1724 data-src=/blog/images/til-typed-pipes/compose_error.png }](/blog/images/til-typed-pipes/compose_error.png){: .gallery }

PyRight (through Pylance)
[![Alt Text]({static}images/til-typed-pipes/compose_pylance_error-thumbnail.png){: .b-lazy width=771 data-src=/blog/images/til-typed-pipes/compose_pylance_error.png }](/blog/images/til-typed-pipes/compose_pylance_error.png){: .gallery }

MyPy
[![Alt Text]({static}images/til-typed-pipes/compose_mypy_error-thumbnail.png){: .b-lazy width=926 data-src=/blog/images/til-typed-pipes/compose_mypy_error.png }](/blog/images/til-typed-pipes/compose_mypy_error.png){: .gallery }

The error from MyPy may not be descriptive enough but at least points into the
right direction. Pyright is able to identify the exact cause of the the problem:
`add_one` takes an `int` but it is receiving a `str` as the output of
`convert_to_string`.

