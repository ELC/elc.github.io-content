Title: Graficando Fractales Paso a Paso con Python
Date: 2018-10-14
Category: Programming
Tags: Python, Fractals, Turtle
Slug: plotting-fractals-step-by-step-with-python
Authors: Ezequiel Castaño
Lang: es
Translation: True
level: Beginner

Los fractales son increibles, se construyen con patrones muy complejos y permiten acercarse de manera indefinida. En este post voy a mostrarles cuan facilmente pueden graficarse diversos tipos de fractales utilizando una herramienta llamada Sistemas L y el módulo Turtle de Python para hacer el gráfico paso a paso.

<!-- PELICAN_END_SUMMARY -->

En este post no voy a adentrarme demasiado en detalles técnicos, en cambio, les voy a dar una breve introducción, muchos ejemplos animados y al final el código para que puedan generar los que quieran. Si quieres saltear la teoría e ir directamente a las animaciones, puedes ir directamente a los [Ejemplos animados](#ejemplos-animados), si por otro lado querés ver el código, puedes ir a [esa sección](#codigo). Adicionalmente, [al final](#recursos-adicionales) dejaré recursos adicionales tanto para el código como para la parte matemática para aquellos que quieran profundizar.

## ¿Qué es un Fractal?

Primero veamos una definición "no estricta" de lo que es un fractal: es basicamente una figura geométrica que muestra las mismas características sin importar cuanto te acerques.

No es del todo correcto pero para aquellos que quieran conocer la definición exacta, aquí se las dejo:

> Un fractal es un objecto o cantidad que muestra auto-similaridad, en un sentido téctico, en todas sus escalas. El objeto no necesita exhibir exactamente la misma estructura en todas sus escala sino el mismo "tipo" de estructuras debe aparecer en todas las escalas. Un gráfico o cantidad en al graficarlo en función de su escala en un eje logarítmico da una línea recta, cuya pendiente es su "dimensión fractal" - [Math World Traducido](http://mathworld.wolfram.com/Fractal.html)

## ¿Cómo podemos Graficar Fractales con Python?

Típicamente, los fractales son difíciles de graficar, esto se debe al concepto que está íntimamente relacionado con ellos, la recursión. Cuando se habla de gráficos, usualmente se habla de píxeles o vectores, pero siempre existe un límite, sin embargo, los fractales son por definición infinitamente recursivos. Esto implica que cuando grafiquemos un fractal vamos a deternos en algún momento, de aquí surge el concepto de "iteración". En cada iteración el fractal se vuelve más y más complejo pero en cierto momento es imposible distinguir entre dos iteraciones sucesivas (esto ocurre debido a que los cambios se producen al nivel de píxeles), así que es bastante razonable detenerse en ese momento, a veces incluso es bastante evidente cúal será la forma del fractal y uno podría deternerse incluso antes.

Dos ejemplos de esto son la "Quadratic Koch Island", que con 3 iteraciones tiene una estructura definida y la "Dragon Curve" que comienza a mostrar una estructura definida luego de 8 iteraciones. Cúantas iteraciones son necesarias depende en gran manera del fractal específico con el que estemos trabajando

En el ecosistema de Python existen muchas bibliotecas para realizar gráficos, la más popular es Matplotlib, sin embargo, está pensada para graficar datos estadístico y realizar gráficos conocidos. Matplotlib tiene en particular componentes de bajo nivel que nos permitirían graficar fractales pero en esta oportunidad centraremos nuestra atención en un generalmente olvidado módulo de la biblioteca estandar, el módulo Turtle

### El módulo Turtle

Según [la documentación de Python](https://docs.python.org/3.6/library/turtle.html): "Los gráficos Turtle son una manera popular de introducir la programación a los niños. Era parte del lenguaje de programación Logo, desarrollado por Wally Feurzig y Seymour Papert en 1996"

La clave en este tipo de gráficos es que tenemos 3 comandos básicos:

- Moverse hacia adelante
- Girar hacía la izquierda un cierto ángulo
- Girar hacía la derecha un cierto ángulo

*Nota: La bilioteca estandar provee otros comandos pero en este articulo sólo vamos a utilizar estos 3*

Adicionalmente tenemos la opción de:

- Deshabilitar la escritura
- Habilitar la escritura

Éstas características pueden parecer muy simples para graficar algo tan complejo como los fractales pero es por esto que vamosa utilizar otra herramienta que utiliza exactamente este pequeño conjunto de instrucciones, me refiero a los Sistemas L


### L-Systems

Un Sistema L es una manera de representar estructuras recursivas (como los fractales) como cadenas de caracteres, esto es hace re-escribiendo la cadena una y otra vez. Para aquellos interesados en la definición formal:

> Un Sistema de Lindenmayer, también conocido como Sistema L, es un sistema de re-escritura de cadenas que puede ser usado para generar fractales de dimención entre 1 y 2. - [Math World Traducido](http://mathworld.wolfram.com/LindenmayerSystem.html)

Una vez que hayamos entendido lo que es un Sistema L podemos producir estructuras recursivas pero antes que podamos hacerlo necesitamos entender las partes que que lo forman. Todo Sistema L tiene:

- Un alfabeto: Un conjunto de símbolos que el Sistema L va a utilizar.
- Un axioma: La cadena original que se utiliza en la generación.
- Un conjunto de reglas de producción: estas reglas indica como debe ser reemplazado cada uno de los símbolos en la siguiente iteración.

*Nota para aquellos que les gustan las ciencias de la computación: esta descripción puede sonarte familiar, y es que, en realidad es muy similar a la definición de una Gramática Formal, la diferencia primordial es que en cada iteración, a diferencia de las gramáticas, se aplican tantas reglas como sean posibles en lugar de una. Encontes puede concluirse que los Sistemas L son un subconjunto de las gramáticas libres de contexto*

Debido a que vamos a utilizar Turtle para graficar y los Sistemas L para representar los fractales, necesitamos entender de que manera podemos relacionarlos.

Ya que Turtle sólo recibirá los comandos mencionados arriba, debemos asignar un símbolo a cada uno, que en conjunto representarán el alfabeto del Sistema L

- F: Mover hacia adelante (del inglés Fowards).
- +: Girar a la derecha.
- -: Girar a la izquierda.

Para poder graficar los fractales, adicionalmente debe definirse un ángulo, que será el ángulo de giro que hara Turtle cada vez que se lo indiquemos, ya sea a la izquierda o a la derecha. Por razones de simplicidad, el mismo ángulo debe utilizarse en todas las iteraciones, el Sistema L debe escribirse teniendo esto en consideración.

El axioma y las reglas de producción dependerán exclusivamente del fractal pero el fractal debe ser escrito de una manera que pueda ser representado utilizando sólo los tres simbolos. Esto introduce una limitación, sólo se podrán graficar fractales compuestos por una única línea continua, así que algunos como el Conjunto de Cantor no podrán graficarse de esta manera. Esta es meramente una simplicación, ya que podrían agregarse otros comandos que permitan el movimiento sin necesidad de escribir pero para mantener las cosas simples, mantendremos la simplificación.

Ahora veamos los ejemplos!

## Ejemplos Animados

Los siguientes ejemplos fueron compilados de diversos sitios públicamente disponibles en internet. Decidí migrarlos a Python con la ayuda del módulo Turtle, centrarlos, añadirles color y proporcionar una manera de exportarlos en formato vectorial.

Debido a que el navegador ejecuta Python mediante [Skulpt](http://www.skulpt.org/) y el módulo Colorsys aún no está soportado, las animaciones serán en blanco y negro pero las imágenes y el código para generarlas estarán al final. Cada animación tiene un código asociado que puede abrirse de manera onlina y copiarse por medio de [Repl.it](https://repl.it/)

**Advertencia: Las animaciones que estás por ver son bastante pesadas, es recomendable verlas sólo con una buena conección. Los fragmentos de Repl pueden no funcionar en los usuarios que utilicen dispositivos móviles.**

Nota: Skulpt utiliza TU NAVEGADOR para renderizar y para hacer las animaciones así que si en cualquier caso experimentás demoras, errores o comportamiento extraño, esto puede deberse al navegador, recargar la animación o recargar la página debe solucionar la mayoría de los inconvenientes. Puede no funcionar adecuadamente en dispositivos móbiles.

Los ejemplos están ordenados por orden de complejidad (mi juicio subjetivo), así que los mejores están al final

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

## Código

Todos los ejemplos de arriba fueron producidos con el mismo código, en el mientras tanto, algunos desafíos surgieron, principalmente como mantener los fractales centrados (o al menos tanto como sea posible), lidiando con colores, inversiónes, traslaciones y como exportarlos rápidamente a formatos vectoriales. Aquí voy a mostrarte la versión más básica, si quieres saber como solucioné todos estos desafios, no dudes en dejar un comentario y haré una Parte 2.

Esta versión grafica en blanco y negro sin funcionalidades de exportación.

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

## Explicación del Código

    :::python
    import turtle

Lo primero que necesitamos hacer es importar el módulo Turtle

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

Luego lo que necesitamos es generar el Sistema L que será el conjunto de instrucciones para Turtle. Definimos una función llamada `create_l_system` que recibe el número de iteraciones, el axioma y las reglas de producción. Comienza con el axioma y utiliza una variable auxiliar llamada `end_string`, si la iteración es igual a 0, retorna el axioma ya que algunos fractales pueden ser graficados con iteraciones iguales a 0. Se asume que las reglas con un diccionario así que la clave será única y representa al símbolo mientras que el valor representa con que símbolos debe ser remplazado. Se concatenan todos los remplazos para cada símbolo y luego se acaba con la cadena para la próxima iteración.

    ::python
    def draw_l_system(t, instructions, angle, distance):
        for cmd in instructions:
            if cmd == 'F':
                t.forward(distance)
            elif cmd == '+':
                t.right(angle)
            elif cmd == '-':
                t.left(angle)

Posteriormente definimos `draw_l_system` que recibe a Turtle, un conjunto de instrucciones (la salida del sistema L), un ángulo para girar tanto a la derecha como a la izquiera y la longitud de cada línea individual. Luego se tiene una simple estructura elif para cada uno de los comandos definidos anteriormente.

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

Finalmente se tiene una función `main` que recibe todos los parámetros que necesita para la generación del Sistema L así como `y_offset`, `x_offset`, `offset_angle`, `width` y `height`. Los primeros tres representan la traslación de Turtle, esto es sencillamente para posicionar el gráfico en el lugar deseado del lienzo.

La función primeramente genera el conjunto de instrucciones y lo guarda en `inst` y luego inicializa Turtle y la Screen, lo posiciona en el lugar definido y luego grafica las instrucciones, por último, espera al evento click para cerrarse.

## Consideraciones Especiales

Como mencioné antes, existen muchas limitaciones en este escenario, primero que nada no incluimos la posibilidad de mover a Turtle sin dibujar, esto requeriría un símbolo adicional, tampoco hay un símbolo ni para ir hacía atras, o recordar posiciones anteriores. Esto no fue necesario para ninguno de los fractales de los ejemplos pero si lo es para otros (como por ejemplo los árboles fractales).

## Recursos Adicionales

Hay muchos recursos en internet sobre fractales, tanto desde el área de la programación como desde la perspectiva de la matemática. Les dejo a continuación dos que me resultaron sumamente interesantes: el video de 3Blue1Brown para la parte de matemática y el de CodingTrain para la parte de programación.

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

## Fuente y Referencias

Este post fue inspirado por [un post de Math World](http://mathworld.wolfram.com/LindenmayerSystem.html), por el [blog de Paul Broke](http://paulbourke.net/fractals/lsys/) y por un trabajo práctico para la materia de Algoritmos Genéticos.