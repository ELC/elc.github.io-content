Title: Jupyter Publishing Guide: From Embedded to Book
Date: 2021-08-07
Category: Programming
Tags: Jupyter
Slug: jupyter-publishing
Authors: Ezequiel Leonardo Castaño
Lang: en
HeaderImage:

Jupyter Notebooks are the lingua franca for data science, however, sharing them
is not always straightforward. This is a brief survey of the different
publishing solutions available for personal and/or commercial projects.

<!-- PELICAN_END_SUMMARY -->

## Jupyter Notebooks

Jupyter notebooks are used everywhere in the data science ecosystem they are
present without exceptions, from Coursera Courses to projects by FAANG. It is
normal then to ask, once the work has been done, how can one conveniently
publish the results? The answer may not be satisfactory: "There is no
well-known, commonly used, standard way to publish Jupyter Notebooks", instead,
there are co-existing solutions that target different personas. Will the
results be presented to a non-technical audience? Will those results aim at
reproducibility? Is the focus solely on the code? Those questions require
different solutions as there is no one-size-fits-all.

In this post, a showcase of solutions for the different use cases will be
presented to the reader so that one can find the right tool for the job.

A general classification for the solutions could be as follows:

- Share notebooks among developers
- Share notebooks online
    - Read-Only
    - Read and Execute
- Print notebooks

All solutions here assume the only hardware and software available are the
ones used to work with the Jupyter Notebooks, i.e. No Server or backend.
Moreover, every solution presented is either open-source or free to use, both
for personal and commercial use cases.

This post will follow a cookbook approach, so feel free to jump ahead to the
section of interest, they are all self-contained. Each solution will contain
advantages, disadvantages, and a "when to use" section.

## Index

Main sections:

- [Context on .ipynb](#optional-a-bit-of-context-the-ipynb-format)
- [Built-in Solutions](#using-built-ins-export-solutions)
- [Read Only Solutions](#read-only-solutions)
    - [Gihub](#github-publishing)
    - [NBViewer](#nbviewer-publishing)
    - [Static Site Generator](#static-site-generator-integration)
    - [Static Jupyter Book](#jupyter-book-static)
- [Executable Solutions](#executable-solutions)
    - [Embedded](#embedded-solution)
    - [Google Colab](#google-colaboratory)
    - [MyBinder](#my-binder)
    - [Executable Jupyter Book](#jupyter-book-executable)
- [Printable Solutions](#printable-solutions)
    - [LaTeX Export](#built-in-export-latex)
    - [LaTeX/PDF Jupyter Book](#jupyter-book-for-printing)
- [What should I use?](#choose-the-best-tool)
- [Conclusion](#conclusion)
- [Additional Resources](#additional-resources)

## (Optional) A bit of Context: The .ipynb format

**[back to index](#index)**

The format for a Jupyter notebook is JSON but the extension used is `ipynb`.
The reason behind using a different extension is twofold:

1. Not every JSON is a valid ipynb
1. The file, although plain text, is not meant to be modified manually

When using Jupyter, the most common ways include `Jupyter Notebook` and
`Jupyter Lab`, and it is through these tools that modifications are written
into the underlying .json file. That ensures the file is always valid.
Modifying the .json manually could make the whole notebook unreadable and such
errors and difficult both to find and fix.

The official documentation for this format is available as the
[`nbformat`](https://nbformat.readthedocs.io/en/latest/){: target="_blank"} Python Package.

### Problems with the format

This JSON-based format is also the main cause of trouble when working in
teams, such as edit collaboratively and version control. That is why tools such
as [`Yjs`](https://blog.jupyter.org/how-we-made-jupyter-notebooks-collaborative-with-yjs-b8dff6a9d8af){: target="_blank"}
and [`nbdime`](https://nbdime.readthedocs.io/en/latest/){: target="_blank"} were developed to
solve those issues respectively.

### Developer Exchange

All that said, among developers, .json files are nothing but ordinary, and
exchanging them is nothing new. On the other hand, even if those files are
*easy to send*, one does require a whole setup (Python + Jupyter) to properly
visualize the content of such files. That is why the first and most simple way
to share and publish a notebook is through the built-in Export solutions.

## Using Built-Ins: Export Solutions

**[back to index](#index)**

Jupyter, in particular JupyterLab, introduces [several formats](https://jupyterlab.readthedocs.io/en/stable/user/export.html){: target="_blank"} for exporting the notebook. However, in this section one will be 
highlighted: **HTML**

### Advantages

- It can be sent in most commonly used media such as email, instant messaging
  apps like Whatsapp or Telegram, corporate team communication tools like MS
  Teams, Slack and Google Chat.
- It is self-contained, i.e. it is a single-file export.
- It shows the notebook in the most similar way possible to what is shown when
  using Jupyter Notebook/Lab.
- It does not require any additional tools to display, not even on mobile
  devices.
- It is compatible with Analytics solutions like Google Analytics. Should be
  added manually.
- It is copy/paste friendly for code.
- It correctly shows all formulae written in LaTeX.
- It is plain text and thus version control friendly.
- It displays all the outputs from the executed notebook, even plots, and
  images.
- It can be easily hosted on any web server without a special back-end.
- It does not require any additional tool or set up for the export, only two
  clicks with the default Jupyter Installation.
- It can display interactive visualization tools like Altair if the output is
  plain HTML/JS. Provided that the library supports it.
- There are no dependencies on third parties

### Disadvantages

- It is not editable. - Technically it is, but not in the same way a Jupyter
  notebook is.
- It cannot be executed, i.e. it is a static file.
- It has no support for a common revision mechanism (notes, comments,
  highlighting, etc.).

### When to use

This solution is the best one when the other person does not need or should run
the notebook. For example, when sending sample code to a fellow developer, for
documentation examples and also for simple web hosting.

Some examples of this approach can be found in the PyMC3 official
documentation, where [all their examples](https://docs.pymc.io/nb_examples/index.html){: target="_blank"}
are HTML exports of Jupyter Notebooks.

### Why not other export formats?

Some may argue that **PDF** is also a good choice, however, due to pagination,
generally, the content and the output is split in unpredictable ways and
thus making it harder for the reader to understand.

**Asciidoc**, **ReStructuredText**, **Markdown** and **LaTeX** require special
readers and assume that the other person also knows the format. Moreover, it is
not easy to display on mobile devices without any additional software.

Executable Scripts (**.py**) are plain text and hence they sacrifice all the
effort put in formatting and styling the markdown cells. And, if that was not
the case, why bothering having a Jupyter Notebook at all to begin?

Finally, **Reveal.js** is meant for presentations and it is a certainly useful
option for that matter, but it often shows a subset of the whole notebook and
it is meant for the author itself and not for third parties.

## Read-Only Solutions

**[back to index](#index)**

Even though the last section covered HTML, which is also read-only, this
section will focus on non-built-it approaches. Moreover, all of the solutions
presented require some configuration or additional steps, the results might be
worthwhile depending on the particular scenario.

## Github Publishing

**[back to index](#index)**

Github is the most widespread solution for hosted git version control
repositories, this is also the case for the whole [Project Jupyter](https://github.com/jupyter){: target="_blank"}
, whose repositories are hosted in this platform. With time, they 
[included a feature](https://docs.github.com/en/github/managing-files-in-a-repository/working-with-non-code-files/working-with-jupyter-notebook-files-on-github){: target="_blank"}
that shows the Jupyter Notebook as HTML without requiring the user to do such
conversion.

The view will be the same as the one with the HTML export, there are some
differences to keep in mind though.

### Advantages

- Most of the advantages of the HTML export (see disadvantages).
- Hosted online for free, can be shared with a link.
- It can be downloaded as .ipynb.
- Automatic support for MyBinder and Google Colab (See next sections).
- Support for version control out of the box as part of git.
- Works with public and private repositories and also in Github Enterprise.
- It is *discoverable* by Github Search Engine
- Generate Repository-level analytics.

### Disadvantages

- Requires time to load the view, it may fail for extensive notebooks.
- Requires a Github account and familiarity with git in general.
- Requires readers to be somewhat familiar with Github UI.
- Mobile design is not optimal
- Has no cache mechanism, HTML views are computed each time.
- Not compatible with Analytics solutions like Google Analytics.
- Not compatible with interactive visualization tools like Altair or Plotly.

### When to use

Ideal for people and teams already working with Github Repositories. If not
working with them, other options like Google Colab or NBViewer might be better.
Another possible scenario is when old versions of particular notebooks should
be re-visited, Github makes it easy and intuitive. Nonetheless, If cell
execution or interactive plots are necessary, this option is not suitable.

Most Github [Repositories with Jupyter Notebooks](https://github.com/search?l=Jupyter+Notebook&q=notebook&type=Repositories){: target="_blank"} can be used as examples (there were more than 66.000 at the time of this 
writing). One popular instance is the [Python implementation repository](https://github.com/ctgk/PRML/tree/master/notebooks){: target="_blank"}
of the algorithms of the [Pattern Recognition and Machine Learning by Christopher Bishop](https://github.com/ctgk/PRML/blob/master/notebooks/ch01_Introduction.ipynb){: target="_blank"}

## NBViewer Publishing

**[back to index](#index)**

[NBviewer](https://nbviewer.jupyter.org/){: target="_blank"} is a free, online tool from the
project Jupyter to display notebooks online. It combines two Python packages,
[NBconvert](https://nbconvert.readthedocs.io/en/latest/){: target="_blank"} for notebook
transformations and [Tornado](https://www.tornadoweb.org/en/stable/){: target="_blank"} as web
service.

In this platform, notebooks are presented in HTML, the same way as with Github
but, the User Interface is much more minimalistic and it is not tightly
integrated with any version control system.

### Advantages

- Most of the advantages of the HTML export.
- Hosted online for free, can be shared with a link.
- It can be downloaded as .ipynb.
- Automatic support for MyBinder (See next sections).
- It does not require any background knowledge (e.g. as opposed to Github
  publishing).
- It caches results, load times are fast after the first load.
- The UI has less branded content and is minimal, ideal for focus.
- Can load notebooks from anywhere on the web, just with the URL.
- It can be seamlessly integrated with Github (Repositories and Gists).

### Disadvantages

- Mobile design is better than Github
- Because of its cache, results may take some time to refresh when updated.
- Not compatible with Analytics solutions like Google Analytics.
- Not compatible with interactive visualization tools like Altair or Plotly.
- No discoverability capabilities such as Github's.

### When to use

This solution is similar to Github's, but it is a better fit for non-developer
users (e.g. mathematicians and statisticians may not have a background with
version control). Furthermore, it is commonly used for writing static books,
one of the most popular ones being [Probabilistic-Programming-and-Bayesian-Methods-for-Hackers](https://camdavidsonpilon.github.io/Probabilistic-Programming-and-Bayesian-Methods-for-Hackers/){: target="_blank"}. 
As well as other HTML-based approaches, If cell execution or interactive plots
are necessary, this option is not suitable.

## Static Site Generator Integration

**[back to index](#index)**

Nowadays, there is an increasing trend in popularity for Jamstack tools, i.e.
Static Site Generators. That is why there are plenty of options available in
the Python ecosystem ([50 at the time of this writting](https://jamstack.org/generators/)){: target="_blank"}. 
That been said the most popular ones are [Pelican](https://blog.getpelican.com/){: target="_blank"},
[Lektor](https://www.getlektor.com/){: target="_blank"} and [Nikola](https://getnikola.com/){: target="_blank"} based
on Github Stars.

From these three options, Nikola is the only one with 
[native support](https://getnikola.com/handbook.html#supported-input-formats){: target="_blank"} 
for .ipynb files, whereas [Pelican](https://github.com/danielfrg/pelican-jupyter){: target="_blank"}
and [Lektor](https://github.com/baldwint/lektor-jupyter){: target="_blank"} require plugins, once
installed their use should be straightforward.

Independently of the particular generator, the advantages and disadvantages are
identical.

**Note:** This approach is **not** embedding Jupyter Notebooks in a static
site, but rather using the .ipynb file itself as the source. Embedding
notebooks is covered as one of the Executable solutions.

### Advantages

- It provides the greatest level of customization and control by designing its
  templates
- It is compatible with Analytics solutions like Google Analytics. Should be
  added manually.
- It is compatible with interactive, HTML-based visualization tools like
  Altair. Most likely require some additional configuration.
- There are no dependencies on third parties
- The notebook is attached to the personal brand of the site and not "hosted in
  the platform everyone uses".
- Better discoverability through search engines when optimizing SEO.
- Readers do not see a Jupyter Notebook but a web page, without the structure
  of the cells, this produces a more article-like look and feel.

### Disadvantages

- It requires a lot of setups manually. Static Gen, Templates, Plugins, etc.
- Usually, the deployment requires either a manual process or configuring a
  Continuous Integration / Deployment Pipeline, which can be done for free but
  configuring it is time-consuming.
- It creates *a whole site*, which might be excessive for simple use cases.

### When to use

This approach is more suitable for individuals and or organizations who want to
keep and maintain a website/blog and at the same time showcase jupyter
notebooks. It requires intermediate knowledge of software engineering and is
maybe not the most adequate solution for those coming from other fields. 

Furthermore, it assumes a continuous stream of new content rather than simple
seldom updated publications. All the discoverability capabilities of other
solutions are not included here, thus requiring additional work.

That being said, this is the only solution where the writer has full control
over the implementation, the look and feel, and the UI in general, allowing to
use Analytics solutions as well as some interactivity.

### Why not Sphinx, MkDocs, Cactus, or X?

The idea behind publishing a Jupyter Notebook is different from software
documentation, which is the main focus for Sphinx and MkDocs. Cactus is another
popular alternative but its last commit was in 2017, making it obsolete. Other
static site generators are less known and at the time of this writing do not
present any meaningful integration with Jupyter Notebooks.

A clarification should be made about Sphinx since it is used as the back-end
for another solution called Jupyter-book which will be cover below.

## Jupyter-Book - Static

**[back to index](#index)**

[Jupyter-Book](https://jupyterbook.org/intro.html){: target="_blank"} is a solution that can be
used in Static, Executable, and printable scenarios, however, the advantages
and disadvantages of each are slightly different and the level of maturity is
not the same either. Therefore, in this article, it will be repeated for each
category.

This tool has been [migrated to the Python ecosystem](https://youtu.be/2Z7wDaYt53Y){: target="_blank"} 
(it used Ruby and Jekyll in the past), and although it is not extremely popular
at the moment, the project is gaining traction, and seems it would be the new
standard in the short-term

As an additional resource for this article, a [template repository](https://github.com/ELC/jupyter-book-template-cookiecutter){: target="_blank"} to get started with Jupyter-Book was 
prepared, it works for static, executable, and also printable scenarios and can 
help getting started.

### Advantages

- It creates a self-contained output, giving consistency across the content
- It creates tables of contents automatically
- It is compatible with Analytics solutions like Google Analytics. Should be
  added manually.
- Many configuration options
- Support for bibliography
- Extended markup features via MyST
- Integration with Google Colab, MyBinder, and Thebe (see below sections)
- It is not necessary to execute the notebooks beforehand

### Disadvantages

- It creates a self-contained output, making it difficult to integrate with
  existing websites
- It is not possible to customize the theme out of the box.
- Usually, the deployment requires either a manual process or configuring a
  Continuous Integration / Deployment Pipeline, which can be done for free but
  configuring it is time-consuming.
- If using one of the advanced features of MyST, the notebook might be
  incorrectly display using any other solution shown here

### When to use

Despite having a "book" in the name, the actual layout is similar to modern
software documentation. The reason being the main theme is inspired by the
[pandas docs](https://pandas.pydata.org/pandas-docs/stable/user_guide/10min.html){: target="_blank"}. 
If the content consists of several Jupyter Books that can be ordered into
sections, chapters, or a similar hierarchical structure, Jupyter-Book is
extremely useful

As an example, the data visualization library Altair used this tool to build
their [official tutorial](https://altair-viz.github.io/altair-tutorial/){: target="_blank"}.

## Executable Solutions

**[back to index](#index)**

In the previous sections, all solutions aimed at providing a static
representation of the notebook. That was the most convenient way to share a
notebook. Nevertheless, in some use cases, the content is required to be
executable. For example, for reproducibility results in a research review; or
to showcase to students what happens when the code changes in a pedagogical
setting.

The fact that the notebook is executed means that the kernel should run on a
server and the input should be sent and the output should be fetched. There are
free servers that allow to do that but certainly with limitations or
additional steps for configuration.

In this category, two backends will be shown: Google Colab and MyBinder. And
four different ways are presented on how to use them, two direct and two
indirect.

**Important Note:** The execution of the code will be always on a sandbox
environment, meaning that there are no risks of running insecure code, neither
for the writer or the reader.

## Embedded Solution

**[back to index](#index)**

Embedding a notebook means *inserting* some input/output cells into an existing
web page (generally but not necessarily static). The aforementioned interaction
with the back-end is taken care of by
[NBInteract](https://www.nbinteract.com/){: target="_blank"}, a python package that was developed
for this very purpose. In this blog, there is a [brief tutorial](https://elc.github.io/posts/embed-interactive-notebooks/){: target="_blank"} 
explaining how to do this step by step

### Advantages

- It is fully compatible with Jupyter Widgets (ipywidgets).
- There is full control about dependencies and environment.
- The user sees the execution inside the same page, no redirections are needed.
- It is fully integrated with MyBinder (see the section below).
- Several independent notebooks can be embedded in a single static page.
- It is compatible with Analytics solutions like Google Analytics. Should be
  added manually.

### Disadvantages

- Requires a Github account and basic use of git.
- The configuration should be done on a notebook by notebook basis.
- The user has to click a button and only then the process is triggered,
  leading to potential delays.
- The reader cannot modify the code, interactivity is limited to widgets
- The server that runs the code will be shut down after some minutes of
  inactivity.
- The user experience might be a little uncomfortable because one has to wait
  until the kernel is ready

### When to use

This approach resembles the "Flash Application" or the "Java Applet" where a
small piece of an external tool is embedded into a static website. In this case,
that external tool is a Jupyter notebook.

One of the [articles of this blog](https://elc.github.io/posts/ordinary-differential-equations-with-python/){: target="_blank"} 
uses this approach extensively to showcase Ordinary Differential Equations with
the aid of different ipywidgets.

Although requiring some setup, it is one of the less disruptive approaches for
writers and readers alike.

## Google Colaboratory

**[back to index](#index)**

[Google Colaboratory](https://colab.research.google.com/notebooks/welcome.ipynb){: target="_blank"} 
or simply Colab is a service provided for free by Google that comes with these
main features:

- All commonly used data science libraries are pre-installed.
- It integrates seamlessly with Google Drive.
- It has support for GPU out of the box.

One of the interesting features is that any public Github repo can be opened
directly from Colab by changing the URL.

### Advantages

- Seemless import from Github.
- It does not require Github at all. Any user with a Google Gmail account can
  use it.
- Easy to share with a link.
- Easy to manage permissions, the same mechanism as Google Drive.
- It offers GPU support out of the box.
- New dependencies can be installed if needed, yet not automatically.
- Can read and write from Google Drive.
- URL replacement integration with Github.
- There are no set up times.

### Disadvantages

- The interface is custom from Google, it is different than the traditional
  Jupyter Lab.
- The user has to navigate to a different website to execute the notebook.
- If one closes the browser tab, the session is lost.
- The notebook kernel is shut down after some time of inactivity.
- The only possible storage is Google Drive, hence inheriting size limitations
  of the associated account (15GB at the time of this writing).

### When to use

The fact that Colab offers GPU support is a game-changer, no other service does
it for free. Some teams may choose this solution solely because of this,
especially in deep learning applications.

## My Binder

**[back to index](#index)**

[MyBinder](https://mybinder.org/){: target="_blank"} or simply Binder is a free online service
that creates sandbox environments to run Jupyter. It has support for both
Jupyter Notebook and Jupyter Lab. However, it offers CPU-only processing
capabilities.

### Advantages

- It is used as a base for many other services.
- New dependencies can be installed if needed automatically.
- No apparent limit for data while the session is alive.

### Disadvantages

- It takes some time to build and run.
- The user has to navigate to a different website to execute the notebook.
- Configuring it for the first time might require some knowledge of Linux,
  Docker or Conda environments.
- The notebook kernel is shut down after some time of inactivity.
- There are no storage capabilities, the results should be manually downloaded.

### When to use

MyBinder is a backbone service and for a notebook writer, it may not be that
useful since other services like Jupyter-book or the Embedded approach use it
under the hood. However, it is helpful to know some of the details of the
internals to see what is possible.

The typical use case for bare Binder is to have a repo with a particularly
complicated setup of dependencies that cannot be used otherwise. For example,
using software requiring particular C libraries or certain operating
system libraries pre-installed (e.g. FFMPEG, Libpostal, etc.).

A more concrete example is creating animations with matplotlib which requires
FFMPEG for some output formats, being FFMPEG not a Python library but a
software that should be installed on the Operating System level. The article on
[Times Tables](https://elc.github.io/posts/times-tables/){: target="_blank"} covers this precise
problem



## Jupyter-Book - Executable

**[back to index](#index)**

As mentioned in the static section Jupyter-Book can be used for static and
executable content. In the case of executable content, it provides support for
three different services:

- Google Colab
- MyBinder
- Thebe

Since Colab and Binder were already discussed, this section will focus on
[Thebe](https://thebe.readthedocs.io/en/latest/){: target="_blank"}.

Thebe is a service that acts as the embedded approach described above with
the difference is that it is integrated with Jupyter-book since both projects are
under the bigger [Executable Books Project](https://executablebooks.org/en/latest/){: target="_blank"},
but it is not limited to Jupyter-Book. Thebe uses MyBinder as a back-end and
provides an execution environment for static sites. 

### Advantages

- All of the advantages of using MyBinder
- The user sees the execution inside the same page, no redirections are needed.
- Seamless integration with Jupyter-book, no additional configuration needed.
- Full support for custom dependencies through MyBinder

### Disadvantages

- The user experience might be a little uncomfortable because one has to wait
  until the kernel is ready
- Configuring without using Jupyter-book might require HTML/JS knowledge

### When to use

Thebe is a young project (223 Github start at the moment of this writing) and
there is not a big collection of examples nor is it a well-known tool. However,
when used integrated with Jupyter-Book, it gives the reader the ability to
"suddenly being able to run the code examples" which is a great user
experience.

At the moment, it is the ideal solution if already using Jupyter-Book, for a
similar approach using a more standalone tool, the embedded approach should be
preferred.

As an additional resource for this article, a [template repository](https://github.com/ELC/jupyter-book-template-cookiecutter){: target="_blank"} to get started with Jupyter-Book was 
prepared, it works for static, executable, and also printable scenarios and can 
help getting started.

## Printable Solutions

**[back to index](#index)**

In some cases like academic publishing, book writing, or learning material the
preferred format is print paper. In this case, there are a variety of options
but the choice is not dependent on the technological feasibility but rather on
the target platform.

If writing a book, a publisher will likely require a specific format, if going
self-publish, usually, only a PDF will be enough.

In case of requiring AsciiDoc, Markdown, or ReStructuredText, Jupyter has
built-in options for exporting to these formats, then the particular publisher
instructions should be followed. Since this may vary significantly in each case,
this section will focus on the most used format of academia, LaTeX. LaTeX is a
special format that can be easily converted to PDF, therefore the term PDF in
this section will always refer to the LaTeX conversion to this format.

Regardless of the approach taken, it is important to note that LaTeX can be
used for two purposes: articles and books. Typically articles are generated from
a single notebook file (not exclusively though) and books are a collection of
notebooks following a hierarchical structure.

For books, specific book templates should be used to give the proper format,
including page numbers, headings, and such. That is why tools like
[Overleaf](https://www.overleaf.com/){: target="_blank"} are recommended to structure the
document.

## Built-in Export: LaTeX

**[back to index](#index)**

The native LaTeX export will convert the notebook to the LaTeX format. This is
ideal for single file conversions and should be the preferred way to start
articles based on Jupyter Notebooks.

### Advantages

- The same notebooks can be used for static/executable printing, no
  printing-exclusive modifications are needed
- It is a native, straightforward solution.
- All images and figures are handled automatically.

### Disadvantages

- If using more than one notebook, each should be exported manually (can be
  automated with `nbconvert` though).
- Usually, the code should be removed manually.
- It requires final editing on an external platform.

### When to use

The built-in LaTeX export is suitable when dealing with single notebooks that
are not connected. It might be helpful to start an academic
article but in such media often the code should be removed. 

If the target is not an academic conference/journal or a publisher, other tools
like the static site generator or the other plain text, export might be more
suitable dependent on the particular use case.

## Jupyter-Book - For Printing

**[back to index](#index)**

If already using Jupyter-Book, one possibility is to use the LaTeX target and
create a .tex with all the notebooks converted to LaTeX. This approach will
produce a consistent and book-like structured document. Some final formatting
might still be needed in third-party tools but it is much less work than the
default LaTeX export.

### Advantages

- The same notebooks can be used for static/executable printing, no
  printing-exclusive modifications are needed
- It combines multiple notebooks following a predefined structure.
- It can export multiple notebooks at the same time.
- It creates a numbered table of contents.
- It handles global bibliography.
- It supports basic PDF export.
- Can be integrated to generate a PDF on each commit.

### Disadvantages

- The support is still experimental and might change.
- It requires configuring a CI/CD Pipeline.
- It requires final editing on an external platform.

### When to use

At the moment LaTeX and PDF are not the main focus of Jupyter-Book and the
design might appear basic, however, it is indeed a good starting point for
books. Using the tool for single notebooks might be excessive.

As an additional resource for this article, a [template repository](https://github.com/ELC/jupyter-book-template-cookiecutter){: target="_blank"} 
to get started with Jupyter-Book was prepared, it works for static, executable,
and also printable scenarios and can help getting started.

As an example, the official Jupyter-Book project generates a 
[PDF version of their docs](https://github.com/executablebooks/jupyter-book/suites/3444456225/artifacts/81694222){: target="_blank"} 
in the form of a book, using the LaTeX export option in the middle

## Choose the best tool

**[back to index](#index)**

To choose the best tool, look for the use case that best represents
your needs and see the available options

### I need GPU Support

The only option is **Colab**.

### I want to keep my readers on my site

Then use either the **Embedded** or **Thebe**.

### I need Analytics

Use **Jupyter-Book** or **Embedded** approaches.

### I need Cache for fast load time

Use **NBviewer**.

### I want to create a portfolio using Jupyter Notebooks

Use a static site generator. This site was built using Pelican.

### I have a very specific setup of dependencies

Use any of the **MyBinder-based** approaches:

- MyBinder
- Embedded
- Jupyter-Book

## Conclusion

**[back to index](#index)**

There are many different tools to publish Jupyter notebooks and whole tutorials
could be written about the features and possibilities of each. In this article,
the most compelling ones were summarized to help the notebook writer to decide
which tool is the most suitable for their use case.

If any of the information presented is outdated, or you have suggestions for
new advantages or disadvantages of a particular solution please leave a
comment below.

Below is a list of useful resources to continue learning and searching for
inspiration.

## Additional Resources

**[back to index](#index)**

Awesome Lists:

- [Official Jupyter Gallery](https://github.com/jupyter/jupyter/wiki/a-gallery-of-interesting-jupyter-notebooks){: target="_blank"}
- [Markusschanta (2.3k stars)](https://github.com/markusschanta/awesome-jupyter){: target="_blank"}
- [Mauhai (1.9k stars)](https://github.com/mauhai/awesome-jupyterlab){: target="_blank"}

[Gallery of Jupyter-Books](https://executablebooks.org/en/latest/gallery.html){: target="_blank"}

Some Books built with Jupyter Notebooks:

- [Probabilistic Programming & Bayesian Methods for Hackers](http://camdavidsonpilon.github.io/Probabilistic-Programming-and-Bayesian-Methods-for-Hackers/){: target="_blank"}
- [Introduction to Statistics with Python](https://github.com/thomas-haslwanter/statsintro_python){: target="_blank"}
- [Python Data Science Handbook](https://github.com/jakevdp/PythonDataScienceHandbook){: target="_blank"}
