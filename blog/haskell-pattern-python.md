Title: Haskell pattern matching in Python
Date: 2018-02-18
Category: Programming
Tags: Haskell, Python, Tuple Unpacking
Slug: haskell-pattern-matching-in-python
Authors: Ezequiel Castaño
Lang: en
level: Begginer

I started to learn a bit of Haskell and one of its features amazed me: Pattern Matching. Then, unexpectably, I notice Python 3 have them too but with a different name: Extended Tuple Unpacking. Okay, it's not exactly the same but you can get quite similar functionalities if you master it. This post is inspired by this [question](https://stackoverflow.com/questions/6967632/unpacking-extended-unpacking-and-nested-extended-unpacking)

<!-- PELICAN_END_SUMMARY -->

# Pattern what?

Pattern matching is a feature of Haskell that allows us to think in terms of [wholemeal programming](https://stackoverflow.com/a/6957292/7690767), this means that we forget about the specific details of what we are working with. For example: Think in terms of first and last element instead of index 0 and index -1. This way of thinking has a very strong link with another common functional pattern: Recursive Functions

# Is this a Python or a Haskell thing?

Haskell is much older than Python and there are other languages that implements it besides Haskell so we can't say it's from either. But it turned out to be something that useful that it was incorporated into Python in the [PEP 3132](https://www.python.org/dev/peps/pep-3132/#id3) (In case you don't know, PEPs are the python enhancenment proposals, where all new features are asked and discussed).

# How does it look like?

## Tuple Unpacking

You probably used and make yourself familiar with typica tuple unpacking

Either because you did this:

    :::python
    a, b, c = (3, 4, 5)

or

    :::python
    a, b, c = (3, 4, 5)

Or this:

    :::python
    a = 5
    b = 10
    a, b = b, a

Or maybe you use it at the top of a for loop:

    :::python
    names = ['John', 'Peter']
    for i, name in enumerate(names):
        print(f'{i}: {name}')

## Extended Tuple Unpacking

These are common uses of the tuple unpacking but a more powerful feature is built on top of it: The extended version, which uses the [Unpacking Argument Lists (splat)](https://docs.python.org/3/tutorial/controlflow.html#unpacking-argument-lists)

Lets see some examples:

We will use the following list for this example:

    :::python
    list_ = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

Which by the way can also be written as:

    :::python
    list_ = [i for i in range(10)]

Or even more simplified:

    :::python
    list_ = list(range(10))

### Examples

Get the first item of a list:

    :::python
    first, *rest = list_

Get the last item of a list:

    :::python
    *rest, last = list_

Get the first and the last item of a list

    :::python
    first, *rest, last = list_

# Caveats

Although it may seem quite simple an easy, there are lots of ways to get it wrong:

    :::python
    (a,b), c = "XYZ"                 # ERROR -- too many values to unpack
    (a,b), c = "XY"                  # ERROR -- need more than 1 value to unpack
    (a,b), (c,) = [1,2],'this'       # ERROR -- too many values to unpack
    a, *b, c, *d = 1,2,3,4,5         # ERROR -- two starred expressions in assignment
    (a,b),c = 1,2,3                  # ERROR -- too many values to unpack
    (a,b), *c = 1,2,3                # ERROR - 'int' object is not iterable

# Is there any logic behind it?

Of course there is! This is programming and for a full explanation I recommend you to read the PEP and this [answer](https://stackoverflow.com/a/6968451)