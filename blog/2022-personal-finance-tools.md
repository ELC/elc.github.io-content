Title: Lessons learnt After Developing Finance Web Tools with Streamlit and Altair (No HTML/CSS/JS)
Date: 2022-01-14
Category: Programming 
Tags: Streamlit, Python, Altair
Slug: streamlit-lessons
Authors: Ezequiel Leonardo Castaño 
Lang: en 
Headerimage: https://elc.github.io/blog/images/streamlit-lessons/streamlit-lessons_headerimage.png

[![Jupyter Publishing Header Image]({static}images/streamlit-lessons/streamlit-lessons_headerimage-thumbnail.png){: .b-lazy width=1444 data-src=/blog/images/streamlit-lessons/streamlit-lessons_headerimage.png }](/blog/images/streamlit-lessons/streamlit-lessons_headerimage.png)

<!-- PELICAN_BEGIN_SUMMARY -->

There are a lot of resources available online about personal finances, stocks,
markets, cryptos, and many more economy-related topics. However the decisions
one has to make should be informed in order to be good enough. This post covers
the lessons learnt after developing similar tools using Streamlit and Altair.
No HTML/CSS/JS were needed. This post will make the reader aware of some pros
and cons of this libraries and also show an example app.

<!-- PELICAN_END_SUMMARY -->

This post is one part of a three posts series regarding Streamlit, the posts
can be read in any order and the three are built around the same demo app:

- **Lessons learnt After Developing Finance Web Tools with Streamlit and Altair (No HTML/CSS/JS)** (this post)
- [Add Google Analytics (or any custom HTML) to Streamlit with Github Pages]({filename}./2022-streamlit-google-analytics.md)
- [Multipage, State-Persistent Apps with Streamlit]({filename}./2022-streamlit-multipage.md)

## Disclaimer

The author has no formal education in economics nor any related field, these
tools have been thought for personal use only and may contain bugs or
inaccuracies. They are provided for free "as is".

## TL;DR

This post explains how this 
[web app](https://elc.github.io/finance-tools/){:target="_blank"} 
was developed with a focus on  Streamlit, streamlit-multipage, NumPy, pandas
, and Altair. The full code is available on
[this Github Repo](https://github.com/ELC/finance-tools){: target="_blank"}

The app covers topics like compound interest, flex term vs fixed terms,
inflation adjustment, fee recovery, and asset past profitability. If the reader
is already familiar with these topics, it is suggested to check the app and
come back in case of questions.

## Warning

This is NOT an economy/finance post, it is a technical post about the
**development** of personal finance tools, do not expect full details about the
economic part, there are plenty of other resources online. This post will focus
on the Python implementation, in particular in the use of Streamlit,
Streamlit-MultiPage and Altair.

## Personal Finance Tools

Finance is a subject that in many cases is not taught in the depth it should,
meaning there is a lot of confusion, misinformation and in many topics, scams.
That is why having open-source and free tools to help taking decisions is
critical nowadays.

This is a showcase of some of what is possible with Python, thanks to libraries
like Streamlit that convert scripts into web apps and Altair that generate
transparent vector plots, it is now easy to develop tools that everyone can
use.

### The State of the Art

In the particular case of investing, there are already two pages that dominate
the market [Investing](https://www.investing.com/){: target="_blank"} and
[TradingView](https://www.tradingview.com/){:target="_blank"}. Both have free
and paid plans and this post does not focus on that type of apps, but rather
much simpler ones.

For example, can someone confidently invest in stocks or crypto if they do not
understand how inflation or compound interest work? Sure it is technically
possible, but the decision is not informed. The apps developed help to fill
that gap and give the first contact with terms like inflation, interest and
Fixed/Flex Terms.

At the moment on the internet there are plenty of online tools to achieve the
same, those, however, are typically calculators that only return a single value
and/or whose code is not available. In many cases, they "refer to the formula".
Those apps have a main focus on computing, not teaching, if someone does not
know how interests work, giving them the final interest at the end of the
period might help but it is not the whole story.

That does not mean that the apps developed are the best online by any means
but, by providing the code and a more customizable UI, the user can experiment
more and "learn while doing" instead of staring at formulas that seem cryptic
at times.

### The Challenge

Making something technically sound and user-friendly at the same time is a
challenging task. The more visual a tool is, the more likely it is for the
reader to understand how it is working and the underlying principle behind the
tool.

Since the author has no formal education in economics or finance, it was also
important to provide an easy way for others to contribute to fix bugs and add
enhancements. That is why an open-source solution is a must in this case.

To the best of the author's knowledge, there are no Python-based tools like the
developed, so the added-value lies not only in the tools themselves but also
because the project serves as a baseline for future related projects.

It was also important to reduce the entry barrier as much as possible so that
only some programming skills are needed to extend the existing apps.

### The Result

The result of this is having a web app that can be easily used by anyone
with or without programming/economics knowledge and it is as easy to maintain
and extend as possible. The app is 
[already online](https://elc.github.io/finance-tools){: target="_blank"} 
and can be used.

The next section will focus on the technology more in-depth.

## The Python Implementation

The project uses Python, a programming language with a mature ecosystem of
libraries like the Scipy Stack but at the same time it is an easy-to-learn
language which can be taught in very few time. 

That being said, to generate a fully working web app, web technologies should
be used. Fortunately, there are Python libraries that allow the developer to
bypass that step.

### Stack

The different apps within the project use the same stack which is:

- [Python](https://www.python.org/){: target="_blank"} as the base programming language
- [Streamlit](https://streamlit.io/){: target="_blank"} to handle the "web part"
- [Streamlit-multipage](https://github.com/ELC/streamlit-multipage){: target="_blank"} to bundle different apps together
- [Altair]https://altair-viz.github.io/ for plots
- Scipy Stack ([Numpy](https://numpy.org/){: target="_blank"}, [Pandas](https://pandas.pydata.org/){: target="_blank"} and [Scipy](https://scipy.org/){: target="_blank"}) to run simulations faster
- [YFinance](https://pypi.org/project/yfinance/){: target="_blank"} to download ticker information
- [Joblib](https://joblib.readthedocs.io/){: target="_blank"} (optional) for the persistence of state, fallbacks to `pickle`

The choice of the dependencies and the pros and cons will be extended in the
upcoming sections. The main objective was to keep the project simple and avoid
lesser-known libraries when possible.

All the code is 
[hosted on Github](https://github.com/ELC/finance-tools){: target="_blank"} 
and can be starred, forked or clone right away.

### Simulation Challenges

The defacto standard for numerical simulations is the Scipy Stack, there have
been some challenges though as some of the processes do not have a closed
formula one can translate to Python.

In some cases like the Inflation Simulation a 
[pure numpy solution](https://github.com/ELC/finance-tools/blob/a4a138b55fb2fa1638a1ff763038736b9db14b41/pages/inflation.py#L74-L105){: target="_blank"} 
could be achieved, but in others like the compound interest with recurring
deposits with a different frequency than the compounding frequency a 
[for-loop](https://github.com/ELC/finance-tools/blob/a4a138b55fb2fa1638a1ff763038736b9db14b41/pages/common.py#L125-L178){: target="_blank"} 
approach was used.

Nevertheless, even native for-loops being several orders of magnitude slower
than NumPy, that was not the bottleneck of the app. The bottleneck was the
plotting step, since the length of the data in these apps is usually under the
tens of thousands which is fast enough, even when using native for-loops.

Having the app running locally would be enough for personal use however many
non-technical people would have been excluded when doing so. Therefore, having
the app available online is just as important as it working properly.

### Deployment Process

To deploy Streamlit apps there are two alternatives:

- Hosted by [Streamlit Sharing](https://share.streamlit.io/){: target="_blank"} (Community plan is free forever)
- Self-Hosted

The self-hosted approach will involve either server or Docker configuration and
thus will not be covered in this post.

The use of Streamlit Sharing and how to deploy a streamlit app there has been
already covered in detail in other of the posts in this Streamlit Series. That
post also covers how to achieve Google Analytics (or any custom HTML)
integration in the app, although that would be only relevant for the
tech-savvy.

## Streamlit Review

Streamlit alone is a feature-rich, well-documented, and tested library,
however, it would have been impractical to have several small streamlit apps.
This is something also found in other online tools, they provide "Several
calculators" each in different pages hindering accessibility and visibility.

However, streamlit does not support multi-page apps by default, which could be
achieve by using [`streamlit-multipage`](https://github.com/ELC/streamlit-multipage){: target="_blank"}
, a third-party library.

**DISCLAIMER**: The author is not the original developer of
`streamlit-multipage` but has contributed significantly to that library.

In one of the other posts in this Streamlit series, there is an extended
explanation on how to use this library and what is possible.

The rest of this section will cover unresolved issues to consider when
developing this kind of apps.

### Hot reload could be harmful

By default, each time there is a change in any of the Streamlit Visual
components, it triggers the execution of the whole app. This behavior might
deteriorate the user experience if there are many inputs and the process takes
more than a few seconds.

Having a "Run Button" is possible without any plugins but the "magic update" of
streamlit is definitely a feature no one would want to lose.

### Lack of skeleton elements

A related issue to the previously mentioned is that when streamlit is
"Loading" or "Processing" there is no visual hint for the user that this is the
case. No spinners, skeletons, or anything like that. This should not be a
problem for fast apps but in the case of taking several seconds, this might
result in a suboptimal user experience.

There is no straightforward way to mitigate this besides programming the
loading/skeletons themselves as independent Streamlit Components.

### Lack of basic HTML Elements

Streamlit combines Python and Web Technologies (in particular React) in a
clever way, abstracting every web-related from the Python side. That has its
costs though, thinking of custom yet basic HTML elements like a "Click me
Button" that redirects to a page might be non-trivial to do and might require
either custom HTML with styling or designing a React component just for that
which seems excesive.

Streamlit is ideal for the use cases it was thought but deviating too much from
it might increase developing time significantly and make the learning curve
much steeper.

### Persistence might be complex

Even though the `streamlit-multipage` provides persistence mechanisms, they
were tested in Streamlit Sharing. This is because of how streamlit works under
the hood, it runs "the whole script" with every change, making any kind of
"initialization code" extremely hard to avoid repeating with each change.

There is support for some basic native persistence through `st.session_state`
but it has not been optimized for multipage apps nor it provides two-way
binding as one might be used to from Front-End frameworks.

### Streamlit Conclusion

Streamlit is not the only of its kind, there is Panel, Dash, Voila, and there
might be more in the future. That being said, Streamlit was the best tool for
the job in this case for many reasons, it does not really on other tools (dash
is heavily tiered towards plotly and voila works on Jupyter), and it has a
mature and responsive community (panel is lacking in this aspect.)

Streamlit alone was initially not enough due to the lacking multipage support
but using `streamlit-multipage` solved this without disrupting the streamlit
developer experience.

## Altair Review

[Altair](https://altair-viz.github.io/){: target="_blank"}
 is a plotting library that aims to provide a "declarative interface" rather
than a "descriptive interface", in practice, this allows for simpler code and
more code re-use.

It is not the most popular tool by any means, that would be matplotlib but one
of the main disadvantages of the latter is that there is no support for
transparency. Transparency might be a not-so-important feature, but, since
Streamlit has a light and a dark theme, a transparent plot is necessary to
ensure a consistent visual design that is not compatible with Matplotlib.

On the other side, matplotlib is much faster than Altair, this might change in
the future but at least when using Altair one has to limit the number of data
points to 5000. That being said, the interactiveness Altair provides makes it a
perfect fit for web apps.

Learning Altair requires some time but if one is already familiar with
matplotlib the learning curve is a bit flatter. There are many good materials
already available to learn on 
[PyVideo](https://pyvideo.org/search.html?q=altair){: target="_blank"}.

### Verbosity and Modularity

Unless using the defaults, producing highly customized plots requires many
lines of code, regardless of the plotting library. The main difference with
Altair is that those "extra-custom-lines" could be re-use across plots.

This is an example to add a text tooltip

```python
def add_text(chart, field, selection):
    return (
        chart.mark_text(align="right", dx=-5, dy=-12, color="white", fontSize=18)
        .encode(text=field)
        .transform_filter(selection)
    )
```

This function returns an Altair object given a chart, a field, and a selection,
that means that one can add the same tooltip to many plots at the same time
while keeping the code centralized in a separate file.

This is an underrated feature that allows to re-use code and becomes critical
when using multiple somewhat similar plots.

### Altair is slow

The main disadvantage of Altair is that everything that happens is handled over
to Vega-Lite, the library Altair is built on. This means that Altair is much
slower than other plotting libraries, this is especially true when compared
with matplotlib. 

Even so, having tooltips, panning and zooming are features that are worth the
wait and the final user will notice the difference because the quality of the
end result is evident.

### Altair Conclusion

There are many options when deciding over a plotting library, the most popular
by far is Matplotlib, however, for web apps, it is lacking the features many
consider basic like zooming and panning. And having the possibility to re-use
code across plots is something that makes Altair a very good fit for any large
software project.

There are drawbacks like the data point limit and the slowness, a balance
between the two should be found and it will depend on every app.

## Overall Conclusion

Developing Web Apps with Python has never been easier, Python has a strong
mathematical and computational stack that makes most computations fast and
efficient. It also has an ecosystem that makes it suitable for most use cases
and on top of that, it is considered one of the easiest programming languages
to learn.

Thanks to libraries like Streamlit and Altair, one can now develop web apps and
make them available online so everyone can benefit from these amazing tools in
more tangible ways.

There are some issues but the author believes this will be solved in the middle
term as the libraries evolve and improve themselves.

The 
[Personal Finance Tools](https://elc.github.io/finance-tools/){: target="_blank"} 
is online and ready to use, the code is 
[hosted in Github](https://github.com/ELC/finance-tools){: target="_blank"} 
as well.

## Check the Series

If you liked this post, it is highly likely that you will also like the other
in this 3 part Streamlit Series:

- **Lessons learnt After Developing Finance Web Tools with Streamlit and Altair (No HTML/CSS/JS)** (this post)
- [Add Google Analytics (or any custom HTML) to Streamlit with Github Pages]({filename}./2022-streamlit-google-analytics.md)
- [Multipage, State-Persistent Apps with Streamlit]({filename}./2022-streamlit-multipage.md)
