Title: Time Tables Visualization - Finding Patterns
Date: 2019-01-22
Category: Data Visualization
Tags: Data Visualization, Programming, Math
Slug: times-tables
Authors: Ezequiel Castaño
Lang: en
Status: draft
headerimage: https://elc.github.io/blog/images/times_tables/times-tables-headerimage.png

After looking to a Mathologer Video, I decided to use it as a challenge and write a script to do the same with Python.

<!-- PELICAN_END_SUMMARY -->

First, let's introduce the video I mentioned, in this video a very nice patterns emerges in something called "Times Tables"

<iframe width="900" height="506" src="https://www.youtube.com/embed/qhbuKbxJsk8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

These animations were made using Wolfram Mathematica, but in Python, there are enough tools to achieve the same.

This is the results built with Python:

![times-table-2-100]({attach}images/times_tables/times-tables-2-100-thumbnail.png){: .narrow .b-lazy width=900px data-src=/blog/images/times_tables/times-tables-2-100.png }

Now I will examine the code used to produced the previous image and also how to create animations, there will be a [**link to a online notebook**](#notebook) in case you want to experiment yourself. In this post I will show you several scenarios:

- Static Version (as the one seen above)
- Parametric Version: Where you can change with sliders the values and experiment by yourself.
- Animate Construction Line by Line: Where the factor and the number of points is fixed but each line is plot one at a time
- Animate Construction Point by Point: Where the factor and the lines are fixed but each frame increases the number of points
- Animate Construction Factor by Factor: Where the lines and the number of points are fixed but the factor increases (The one shown at the end of the video), first monochrome and then with the rainbow effect seen in the video.

Requirements:

- Jupyter: Notebook Interface
- Numpy: For array manipulation
- Matplotlib: For visualization and animation
- ffmpeg (Optional): For exporting the animation

In order to produce these images and animations, the code should be split in 4 parts:

- Import all the necesary libraris
- Define all the auxiliary functions
- Plot the animations
- Export (optional)

## Initialization

It's a good practice to place all the imports at the top of the document to better trace dependencies and keep them updated, and also to know which tools are required. In this case there are General Purpose imports and Jupyter Specifics, in order to run as a script, it has to be adapted to replace the Jupyter Funtionalities

    ::python
    # General Purpose
    import numpy as np
    from matplotlib import pyplot as plt
    from matplotlib import animation, rc
    import matplotlib.lines as mlines
    import colorsys
    from matplotlib.collections import LineCollection

    # Jupyter Specifics
    import matplotlib as mpl
    from IPython.display import HTML
    from ipywidgets.widgets import interact, IntSlider, FloatSlider, Layout

    %matplotlib inline
    rc('animation', html='html5')

## Basic Functions

Once everything is imported and ready to use, several functions must be defined, namely:

1. One function to calculate the points arround a circle
1. One function to generate each of the lines
1. One function to plot the labels and the point in the circle
1. One function to plot the lines in the circle

The first function is called `points_arround_circle` and it basically uses polar coordinates to place a given number of points arround a circle of a given radius. Here numpy is needed to make the calculation performant.

    ::python
    def points_arround_circle(number=100, center=(0,0), radius=1):
        theta = np.linspace(0, 2 * np.pi - (2 * np.pi / number), number)
        x = radius * np.cos(theta)
        y = radius * np.sin(theta)
        return (x, y)

Second, in order to generate the lines, the list of points is given and a new line is generated, a different approach is needed when using this function in an animation so two sets of logic are defined inside de function.

    ::python
    def get_lines_from_points(x, y, factor, animated=None):
        limit = len(x)
        if animated is not None:
            for i in range(limit):
                x_range = (x[i], x[int(i * factor) % limit])
                y_range = (y[i], y[int(i * factor) % limit])
                yield mlines.Line2D(x_range, y_range)
        else:
            for i in range(limit):
                start = (x[i], y[i])
                index = int((i * factor) % limit)
                end = (x[index], y[index])
                yield end, start

Now it's time to plot and in the `plot_circle_points`, both the circle, the points and the labels are ploted

    ::python
    def plot_circle_points(x, y, ax, labels=None):
        ax.annotate("Points: {}".format(len(x)), (0.8, 0.9))
        ax.plot(x, y, "-ko", markevery=1)
        if not labels is None:
            for i, (x, y) in enumerate(zip(x, y)):
                ax.annotate(i, (x, y))

Finally, a function which receives the axis object plot all the lines, with the option to use a color in a HSV format (this will be used in the final animation)

    ::python
    def plot_lines(x, y, factor, ax, color=None):
        ax.annotate("Factor: {}".format(factor), (0.8, 1))
        lines = list(get_lines_from_points(x, y, factor))
        if color is None:
            line_segments = LineCollection(lines)
        else:
            line_segments = LineCollection(lines, colors=colorsys.hsv_to_rgb(color, 1.0, 0.8))

        ax.add_collection(line_segments)

## Static Version

After all the functions needed are defined, now plotting a static version is quite simple, just generate the axis object and invoke the functions in the logical order and you get the image. This approach is useful to quickly experiment with a fixed number of factor and points

    ::python
    def plot_static(factor, points):
        plt.figure(figsize=(10, 10))
        ax = plt.subplot()
        plt.axis('off')

        x, y = points_arround_circle(number=points)

        plot_circle_points(x, y, ax)
        plot_lines(x, y, factor, ax)

    factor = 2
    points = 100
    plot_static(factor, points)

![times-table-2-100]({attach}images/times_tables/times-tables-2-100-thumbnail.png){: .narrow .b-lazy width=900px data-src=/blog/images/times_tables/times-tables-2-100.png }

## Parametric Version

One approach is to manually change the `factor` and `points` variables and then just execute the cell/funtion again but since Jupyter provides support for interaction, a more user friendly approach can be used through Sliders (a built in UI of IPython). Here the function `plot_parametric` is exactly the same as `plot_static` but it uses `plt.show()` at the end to plot the image. Here the image is also static but can be change moving the sliders to either side.

    ::python
    def plot_parametric(Factor=2, Points=100):
        plt.figure(figsize=(10, 10))
        ax = plt.subplot()
        plt.axis('off')
        x, y = points_arround_circle(number=Points)
        plot_circle_points(x, y, ax)
        plot_lines(x, y, Factor, ax)
        plt.show()

    factors = [21, 29, 33, 34, 49, 51, 66, 67, 73, 76, 79, 80, 86, 91, 99]
    print("Try these Factors with different number of points:", *factors)

    interact(plot_parametric, 
            Factor=FloatSlider(min=0, max=100, step=0.1, value=2, layout=Layout(width='99%')),
            Points=IntSlider(min=0, max=300, step=25, value=100, layout=Layout(width='99%')));

## Animate Construction Line by Line

Now we move to animations and in this first animation both the factor and the number of points are fixed, which changes is the lines, this animations mimics the process of drawing some of theses times tables by hand and could also give some insight about the order in which the lines are plotted instead of just seen them all at once.

Animations in Matplotlib are built through an `animate` function, which basically returns the objects to be printed in each frame. That's why in this animation and the following, two functions should be defined, one for the `animate` API of matplotlib and the other to embed in the `interact` function of IPython. Here a `line_by_line` takes a given `Factor`, a number of `Points` and an `Interval`, the first two are already familiar since we used them in the previous functions and the `Interval` is just the delay between frames in miliseconds, it is tightly related to the FPS of the final animation: `FPS = 1000 / delay`.

    ::python
    def animate_line_by_line(i, lines, ax):
        ax.add_line(next(lines))
        return []

    def line_by_line(Factor, Points, Interval):
        fig, ax = plt.subplots(figsize=(10, 10));
        plt.axis('off')
        x, y = points_arround_circle(number=Points)
        plot_circle_points(x, y, ax)
        ax.annotate("Factor: {}".format(Factor), (0.8, 1))
        ax.annotate("Interval: {}".format(Interval), (0.8, 0.8))
        lines = get_lines_from_points(x, y, Factor, animated=True)
        anim = animation.FuncAnimation(fig, animate_line_by_line, frames=len(x)-2, interval=Interval, blit=True, fargs=(lines, ax));
        plt.close()

        return anim

    interact(line_by_line,
            Factor=FloatSlider(min=0, max=100, step=0.1, value=2, layout=Layout(width='99%')), 
            Points=IntSlider(min=1, max=200, step=1, value=100, layout=Layout(width='99%')),
            Interval=IntSlider(min=5, max=500, step=5, value=75, layout=Layout(width='99%')));

<video class="b-lazy" autoplay loop width=900>
    <source data-src="/blog/images/times_tables/line_by_line.mp4" type="video/mp4">
</video>

## Animate Construction Point by Point

Taking another perspective, maybe what's interesting isn't how the lines are plot but rather how the figure gets clearer when we add more points so in this animation the `factor` is fixed and the lines are plotted all at once but each frame increases the number of points from 0 to a given number of `MaxPoints`.

    ::python

    def animate_point_by_point(i, ax, Factor, Interval):
        ax.cla()
        ax.axis('off')
        ax.set_ylim(-1.2, 1.2)
        ax.set_xlim(-1.2, 1.2)
        ax.annotate("Interval: {}".format(Interval), (0.8, 0.8))
        x, y = points_arround_circle(number=i+1)
        plot_circle_points(x, y, ax)
        plot_lines(x,y,Factor, ax)
        return []

    def point_by_point(Factor, Interval, Max_Points):
        fig, ax = plt.subplots(figsize=(10, 10));
        anim = animation.FuncAnimation(fig, animate_point_by_point, frames=Max_Points, interval=Interval, blit=True, fargs=(ax, Factor, Interval));
        plt.close()

        return anim

    interact(point_by_point,
            Factor=FloatSlider(min=0, max=100, step=0.1, value=2, layout=Layout(width='99%')),
            Max_Points=IntSlider(min=1, max=200, step=1, value=75, layout=Layout(width='99%')),
            Interval=IntSlider(min=100, max=500, step=1, value=200, layout=Layout(width='99%')));

<video class="b-lazy" autoplay loop width=900>
    <source data-src="/blog/images/times_tables/point_by_point.mp4" type="video/mp4">
</video>

## Animate Construction Factor by Factor

Now the animation showed in the video, which the number of points fixed and all lines are plotted at ones but the factor is increased frame by frame. When the factor is increased with a step of 1, the animation changes drastically so in for this example the factor is changed by steps of 0.1, to achieve a smoother animation. This version is monochrome, all the lines are always the same color.

    ::python
    def animate_factor_by_factor(i, ax, Max_Points, Interval, frames):
        ax.cla()
        ax.axis('off')
        ax.set_ylim(-1.2, 1.2)
        ax.set_xlim(-1.2, 1.2)
        ax.annotate("Interval: {}".format(Interval), (0.8, 0.8))
        x, y = points_arround_circle(number=Max_Points)
        plot_circle_points(x, y, ax)
        plot_lines(x, y, i / 10, ax)
        return []

    def factor_by_factor(Factor, Interval, Max_Points):
        fig, ax = plt.subplots(figsize=(10, 10));
        frames = int(Factor * 10)
        anim = animation.FuncAnimation(fig, animate_factor_by_factor, frames=frames, interval=Interval, blit=True, fargs=(ax, Max_Points, Interval, frames));

        plt.close()

        return anim

    interact(factor_by_factor,
            Factor=FloatSlider(min=0, max=100, step=0.1, value=5, layout=Layout(width='99%')),
            Max_Points=IntSlider(min=1, max=200, step=1, value=100, layout=Layout(width='99%')),
            Interval=IntSlider(min=50, max=500, step=25, value=100, layout=Layout(width='99%')));

<video class="b-lazy" autoplay loop width=900>
    <source data-src="/blog/images/times_tables/factor_by_factor.mp4" type="video/mp4">
</video>

## Animate Construction Factor by Factor with Color

Just as the previous one but with color added, in this case an additional `frames` parameter is passed to the `animate_factor_by_factor_colored` function and this value is the total number of frames so the HSV system is used with fixed Saturation and Value and the Hue is changing from 0 to 1 depending on the frame. To achieved this, the current frame `i` is divided by the total number of frames `frames`, and thus ranging from 0 to 1.

    ::python
    def animate_factor_by_factor_colored(i, ax, Max_Points, Interval, frames):
        ax.cla()
        ax.axis('off')
        ax.set_ylim(-1.2, 1.2)
        ax.set_xlim(-1.2, 1.2)
        ax.annotate("Interval: {}".format(Interval), (0.8, 0.8))
        x, y = points_arround_circle(number=Max_Points)
        plot_circle_points(x, y, ax)
        plot_lines(x, y, i / 10, ax, color=i / frames)
        return []

    def factor_by_factor_colored(Factor, Interval, Max_Points):
        fig, ax = plt.subplots(figsize=(10, 10));
        frames = int(Factor * 10)
        anim = animation.FuncAnimation(fig, animate_factor_by_factor_colored, frames=frames, interval=Interval, blit=True, fargs=(ax, Max_Points, Interval, frames));

        plt.close()

        return anim

    interact(factor_by_factor_colored,
            Factor=FloatSlider(min=0, max=100, step=0.1, value=5, layout=Layout(width='99%')),
            Max_Points=IntSlider(min=1, max=200, step=1, value=100, layout=Layout(width='99%')),
            Interval=IntSlider(min=50, max=500, step=25, value=100, layout=Layout(width='99%')));

<video class="b-lazy" autoplay loop width=900>
    <source data-src="/blog/images/times_tables/factor_by_factor_colored.mp4" type="video/mp4">
</video>

## Export

Every animation generated can be exported as an mp4 file. It simply needs to call the function, store the result in a variable and then use the following snipped. Change `Specific_function` with the one you like, and place the corresponding parameters. For instance: `factor_by_factor_colored`, `animate_point_by_point`

    ::python
    anim = Specific_function(*args)

    Writer = animation.writers['ffmpeg']
    writer = Writer(fps=30)

    anim.save('filename.mp4', writer=writer)

## Notebook

Everything showed above can be executed without installing anything just by using Binder, [**open the gist online**](https://elc.github.io/link/times_table_binder){: target="_blank"} and experiment yourself.
