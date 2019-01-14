Title: Plotting Fractals Step by Step with Python
Date: 2018-10-14
Category: Programming
Tags: Python, Fractals, Turtle
Slug: plotting-fractals-step-by-step-with-python
Authors: Ezequiel Castaño
Lang: en
level: Beginner

Fractals are awesome, they are built with very complex pattern and they allow you to zoom in forever! In this post we will see how easily it is to plot several kinds of fractals using a tool called L-Systems and the Python Turtle module for the step to step plotting.

<!-- PELICAN_END_SUMMARY -->

In this post I'm not going to dive into too many technical details but instead I'll present a little introduction, a lot of animated examples and at the end, the code to generate your own. If you want skip the theory and see the animations, jump directly to the [animated examples](#animated-examples), if you want to see the code instead, [jump directly to that section](#code). Additionally, there will be some resources for both code and math background if you want to explore [at the end](#additional-resources).

## What's a Fractal?

First lets give a "non-strict" definition of what a fractal is, it is basically a geometric figure which shows the same characteristics no matter how much you zoom in.

It isn't quite correct but for those who wanted to know the exact definition here it is:

> A fractal is an object or quantity that displays self-similarity, in a somewhat technical sense, on all scales. The object need not exhibit exactly the same structure at all scales, but the same "type" of structures must appear on all scales. A plot of the quantity on a log-log graph versus scale then gives a straight line, whose slope is said to be the fractal dimension. - [Math World](http://mathworld.wolfram.com/Fractal.html)

## How can we draw Fractals with Python?

Fractals are typically hard to draw, because there is a concept which is deeply tight in them, recursion. When we talk about graphics and plotting we usually talk about pixels or vectors, but there is always a limit, fractals by definition are infinitely recursive. So when we want to plot one we should stop at some point, that's why we talk about "iterations". At each iteration the fractal becomes more and more complex, but at some point it is impossible to distinguish between to successive iterations (this happens when changes occur at individual pixel levels), so it is quite reasonable to stop there, sometimes it is quite clear what the shape is and we can stop even earlier.

A two examples for this are the Quadratic Koch Island, which with 3 iterations has a clear structure and in the other hand the Dragon Curve which has a clear structure with 8 iterations. How many iterations are needed depends highly on the specific fractal we are working with.

Certainly there are lots of plotting libraries in Python, being Matplotlib the most popular but they are usually design to plot statistical data and well known plots. Matplotlib in particular has some low level constructs that allow us to build fractals but this time we will be focusing in a usually forget module in the standard library, the Turtle Module.

### Turtle Module

According to [Python docs](https://docs.python.org/3.6/library/turtle.html): "Turtle graphics is a popular way for introducing programming to kids. It was part of the original Logo programming language developed by Wally Feurzig and Seymour Papert in 1966."

The key here is that turtle recognizes basically 3 commands:

- Move Forwards
- Turn Left by angle
- Turn Right by angle

*Note: THe standard library provided other commands but here we are going to just those 3.*

Additionally we have the option to:

- Disable writing
- Enable writing

This characteristics seems too simple for plotting such complex graphics as fractals but we will use another tool that uses just this little set of instructions, I'm talking about L-Systems.

### L-Systems

An L-System is a way of representing recursive structures (such as fractals) as a string of characters, this is done by rewriting the string over and over. Again, the formal definition is the following:

> A Lindenmayer system, also known as an L-system, is a string rewriting system that can be used to generate fractals with dimension between 1 and 2. - [Math World](http://mathworld.wolfram.com/LindenmayerSystem.html)

Once we understand what an L-System is we can produce recursive structures, but before we are able to do that we need to understand what are the pieces we need. Every L-System has:

- An alphabet: The set of symbols the L-System is going to use.
- An axiom: The initial string for the generation.
- A set of production rules: These rules tells how each symbol should be replaced in the following iteration.

*Note for computer science fans: If you ever dived into Computer Science this might sound familiar, it is actually since this is very similar to the definition of a Formal Grammar, the key difference is that in each iteration, as opposed to grammars, as many rules as possible are applied instead of just one. So L-Systems are a subset of Context-Free Grammars.*

Since we are going to use Turtle to plot and L-Systems to represent what we want to plot we need to create a relationship between them.

Since the only commands we have in Turtle are the mentioned above we will assign each a symbol which will represent the alphabet

- F: Move Forwards
- +: Turn Right
- -: Turn Left

In order to make this work, each fractal should also provide an angle, which will be the angle the turtle will turn either right or left, for simplicity reasons only one angle should be provided and the L-System should be written taking that into consideration.

The axiom and the production rules will depend on the fractal only, but the fractal should be written in a way that can be represented by these only three symbols. This introduces a limitation, we will be able to produce only one-line fractals, so some such as the Cantor Set won't be able to be produced this way, this is only a simplification, since we can introduce two other commands to move forwards without writing and analogously for the backwards movement, but to keep things simple we will keep that simplification.

Now let's move to some examples!

## Animated Examples

The following examples were compiled from several places publicly available on internet. I decided to port them to Python with the help of the Turtle module, center them, adding colors and provide a way to export them in vectorial format.

Because the browser execute Python via [Skulpt](http://www.skulpt.org/) and Colorsys isn't supported yet, the animations will be Black & White but images with colors and the corresponding code to generate them will be provided. Each animation has a code associated which you can open and fork in [Repl.it](https://repl.it/)

**WARNING: The animations you are about to see are quite large in size, it is recommended to see them only with a good connection. The Repl snippet may not work since it uses your resources so mobile users might not be able to see it properly.**

Note: Skulpt uses YOUR BROWSER to render and to make the animation so if in any case you experience delays, lags or strange behaviour it may be a problem with the browser, replaying the animation or reloading the page should fix most issues. It may not work properly on mobile.

The examples are ordered by their complexity (my own judgement though), so the best ones are at the end.

## Koch-Snowflake"

    ::python
    axiom = "F--F--F"
    rules = {"F":"F+F--F+F"}
    iterations = 4 # TOP: 7
    angle = 60

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Koch-Snowflake_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Koch-Snowflake-With-Python?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Quadratic-Koch-Island

    ::python
    axiom = "F+F+F+F"
    rules = {"F":"F-F+F+FFF-F-F+F"}
    iterations = 2 # TOP: 4
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Quadratic-Koch-Island_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Quadratic-Koch-Island-With-Python?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Crystal

    ::python
    axiom = "F+F+F+F"
    rules = {"F":"FF+F++F+F"}
    iterations = 3 # TOP: 6
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Crystal_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Crystal-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Quadratic-Snowflake

    ::python
    axiom = "F--F"
    rules = {"F":"F-F+F+F-F"}
    iterations = 4 # TOP: 6
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Quadratic-Snowflake_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Quadratic-Snowflake-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Box-Fractal

    ::python
    axiom = "F-F-F-F"
    rules = {"F":"F-F+F+F-F"}
    iterations = 4 # TOP: 6
    angle = 90


<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Box-Fractal_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Box-Fractal-With-Python?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Levy-C-Curve

    ::python
    axiom = "F"
    rules = {"F":"+F--F+"}
    iterations = 10 # TOP: 16
    angle = 45

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Levy-C-Curve_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Levy-C-Curve-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Sierpinski-Arrowhead

    ::python
    axiom = "YF"
    rules = {"X":"YF+XF+Y", "Y":"XF-YF-X"}
    iterations = 1 # TOP: 10
    angle = 60

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Sierpinski-Arrowhead_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Siepinski-Arrowhead-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Siepinski-Sieve

    ::python
    axiom = "FXF--FF--FF"
    rules = {"F":"FF", "X":"--FXF++FXF++FXF--"}
    iterations = 7 # TOP: 8
    angle = 60

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Siepinski-Sieve_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Siepinski-Sieve-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Board

    ::python
    axiom = "F+F+F+F"
    rules = {"F":"FF+F+F+F+FF"}
    iterations = 3 # TOP: 5
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Board_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Board-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Tiles

    ::python
    axiom = "F+F+F+F"
    rules = {"F":"FF+F-F+F+FF"}
    iterations = 3 # TOP: 4
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Tiles_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Tiles-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Rings

    ::python
    axiom = "F+F+F+F"
    rules = {"F":"FF+F+F+F+F+F-F"}
    iterations = 2 # TOP: 4
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Rings_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Rings-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Cross-2

    ::python
    axiom = "F+F+F+F"
    rules = {"F":"F+F-F+F+F"}
    iterations = 3 # TOP: 6
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Cross-2_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Cross-2-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Pentaplexity

    ::python
    axiom = "F++F++F++F++F"
    rules = {"F":"F++F++F+++++F-F++F"}
    iterations = 1 # TOP: 5
    angle = 36

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Pentaplexity_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Pentaplexity-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## 32-Segment-Curve

    ::python
    axiom = "F+F+F+F"
    rules = {"F":"-F+F-F-F+F+FF-F+F+FF+F-F-FF+FF-FF+F+F-FF-F-F+FF-F-F+F+F-F+"}
    iterations = 3 # TOP: 3
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
   <source data-src="/blog/images/fractals/450/32-Segment-Curve_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-32-Segment-Curve-With-Python?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Peano-Gosper-Curve

    ::python
    axiom = "FX"
    rules = {"X":"X+YF++YF-FX--FXFX-YF+", "Y":"-FX+YFYF++YF+FX--FX-Y"}
    iterations = 4 # TOP: 6
    angle = 60

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Peano-Gosper-Curve_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Peano-Gosper-Curve-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Sierpinski-Curve

    ::python
    axiom = "F+XF+F+XF"
    rules = {"X":"XF-F+F-XF+F+XF-F+F-X"}
    iterations = 4 # TOP: 8
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Sierpinski-Curve_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Siepinski-Curve-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Krishna-Anklets

    ::python
    axiom = " -X--X"
    rules = {"X":"XFX--XFX"}
    iterations = 3 # TOP: 9
    angle = 45

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Krishna-Anklets_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Krishna-Anklets-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Quadratic-Gosper

    ::python
    axiom = "YF"
    rules = {"X": "XFX-YF-YF+FX+FX-YF-YFFX+YF+FXFXYF-FX+YF+FXFX+YF-FXYF-YF-FX+FX+YFYF-", 
            "Y": "+FXFX-YF-YF+FX+FXYF+FX-YFYF-FX-YF+FXYFYF-FX-YFFX+FX+YF-YF-FX+FX+YFY"}
    iterations = 2 # TOP: 3
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Quadratic-Gosper_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Quadratic-Gosper-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Moore-Curve

    ::python
    axiom = "LFL-F-LFL"
    rules = {"L":"+RF-LFL-FR+", "R":"-LF+RFR+FL-"}
    iterations = 0 # TOP: 8
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Moore-Curve_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Moore-Curve-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Hilberts-Curve

    ::python
    axiom = "L"
    rules = {"L":"+RF-LFL-FR+", "R":"-LF+RFR+FL-"}
    iterations = 8 # TOP: 9
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Hilberts-Curve_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Hilbert-Curve-With-Python?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Hilbert-Curve-II

    ::python
    axiom = "X"
    rules = {"X":"XFYFX+F+YFXFY-F-XFYFX", "Y":"YFXFY-F-XFYFX+F+YFXFY"}
    iterations = 4 # TOP: 6
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Hilbert-Curve-II_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Hilbert-Curve-II-With-Python?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Peano-Curve"

    ::python
    axiom = "F"
    rules = {"F":"F+F-F-F-F+F+F+F-F"}
    iterations = 2 # TOP: 5
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Peano-Curve_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Peano-Curve-With-Python?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Cross

    ::python
    axiom = "F+F+F+F"
    rules = {"F":"F+FF++F+F"}
    iterations = 3 # TOP: 6
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Cross_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Cross-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Triangle

    ::python
    axiom = "F+F+F"
    rules = {"F":"F-F+F"}
    iterations = 2 # TOP: 9
    angle = 120

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Triangle_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Triangle-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Dragon-Curve

    ::python
    axiom = "FX"
    rules = {"X":"X+YF+", "Y":"-FX-Y"}
    iterations = 8 # TOP: 16
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Dragon-Curve_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Dragon-Curve-With-Python?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## TerDragon-Curve

    ::python
    axiom = "F"
    rules = {"F":"F-F+F"}
    iterations = 5 # TOP: 10
    angle = 120

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/TerDragon-Curve_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-TerDragon-Curve-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Twin-Dragon-Curve

    ::python
    axiom = "FX+FX"
    rules = {"X":"X+YF+", "Y":"-FX-Y"}
    iterations = 6 # TOP: 16
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/Twin-Dragon-Curve_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-Twin-Dragon-Curve-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## ThreeDragon-Curve

    ::python
    axiom = "FX+FX+FX"
    rules = {"X":"X+YF+", "Y":"-FX-Y"}
    iterations = 7 # TOP: 15
    angle = 90

<div class="two-column">
<video class="b-lazy" autoplay loop>
    <source data-src="/blog/images/fractals/450/ThreeDragon-Curve_450x450.mp4" type="video/mp4">
</video>

<iframe class="b-lazy" height="549px" width="469px" data-src="https://repl.it/@ELC/Drawing-ThreeDragon-Curve-With-Python-and-Turtle?lite=true&outputonly=1" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>
</div>

## Code

All the examples above were produced by the same code and some challenges emerged when working on it, mainly to keep the fractal centered (or at least as much as possible), dealing with colors, inversions and offsets and to export it quickly in a vectorial format. Here I will show you the most basic version, if you want to know how I dealt with those challenges, leave me a comment and I will make a Part 2.

This version plots in black and white and with no export functionalities

    :::python
    import turtle

    def create_l_system(iters, axiom, rules):
        start_string = axiom
        if iters == 0:
            return axiom
        end_string = ""
        for _ in range(iters):
            end_string = "".join(rules[i] if i in rules else i for i in start_string)
            start_string = end_string

        return end_string


    def draw_l_system(t, instructions, angle, distance):
        for cmd in instructions:
            if cmd == 'F':
                t.forward(distance)
            elif cmd == '+':
                t.right(angle)
            elif cmd == '-':
                t.left(angle)


    def main(iterations, axiom, rules, angle, length=8, size=2, y_offset=0,
            x_offset=0, offset_angle=0, width=450, height=450):

        inst = create_l_system(iterations, axiom, rules)

        t = turtle.Turtle()
        wn = turtle.Screen()
        wn.setup(width, height)

        t.up()
        t.backward(-x_offset)
        t.left(90)
        t.backward(-y_offset)
        t.left(offset_angle)
        t.down()
        t.speed(0)
        t.pensize(size)
        draw_l_system(t, inst, angle, length)
        t.hideturtle()

        wn.exitonclick()

## Code Explanation

    :::python
    import turtle

First we need to import the Turtle Module

    ::python
    def create_l_system(iters, axiom, rules):
        start_string = axiom
        if iters == 0:
            return axiom
        end_string = ""
        for _ in range(iters):
            end_string = "".join(rules[i] if i in rules else i for i in start_string)
            start_string = end_string

        return end_string

Then we need to generate the L-System which will be the set of instructions for the turtle. We define a function called `create_l_system` which receives the number of iterations, the axiom and the production rules. It starts with the axiom and uses an auxiliary variable called `end_string` if iteration is equal to 0 it will return the axiom since some fractals can be plot with iterations equal to 0. Rules here are assumed to be dictionaries, so the key will be unique and represents the symbol and the value represents what should be replaced with. So we join all the replacements for each symbol and we end up with the string for the next iteration.

    ::python
    def draw_l_system(t, instructions, angle, distance):
        for cmd in instructions:
            if cmd == 'F':
                t.forward(distance)
            elif cmd == '+':
                t.right(angle)
            elif cmd == '-':
                t.left(angle)

Then we define a `draw_l_system` which takes the turtle, the set of instructions (the output of the L-System), the angle for the turn right/left and the length of each individual line. It consist of a simple elif structure for each of the previously defined commands.

    ::python
    def main(iterations, axiom, rules, angle, length=8, size=2, y_offset=0,
            x_offset=0, offset_angle=0, width=450, height=450):

        inst = create_l_system(iterations, axiom, rules)

        t = turtle.Turtle()
        wn = turtle.Screen()
        wn.setup(width, height)

        t.up()
        t.backward(-x_offset)
        t.left(90)
        t.backward(-y_offset)
        t.left(offset_angle)
        t.down()
        t.speed(0)
        t.pensize(size)
        draw_l_system(t, inst, angle, length)
        t.hideturtle()

        wn.exitonclick()

And finally the `main` function, it receives all the parameters it need for the generation of the L-Systems and also `y_offset`, `x_offset`, `offset_angle`, `width` and `height`. The first three represent the offset of the turtle, this is merely for positioning the plot as we want inside the canvas. 

The function first generates a set of instructions and stores it in `inst` then it initializes the turtle and the screen and it positions the turtle in the defined position, then it plots the instructions and wait for a click to close.

## Special Considerations

As I mentioned earlier there are lots of limitations here, first we are not including the possibility of moving the turtle without drawing, this would require another symbol, it isn't either a symbol for going backwards, or remember previous positions. This weren't necessary for all the fractals you've seen but for some other (like fractal trees), these symbols are required.

## Additional Resources

There are lots of resources in internet about fractals both from the programming and from the math perspective. I will show you two that I find really interesting: The 3Blue1Brown for math and the CodingTrain for code.

**Coding Train**

<div class="youtube-container">
    <iframe class="b-lazy" width="560px" height="315px" data-src="https://www.youtube.com/embed/f6ra024-ASY?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
    </div>
</div>

**3Blue1Brown**

<div class="youtube-container">
    <iframe class="b-lazy" width="560px" height="315px" data-src="https://www.youtube.com/embed/gB9n2gHsHN4?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
    </div>
</div>

## Sources and References

This post was inspired by a [Math World post](http://mathworld.wolfram.com/LindenmayerSystem.html), the [Paul Broke Blog](http://paulbourke.net/fractals/lsys/) and an university assignment for Genetic Algorithms.