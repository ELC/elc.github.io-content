Title: A posible Roadmap to Learn Bayesian Statistics
Date: 2020-03-30
Category: Simulation
Tags: Simulation, Programming, Math
Slug: bayesian-roadmap
Authors: Ezequiel Leonardo Castaño
Lang: en
Status: draft
<!-- Headerimage: https://elc.github.io/blog/images/elevator-simulation/elevator-simulation-headerimage.png -->
<!-- Status: draft -->


<!-- PELICAN_BEGIN_SUMMARY -->

Nowadays Bayesian Methods are quite popular in the artificial inteligence / machine learning community. But there is no clear path to start learning about this new techniques. I experienced on first hand the fact of being confused and intimidated by the level of some tutorials / guides. That is the main reason I write this post, to give an **opinonated** roadmap about how I think is the best way to learn Bayesian Statistics.

<!-- PELICAN_END_SUMMARY -->

## Prior Assumptions

For this post, some background knowledge is assumed, namely:

1. The reader knows Python
1. The reader has a *basic* understanding of probability
1. The reader wants to **understand** and not simply *use* Bayesian Methods

## How to use this post

This post is a compilation of different tutorials, videos and guides and is thought to be use as a reference. All the external resources will be linked here and you can jump directly to the last one you have done using the below index. For each of the resources there will be questions to make sure you correctly understood the critical aspects.

## The Roadmap

There are two main approaches to Bayesian Statistics:

- Mathematical
- Programmatical

The mathematical approach is powerful to describe simple relationships but yet limited, because when the models is complex enough, there is no mathematical solution (it is also said that there is no closed-form solution). However, the concepts from this perspective are foundational to really understand what can be done through programming.

That beign said, starting with formulas and textbook problems is usually what most discourages new users. Therefore I believe that the best approach is start with some programming, then getting the math and finally combining all together.

## Step 1: Key Concepts

Estimated Duration: **2hs**

In this step the most important part is to get familiarized with the Bayesian Terminology. The main focus will be on Approximate Bayesian Computation (ABC), where all the code will be written from scratch, without libraries involved, so that the results will be simple enough to understand.

To achieved this, the best resource available is the 4 Part Series from Rasmus Bååth. The videos and their questions are below:

### Part 0

https://www.youtube.com/watch?v=Rvbs9OB2pa0

Questions:

- What is the Prior?
- What is the Prior Predictive?
- What is the Posterior?
- What is the Posterior Predictive

### Part 1

https://www.youtube.com/watch?v=3OJEae7Qb_o

Questions:

- What is the difference between Generative and Discriminative Models?
- What is a Prior?
- What is the Maximum Likelihood Estimated and how is it calculated?
- What is the difference between the Prior Mean and the Posterior Mean?
- What is a credible interval?

### Part 2

https://www.youtube.com/watch?v=mAUwjSo5TJE

Questions:

- What is the difference between an informative and a non-informative Prior?
- How an A/B testing should be performed? How we decide between two alternatives?

### Part 3

https://www.youtube.com/watch?v=Ie-6H_r7I5A

Questions:

- How is a hierarchical model build? (When we assing prior to the parameters themselves)
- What is the difference between the Data Space and the Parameter Space?


## Step 2: Adding Mathematical Background

Questions:

- What is the difference between Confidence Interval and Credible Interval?
- 
- What is a conjugate distribution?
- What does sample effect size mean?
- What should be consired when choosing Priors?


## Step 3: Implementing everything in PyMC3

