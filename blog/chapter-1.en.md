Title: My journey through the probability world
Date: 2018-01-05
Category: Programming
Tags: probability
Slug: probability-world
Authors: Ezequiel Castaño
Lang: en
HeaderImage:
level:
jupyternotebook:
Status: draft

How I re-discover probability and statistics even after taking a course at university thanks to the book "Bayesian Methods for Hackers"

<!-- PELICAN_END_SUMMARY -->

# The background

I'm an engineer student and most people may think that I love math, actually that's true, I love it but when it comes to probabily theory and statistics there was always something it feelt unnatural. Some probability here and there and you get a number that answer your questions, in the middle you use lots of formulas which can be very intimidating and at the end you get a number you don't know the meaning of.

That was my vision of probability and statistics until weeks ago. I was looking for something interesting to learn [in a python conference] and it turned out that probability was a common topic (specially in 2015-2017) and I wonder why it was like that. I know that the basics of Machine Learning in general relies heavily in statistics but even when there were lots ML courses out there probability ones doesn't seem too popular or at least as popular as ML.

# The Book

Doing a bit of research and watching some of the tutorials and talks at conferences about that topic I found that there was a book that was constantly mentioned and that book was [Bayesian Methods for Hackers] by Cameron Davidson-Pilon. The book objective is to fill the gap there is between begginer and advance guides on the internet. I find it interesting enough so I start reading it.

# My Perspective

After reading the first chapter I thought I missed somehting, I could understand everything but yet I wasn't able to understand the thinking process behind the scenes. I knew what have been done but I didn't understand why and how exactly. So as a python programmer my first attempt to understand was to do everything from scratch, experiment a bit and see the dinamics.

# The notebook

My approach was the following, I re-read the chapter and as soon as I found something I could transform into an image, I do it.

The result was a notebook with interactive features to understand what happen when you change the parameters dinamically, how that impact on the image and why that matters. I was trying to understand the behaviour of the model and I succedded in doing so.

I want to share with you the notebook and give all the possibility to play with it as I'd like when reading the book. In order to get interactivity in the notebook.

# The experience

From now on you will have 3 ways to continue:

- Active: If you already know a bit of jupyter notebooks you can just downlaod the files from the repository (see the badge at the top) and run them in your computer
- New: In case you aren't familiar with notebooks or maybe you just couldn't do it right now, you have the option of opening notebook in an interactive session through binder (much like try jupyter), this will create a completely provided environment for trying and experimenting, be careful, none of what you do will be save, you have to download the file manually if you want to save your changes
- Passive: If you rather prefer a passive role, continue reading and you will find images (SVGs) and animations (GIFs) that reflect what's written in the notebook. However, reading the notebook would be the only option to see the code that generate those outputs (this is mainly for easy update and fix the code in only one place)

# Understanding random variables

Random variables are variables you don't know the exact value of, but what you do know (in most cases) is their distribution, the distribution is the probability that a random variable will get a specific value.

Typically random variables are divided in two categories:

- Discrete
- Continous

# Discrete random variables

Discrete random variables can only take integer values (like when we count), typically used on sales, populations and stock managment. There are specific distributions for this type of random variables.

Each distribution has several properties that are not only interesting but also provided a better understanding of the behaviour but to keep it as simple as possible I want to focus on a single aspect: How does the shape of a particular distribution change when we vary the parameters?

There are lots of distributions both discrete and continous, here we will look at just a few, namely:

- Bernoulli
- Discrete uniform
- Binomial
- Poisson
- Geometric
- Hypergeometric

We will see each in order, since they are all discrete we will use a very handy graph, bar graph, each bar will represent two things: first, its position represent a particular value for the random variable and second its height represent how likely that value is.

## Bernoulli

It's the simplest of all, just one parameter ($p$) as input, two possible values ($0$ and $1$) as outputs. It's often used to model yes/no questions.

The parameter $p$ represents the probability of getting a $1$ and $q$ represents the probability of getting $0$ but since there is no other possibility and probabilities always add to $1$: $q = 1 - p$

Here is how it looks like for $p = 0.2$

![images]({attach}images/chapter-1-1.svg)

It might seem trivial but lets see how it changes as we change $p$