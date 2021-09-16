Title: Pascal Triangle and Genetic Algorithm - A Visualization
Date: 2019-01-21
Category: Data Visualization
Tags: Data Visualization, Python, Matplotlib, Animation
Slug: pascal-triangle-vs-genetic-algorithm
Authors: Ezequiel Leonardo Castaño
Lang: en
headerimage: https://elc.github.io/blog/images/pascal_triangle/pascal_triangle_headerimage.gif

<!-- PELICAN_BEGIN_SUMMARY -->

Inspired by a Wikipedia article, I replicate a way to visualize the Pascal Triangle and used the same approach in Genetic Algorithms

<!-- PELICAN_END_SUMMARY -->

Once I came accross this [wikipedia article about Pascal Triangle](https://en.wikipedia.org/wiki/Pascal%27s_triangle){: target="_blank"}, there you can find the following animation:

![pascal_triangle_animation](https://upload.wikimedia.org/wikipedia/commons/6/66/Pascal%27s_Triangle_animated_binary_rows.gif){: .narrow width=576}

I found it interesting to replicate this very animation in Python, just as a challenge and maybe later I would find a useful application for it. At [**the end**](#notebook) I will add a link to the jupyter notebook so you can experiment your own variants. If you want, you can jump directly to the [**genetic algorithm application**](#application-in-genetic-algorithms).

First, there are some tools we need to install:

- Jupyter (Optional): Notebook Interface
- Numpy: For array manipulation
- Matplotlib: For visualization and animation
- ffmpeg (Optional): For exporting the animation

Once everything is installed, we need to understand what is necessary, I decided to split the code in 5 parts, although it can be a single file script. The final result is the following:

<video class="b-lazy" autoplay loop width=900>
    <source data-src="/blog/images/pascal_triangle/pascal_triangle.mp4" type="video/mp4">
</video>

### Initialization

First, import everything needed, this should be the first cell in the notebook or be placed at the top of the script

    ::python
    import matplotlib.pyplot as plt
    import numpy as np
    from matplotlib import animation
    from IPython.display import HTML # Only required for Jupyter

    %matplotlib inline # Only required for Jupyter

### Pascal Triangle

Secondly, define the proper functions to create a Pascal triangle, since for every frame only the last row is represented, a separate function that returns only that row is generated, to avoid unnecessary array manipulation. Additionally since many frames could be asked, it's important to cache the intermediate results since every pascal triangle is build based on the previous one, for this purpose a technique named memoization is used and this is the reason of why pascal_triangle is a recursive function.

    ::python
    def memoize(f):
        memo = {}
        def helper(x):
            if x not in memo:
                memo[x] = f(x)
            return memo[x]
        return helper

    @memoize
    def pascal_triangle(n):
        if n == 0:
            return [np.array([1])]
        prev = pascal_triangle(n - 1)[-1]
        middle = np.add(prev[:-1], prev[1:])
        return pascal_triangle(n - 1) + [np.array([1, *middle, 1], dtype=np.ulonglong)]

    @memoize
    def pascal_last_row(n):
        return pascal_triangle(n)[-1]

### Animation Function

Thirdly, Matplotlib asks a function to animate which will generate each frame. For this purpose each frame is generated, adding extra white space to the sides when needed and returning a blank image for the 0 frame

    ::python
    def animate(i, length, ax, width):
        if i == 0:
            im = ax.imshow([[0],[0]], cmap='Greys', aspect='equal', extent=(0, width - 2, 0, length), animated=True)
            return im,

        elements = pascal_last_row(i)

        extra_space = [0] * ((width - len(elements) - 1) // 2)

        elements = extra_space + list(elements) + extra_space

        real_width = len(elements)

        if real_width % 2 == 1:
            real_width -= 1

        binary_elements = []

        for j in elements:
            row = []
            for k in bin(j)[2:].zfill(length):
                row.append(int(k))

            binary_elements.append(row)

        im = ax.imshow(np.transpose(binary_elements), cmap='Greys', aspect='equal', extent=(0, real_width, 0, length), animated=True)

        return im,

### Animation Video

Finally, the main part of the script is where the crucial variables are defined such as the number of frames and the width of the window.

    ::python
    frames = 20
    last_row = pascal_last_row(frames)
    length = len(bin(max(last_row))[2:]) - 1
    width = len(last_row)

    aspect_ratio = width / length

    frame_width = 8

    fig, ax = plt.subplots(figsize=(frame_width, frame_width / aspect_ratio))

    fig.subplots_adjust(left=0, bottom=0.01, right=1, top=1)

    ax.set_xticks([]) 
    ax.set_yticks([]) 

    if frames % 2 == 0:
        width += 1

    anim = animation.FuncAnimation(fig, animate, frames=frames, interval=1000, blit=True, fargs=(length, ax, width))

    plt.close() # Avoid extra picture

    HTML(anim.to_html5_video()) # Only required for Jupyter, replace this line with plt.show() for scripts

### Export

As a bonus, if the animation is needed as a separate file, ffmpeg can be used through Matplotlib to generate the corresponding mp4 file

    ::python

    Writer = animation.writers['ffmpeg']
    writer = Writer(fps=1, metadata=dict(artist='Me'), bitrate=1800)

    anim.save('im.mp4', writer=writer)

## Final Result

As seen at the beginning the previous code resulted in the following animation:

<video class="b-lazy" autoplay loop width=900>
    <source data-src="/blog/images/pascal_triangle/pascal_triangle.mp4" type="video/mp4">
</video>

## Notebook

Everything showed above can be executed without installing anything just by using Binder, [**open the gist online**](https://elc.github.io/link/pascal_triangle_binder){: target="_blank"} and experiment yourself.

## Application in Genetic Algorithms

When I started this visualization challenge, I had no application in mind but then I realized the same approach could be used for visualizing the genotype of a population of chromosomes in a traditional genetic algorithm. Each colum would represent a chromosome instead of a number each row a particular gene for each chromosome, being black if the gene is 1 and white if it is 0. This approach asumes a binary genotype configuration. Then another possible improvement is to sort them by fitness, the ones with the highest fitness on the left and the ones with the lowest on the right. Sorting them could help understanding patterns in the genotype that might not be obvious in the phenotype.

This is the result of finding the maximum of a function with elitism and high mutation. Each frame represents a population the next frame represents the childs of the previous one. The source code that generates this animation can be found in my [**personal github repository**](https://elc.github.io/link/genetic_algorithm_repo){: target="_blank"}

<video class="b-lazy" autoplay loop width=900>
    <source data-src="/blog/images/pascal_triangle/genetic_algorithm.mp4" type="video/mp4">
</video>