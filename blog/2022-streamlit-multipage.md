Title: Multipage, State-Persistent Apps with Streamlit
Date: 2022-01-14
Category: Programming 
Tags: Streamlit, Python, Github
Slug: streamlit-multipage
Authors: Ezequiel Leonardo Castaño 
Lang: en 
Headerimage: https://elc.github.io/blog/images/streamlit-mutipage/streamlit-mutipage_headerimage.png

[![Jupyter Publishing Header Image]({static}images/streamlit-mutipage/streamlit-mutipage_headerimage-thumbnail.png){: .b-lazy width=1444 data-src=/blog/images/streamlit-mutipage/streamlit-mutipage_headerimage.png }](/blog/images/streamlit-mutipage/streamlit-mutipage_headerimage.png)

<!-- PELICAN_BEGIN_SUMMARY -->

Converting a Python script to a web app has never been easier thanks to
libraries such as Streamlit. This library allows to create simple and
responsive web apps with minimal effort but there is one potential limitation:
No multipage support. In this post, a *potential* solution to this problem is
presented with examples and demos. 

<!-- PELICAN_END_SUMMARY -->

This post is one part of a three posts series regarding Streamlit, the posts
can be read in any order and the three are built around the same demo app:

- **Multipage, State-Persistent Apps with Streamlit** (this post)
- [Add Google Analytics (or any custom HTML) to Streamlit with Github Pages]({filename}./2022-streamlit-google-analytics.md)
- [Lessons learnt After Developing Finance Web Tools with Streamlit and Altair (No HTML/CSS/JS)]({filename}./2022-personal-finance-tools.md)


## TL;DR

There is a pip installable plugin called `streamlit-multipage`, this post is an
extension of the README of the [Github Repository](https://github.com/ELC/streamlit-multipage){: target="_blank"}.

Try it yourself by doing

```
pip install streamlit-multipage
```

An [example Github Repo](https://github.com/ELC/finance-tools){: target="_blank"} 
is available for inspiration, there is also a 
[demo app](https://elc.github.io/finance-tools/){: target="_blank"}
attached to check the final result.

For an alternative, more in-depth library, check
[Hydralit](https://github.com/TangleSpace/hydralit){: target="_blank"}

## Why Multipage Apps?

Streamlit is an awesome tool for converting Python scripts into Webapps but,
sometimes one wants to have many tiny scripts combined in a user-friendly way
and, even though it is possible to develop one streamlit app for each, the
process is tedious and the whole project loses maintainability.

Multipage apps are apps that can host different apps in parallel with some
additional features like state persistence or customizable UI.

## Streamlit-multipage

There are several solutions to these problems and to the best of the author's
knowledge, these are the most popular ones:

- [Hydralit](https://github.com/TangleSpace/hydralit){: target="_blank"}
- [streamlit-multiapps](https://github.com/upraneelnihar/streamlit-multiapps){: target="_blank"}
- [streamlit-pages](https://github.com/bvenkatesh-ai/streamlit_pages){: target="_blank"}

However, for one reason or another, none of them fulfill the purpose of a
"simple multipage experience". 

`Hydralit` is a bit overkill because it is a big
project deeply integrated with streamlit and one has to use `import hydralit as
hy` instead of `import streamlit as st` which breaks the typical idioms built
around streamlit.

`Streamlit-Multiapps` is not pip installable and has `NumPy` and `pandas` as
dependencies, which, even if used in most cases, are not required always and
are considered among the heaviest dependencies in the Python ecosystem.

`Streamlit-pages` is a 55 LoC script, which is too basic and provides no state
persistence options.

There is a fourth option called [`streamlit-multipage`](https://github.com/ELC/streamlit-multipage){: target="_blank"} 
which is pip installable and it has state persistence while keeping streamlit
idioms. It is not as feature-rich as Hydralit but has a much more friendly
learning curve.

In this post, the `streamlit-multipage` will be used and covered in depth.

To start working with this library one can simply install it via pip:

```
pip install streamlit-multipage
```

**DISCLAIMER**: The original development of `streamlit-multipage` was done by
Yan Almeida, however, this blog's author contributed significantly to the
library. Most of this post content will be extracted from the repository README
with extended explanations.

## Features

Streamlit-multipage has several appealing features that may be useful for most
users.

## Simplicity

Using `streamlit-multipage` is as simple as writing a native streamlit like
this:

```python
import streamlit as st

st.title("My Amazing App")
name = st.text_input("Your Name: ")
st.write(f"Hello {name}!")
```

And refactoring in a function like this

```python
import streamlit as st
from streamlit_multipage import MultiPage


def my_page(st, **state):
    st.title("My Amazing App")
    name = st.text_input("Your Name: ")
    st.write(f"Hello {name}!")


app = MultiPage()
app.st = st

app.add_app("Hello World", my_page)

app.run()
```

The function has to take one positional argument, ideally called `st`, that is
the streamlit object. The function also needs to take arbitrary keyword
argument `**state`, this is where the state of the app will be injected.

As seen in the example, it is not necessary to use the `state` variable at all
in the function.

In the last part of the snippet, we see the `streamlit-multipage` specific part
which consists of instantiating a `MultiPage` object, passing the streamlit
object and then adding the app (or page) with the `add_app` function.

This is ideal for short scripts but typically streamlit apps have many dozens
if not hundreds of lines of code, for that the function could be moved to a
different folder

Since the `st` object used will be passed as a parameter, it is not needed to
import streamlit anywhere else in the project besides where the `MultiPage`
object was instantiated.

Working in the functions *feels like native streamlit* because it is,
the `st` parameter is not a mocked object nor is it monkey patched, providing
the native streamlit experience.


## State Persistence

Another important feature is inter-page persistence, this is a type of
persistence that allows saving variables from one page to the other but it
also allows saving the state after restarting the app.

Here is an example of this feature:

```python
import streamlit as st
from streamlit_multipage import MultiPage


def input_page(st, **state):
    st.title("Body Mass Index")

    weight_ = state["weight"] if "weight" in state else 0.0
    weight = st.number_input("Your weight (Kg): ", value=weight_)

    height_ = state["height"] if "height" in state else 0.0
    height = st.number_input("Your height (m): ", value=height_)

    if height and weight:
        MultiPage.save({"weight": weight, "height": height})


def compute_page(st, **state):
    st.title("Body Mass Index")

    if "weight" not in state or "height" not in state:
        st.warning("Enter your data before computing. Go to the Input Page")
        return

    weight = state["weight"]
    height = state["height"]

    st.metric("BMI", round(weight / height ** 2, 2))


app = MultiPage()
app.st = st

app.add_app("Input Page", input_page)
app.add_app("BMI Result", compute_page)

app.run()
```

Here the app "Input Page" can pass variables to the "BMI Result" page by
calling the `MultiPage.save` method. By default, all the variables are saved in
a global namespace but different namespaces can be used as well (see next
example).

To access the state on a page one has to use the `state` variable, which is a
Python dictionary, simply checking if the necessary keys are present should be
enough. It is recommended to add warning messages if there are missing keys.

If default values are desired for when the variables are not present the `get`
method can be used as well.

```python
def my_app(st, **state):
    my_variable = state.get("Year", 2022)
```

Internally the state is persisted in a pickle file which uses
[`joblib`](https://joblib.readthedocs.io/en/latest/){: target="_blank"} 
if available, if it is not installed it gracefully fallsback to the native
[pickle module](https://docs.python.org/3/library/pickle.html){:target="_blank"}.


**WARNING**: This feature has been tested locally but not with the Streamlit
Sharing Service (Deploy App Option).

### Namespaces

The `MultiPage.save` method can take a second keyword argument `namespaces`
which receives a list of all the namespaces the variables should be saved into.
That is, a page can save a variable in multiple namespaces.

There is no efficiency or comprehension consideration in the implementation so
beware of storing heavy objects in multiple namespaces at once (especially
important for large NumPy arrays or tensors).

When using namespaces it is a good practice to add a `namespace` variable at
the very top of the function for easy reference.

The example below illustrates this feature

```python
import streamlit as st
from streamlit_multipage import MultiPage


def input_page(st, **state):
    namespace = "input"
    variables = state[namespace] if namespace in state else {}
    st.title("Tax Deduction")

    salary_ = variables["salary"] if "salary" in variables else 0.0
    salary = st.number_input("Your salary (USD): ", value=salary_)

    tax_percent_ = variables["tax_percent"] if "tax_percent" in variables else 0.0
    tax_percent = st.number_input("Taxes (%): ", value=tax_percent_)

    total = salary * (1 - tax_percent)

    if tax_percent and salary:
        MultiPage.save({"salary": salary, "tax_percent": tax_percent}, namespaces=[namespace])

    if total:
        MultiPage.save({"total": total}, namespaces=[namespace, "result"])


def compute_page(st, **state):
    namespace = "result"
    variables = state[namespace] if namespace in state else {}
    st.title("Your Salary After Taxes")

    if "total" not in variables:
        st.warning("Enter your data before computing. Go to the Input Page")
        return

    total = variables["total"]

    st.metric("Total", round(total, 2))


app = MultiPage()
app.st = st

app.add_app("Input Page", input_page)
app.add_app("Net Salary", compute_page)

app.run()
```

When using custom namespaces, it is important to access `state[namespace]`,
instead of the `state` alone, because `state` will contain all namespaces,
including the global one.

**WARNING**: no variable in the global namespace should be named identically as
another namespace.


### Automatic Namespaces

It is also possible to avoid that altogether and use Automatic Namespaces,
`streamlit-multipage` will filter the `state` variable before passing it to a
function if it detects that there is a namespace with the same name of the app.
That is if the namespace is the same as the name used in the `add_app` method.

**Note:** The namespace should be explicitly specified in the `MultiPage.save`
method.

This is an example of automatic namespaces

```python
import streamlit as st
from streamlit_multipage import MultiPage


def input_page(st, **state):
    st.title("Tax Deduction")

    salary_ = state["salary"] if "salary" in state else 0.0
    salary = st.number_input("Your salary (USD): ", value=salary_)

    tax_percent_ = state["tax_percent"] if "tax_percent" in state else 0.0
    tax_percent = st.number_input("Taxes (%): ", value=tax_percent_)

    total = salary * (1 - tax_percent)

    if tax_percent and salary:
        MultiPage.save({"salary": salary, "tax_percent": tax_percent}, namespaces=["Input Page"])

    if total:
        MultiPage.save({"total": total}, namespaces=["Net Salary"])


def compute_page(st, **state):
    st.title("Your Salary After Taxes")

    if "total" not in state:
        st.warning("Enter your data before computing. Go to the Input Page")
        return

    total = state["total"]

    st.metric("Total", round(total, 2))


app = MultiPage()
app.st = st

app.add_app("Input Page", input_page)
app.add_app("Net Salary", compute_page)

app.run()
```

## Extensibility

When using `streamlit-multipage` projects can grow easily within a directory
structure.

Consider the following directory structure

```
.
└── root/
    ├── pages/
    │   ├── __init__.py
    │   ├── input_data.py
    │   └── result.py
    └── main.py/
```

Here the `main.py` is the entry point, it imports both `streamlit` and
`streamlit-multipage`, it instantiates the `MultiPage` object and loads the
pages and adds them to the object.

Each app or page can be separated into its file and common code could be
abstracted as well.

The `__init__.py` facilitates the import hierarchy by giving a single entry
point to the `pages` module.

These could be the content of the files:

**`input_data.py`**

```python
from streamlit_multipage import MultiPage


def input_page(st, **state):
    st.title("Tax Deduction")

    salary_ = state["salary"] if "salary" in state else 0.0
    salary = st.number_input("Your salary (USD): ", value=salary_)

    tax_percent_ = state["tax_percent"] if "tax_percent" in state else 0.0
    tax_percent = st.number_input("Taxes (%): ", value=tax_percent_)

    total = salary * (1 - tax_percent)

    if tax_percent and salary:
        MultiPage.save({"salary": salary, "tax_percent": tax_percent}, namespaces=["Input Page"])

    if total:
        MultiPage.save({"total": total}, namespaces=["Net Salary"])
```

**`results.py`**

```python
def compute_page(st, **state):
    st.title("Your Salary After Taxes")

    if "total" not in state:
        st.warning("Enter your data before computing. Go to the Input Page")
        return

    total = state["total"]

    st.metric("Total", round(total, 2))
```

**`__init__.py`**

```python
from .input_data import input_page
from .result import compute_page

pages = {
    "Input Page": input_page,
    "Net Salary": compute_page,
}
```

**`main.py`**

```python
from pages import pages

import streamlit as st
from streamlit_multipage import MultiPage

app = MultiPage()
app.st = st

for app_name, app_function in pages.items():
    app.add_app(app_name, app_function)

app.run()
```

Structuring the application this way makes all the files much shorter and with
a single responsibility. This could have been done with just `streamlit` but
with minor modifications 

## Customization

It is also possible to add customizations to each app to enhance the user
experience such as adding a header, a footer, additional sidebar elements,
hiding the hamburger menu and customizing the default text (e.g. for
localization)

This code shows how these customizations can be used:

```python
import streamlit as st
from streamlit_multipage import MultiPage, save


def input_page(st, **state):
    """See Example on Multipage"""


def compute_page(st, **state):
    """See Example on Multipage"""


def footer(st):
    st.write("Developed by [ELC](https://elc.github.io)")


def header(st):
    st.write("This app is free to use")


def sidebar(st):
    st.button("Donate (Dummy)")


app = MultiPage()
app.st = st

app.start_button = "Go to the main page"
app.navbar_name = "Other Pages:"
app.next_page_button = "Next Chapter"
app.previous_page_button = "Previous Chapter"
app.reset_button = "Delete Cache"
app.navbar_style = "SelectBox"

app.header = header
app.footer = footer
app.navbar_extra = sidebar

app.hide_menu = True
app.hide_navigation = True

app.add_app("Input Page", input_page)
app.add_app("BMI Result", compute_page)

app.run()
```

## Non-Functional Features

In addition to the previous functional features, there are some non-functional
ones that could be interesting for some.

### Single-File Project

`Streamlit-multipage` is a single file project, meaning that instead of pip
install it and add a dependency to track, the whole project can be simply add
as a library in any other project standalone and it should work out of the box.

## Quality of Code

The code has been formatted with [Black](https://github.com/psf/black){: target="_blank"} 
and Type Hints were added whenever possible to improve integration with
editors and IDEs.


## Limitations

The library itself has its limitations, namely:

- The state is saved in a dictionary and then in a pickled file, there is no
  usage of `st.session_state` which would imply a better user experience, this
  has been tried but due to `streamlit` lacking two-way binding in the
  `session_state`, this is not possible at the moment.
- There are no tests, according to [this discussion](https://discuss.streamlit.io/t/how-can-you-py-test-your-code/400){: target="_blank"},
  it is not straightforward to test streamlit apps nor libraries built around
  it, mainly because this involves testing not only Python but also Front-End
  code. This has not been done so far, contributions are much welcome though.
- Integration with Streamlit Sharing has not been tested thoroughly, the basic
  multi-page app works but no state management has been tested on the managed
  service. All the features shown in this post have been manually tested on a
  locally running streamlit app.

## Conclusion

Streamlit is one of the most popular tools for dashboarding and easily
converting Python Scripts into Web Apps. `Streamlit-Multipage` is a lightweight
app that can be pip installable (or drop in a standalone script) that allows
for seamless integration of multi-page apps while keeping state and idioms.

The `streamlit-multipage` has no tests and has not been thoroughly tested on
the Streamlit Sharing but for self-hosted apps should be working without
issues.

An [example Github Repo](https://github.com/ELC/finance-tools){: target="_blank"} 
is available for inspiration, there is also a 
[demo app](https://elc.github.io/finance-tools/){: target="_blank"}
attached to check the final result using the `streamlit-multipage`.

## Check the Series

If you liked this post, it is highly likely that you will also like the other
in this 3 part Streamlit Series:

- **Multipage, State-Persistent Apps with Streamlit** (this post)
- [Add Google Analytics (or any custom HTML) to Streamlit with Github Pages]({filename}./2022-streamlit-google-analytics.md)
- [Lessons learnt After Developing Finance Web Tools with Streamlit and Altair (No HTML/CSS/JS)]({filename}./2022-personal-finance-tools.md)
