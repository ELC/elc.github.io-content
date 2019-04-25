Title: Complete Pelican Tutorial: Part 1
Date: 2017-11-10
Modified: 2010-12-05 19:30
Category: Python
Tags: pelican, publishing
Slug: my-super-post2
Authors: Ezequiel Leonardo Castaño
Lang: en
Status: draft
HeaderImage: https://blog.travis-ci.com/images/riley.gif
level: Begginer

This is a series of tutorials going from the basics up to advance configurations.

<!-- PELICAN_END_SUMMARY -->

## About the series

The topics in this series are divided in three categories, basics, intermediate and advance, each of which is a step by step process but you can skip the ones you know and jump directly to what you want. 

The main objective is that you can reproduce a website like this as fast as possible.

In this series we will cover the following topics

- Basics - You don't need to know programming at all:
    - Learn key concepts such as blog, static site generator and pelican
    - Use a predifined template (Copy paste)
    - Host the site online (GitHub Pages)
    - Create articles an pages online (Dillinger)
    - Add Continous Integration (TravisCI)
- Intermediate - Programming knowledge will help:
    - Understand the basic directory structure
    - Use Pelican Plugins
    - Use Custom Themes
    - Setting different configurations for developing and production
- Advance - Programming knowledge is necessary:
    - Customize the directory structure (SAVE_AS, SAVE_URL)
    - Modify themes to suit your needs (Jinja)
    - Explore Markdown extensions (Toc, Codehilite)
    - Add dependency chekers (PyUp)
    - Special notes and tips

## Pelican for non-programmers

This is the first part of the three part series about building a blog with Pelican, in this part no previous experience is required neither with programming or other blog technologies.

[TOC]

## What you will learn after reading this

- Key concepts such as blog, static site generator and pelican
- How to make your new blog available online (through GitHub Pages)

If you already know what a blog, a static site and pelican are, just [skip the following sections](#setting-up). If you consider yourself an advance user, you can check the [advance version of the tutorial](#pending).

## What's a blog?

A blog is a webpage usually containing articles and pages, the former being chronological and the latter static. Each article usually has tags, categories, author and comments. This website is an example of a blog.

Nowadays, a blog is the best way to show the world who you are in the way you want (apart from social networks).

In this series we are going to go to the step by step process, in case you want a little more "automatic" process you can rather go for a blogging platform (Such as WordPress, Wix, Blogger, [more on that here](http://www.wpbeginner.com/beginners-guide/how-to-choose-the-best-blogging-platform/)), in the next section we will see why using an Static Site Generator is a better solution for the overall user.

## What's an Static Site Generator?

There are two types of websites, static and dynamic. The differences are bit too technical for this basic tutorial but summarying, in static site every users "receive" the exact same page, while in a dynamic site we have customization and interaction (log in, admin panel, web apps are examples of dynamic sites). 

Dynamic sites usually requires a web server (where some app is running) and a databa server (where the data is stored). On the other hand, static sites only needs a single serves and no program is executed, all the work is done by the browser.

Static Site Generators (SSGs from now on) are special software that emulates the result one can get from a dynamic site but in a static format. For example, having a blog and publish articles or post is something you would probably do with a dynamic website but SSGs allow you to do "kind of the same" but with some great advantages but there are some caveats.

In case you want to analyse the whole scenario I recommend you to read these articles by Craig Buckler:

- [7 Reasons to Use a Static Site Generator](https://www.sitepoint.com/7-reasons-use-static-site-generator/)
- [7 Reasons NOT to Use a Static Site Generator](https://www.sitepoint.com/7-reasons-not-use-static-site-generator/)

If you have read both and still consider an SSG a good solution we will introduce a specific SSG in the next section and start working with it.

## What's Pelican?

Pelican is one of the numerous Static Site Generators available (check [StaticGen](https://www.staticgen.com/) for a full updated list). There are several reasons of why I'd personally choose Pelican being the most important the fact that I know Python (The programming language Pelican is built with). But in case you're not a developer choosing one SSG or another is just a matter of taste, look and feel and experience.

## Read this before start working

You have made a decision, you're going to make a website with Pelican, great! To make sure you won't have any trouble along the way I highly recommend you to read and research [How to write in Markdown](https://www.markdowntutorial.com/), also you will need an account on [GitHub](https://github.com/join). We will asumme that you have completed those steps in the next section

## Setting up

### Create Repository

From now on, everytime you see \<username> you should replace it with the username of your Github account

Once you logged in in GitHub you should create two repositories (Make sure to check the "Initialize this repository with a README" option):

- One named: \<username>.github.io
- Another named: \<username>.github.io-source

Double check if you spell the username correctly, otherwise it won't work. 

We will be working mainly on the second one so you can forget about the first one for now. 

### Directory Structure

In this part of the series we are not going to go deep in how to organize the directory structure, instead we are going to copy paste a template to make it as easy as possible. More detailed explanations will be given in the following parts of the series.

Just [download this template](https://codeload.github.com/ELC/elc.github.io-source/zip/Base) and extract it in whichever folder.

### File contents

We are almost ready, we now have to change some configurations and we are ready to go.

Use your favourite text editor (notepad or similar, NOT MS Word) and open these files

.travis.yml

In this file you should change the following line and replace /<username> with your github username:

    ...

    deploy:
        ...
        repo:<username>/<username>.github.io
        ...

Now you should open this file

conf.py

And change these lines with the data of your website

    ...
    SITEURL = 'https://<username>.github.io/'
    ...
    AUTHOR = '<Your name>'
    SITENAME = '<Your site name>'
    ...
    TIMEZONE = '<Your TimeZone>'
    # find it here:  https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
    ...


Addicionally we should configure TravisCI

$GITHUB_TOKEN is a public token you have associated with your GitHub account, you should [set it on the Travis CI Repository settings](https://docs.travis-ci.com/user/deployment/pages/#Setting-the-GitHub-token)


## Keeping it updated

Once you have everything set up you can commit and push, if you set the travis settings right you will be able to check your freshly generated blog at https://\<username>.github.io

To update the site simply commit and push