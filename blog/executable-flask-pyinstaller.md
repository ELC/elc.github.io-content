Title: Create one executable file for a Flask app with PyInstaller
Date: 2018-02-24
Category: Programming
Tags: Python, Flask, PyInstaller
Slug: executable-flask-pyinstaller
Authors: Ezequiel Castaño
Lang: en
level: Begginer

After trying lots of solutions from stack overflow, quora and several blogs without success I decided to post how I managed to make one single file executable with Flask and PyInstaller

<!-- PELICAN_END_SUMMARY -->

If you just want to read the solution, scroll down to the [solution section](#solution)

## What's exactly the problem ?

Well, Flask is a WEB framework, used to create WEBsites that will be served by a WEB server and view from a WEB browser. Problems emerge when we try to replace 'WEB' with desktop in the previous sentence, we are trying to force something built for a particular scenario with its limitations to work in a complely different one.

## Reasoning about it

So, why on Earth someone would want such a thing, I mean, web apps are cool, trendy and they are everywhere isn't it? Yes, it's true but it's also true that when you want to share something with someone you want to be as smooth as possible, imagine these 2 cases:

Case 1:

- Developer: Hey! I built some amazing piece of software!
- Friend: Really?! Send me a copy so I could check it out
- Developer: Sure! Just extract the file I sent to your email and execute the file inside

Case 2:

- Developer: Hey! I built some amazing piece of software!
- Friend: Really?! Send me a copy so I could check it out
- Developer: Perfect! But it won't work unless you do some things before, you have install Python 3, make sure the arquitechture is properly selected according to your operating system, then create a virtual environment so you don't make a mess with the libraries, then install with pip (look for a tutorial in youtube if you don't know how) all the libraries in the requirements.txt file, oh, sure, you have to clone (what's that?) the repository to have access to all the files, and finally run in the console/terminal `python app.py` if you get an error probably I you have some incompatibilities, send me a screenshot so I can send you the wheel to the library causing the problem... ... ...
- Friend: ... Maybe another time

So yes, it's a bit exagerated but for illustration purposes it's fine. Desktop frameworks in Python aren't its strength so people usually tend to use web frameworks and use the browser as the "window". That's not bad at all, there are lots of reasons why web frameworks are better than desktop alternatives (versioning, updates, better security, etc..). However, these pieces of software are not self-contained and in some (maybe a lot) cases it's almost necessary to have self-contained applications

Some of the main advantages of the self-contained (also known as portable) software are:

- It isn't necessary to keep a virtual environment with the specific versions of all the dependencies
- It isn't necessary to know which software is installed in the destination machine.
- It isn't necessary to install anything at all, just copy and paste or execute from removable drive.
- It is way more clear to the final user where is the program and how to execute it
- It is harder (yet not impossible) to reverse engineer the software

There are some disadvantages obviously such as:

- Since all dependencies are included, files could get BIG ( Hello World app in Flask is about 25MB)
- Version control is useless on self-contained files
- If you consume self-contained software you trust your provider about its safety

This are some points to consider, they could be advantages or disadvantages depending on the case

- You treat the software as a black box
- When a new version is released you just replace the file and you're done

## Flask comes into the action

If you attempt to port a web app to a desktop one without changing the framework chances are you will use a lightweigth framework like Flask. Now, how do you create a desktop app? Using a desktop framework (Qt, Tk, wx, etc), the most commonly used for this task is Qt. The idea is to create a minimal web browser capable of rendering HTML and then, execute the flask application server and browse to the url of the server inside this browser.

But what are the differences between creating a web browser and using the systems default? Well, first of all, you assume there will be one, and that that one would be able to render all the HTML, CSS and JS you are using, that could not be the case. More often than not we found ourselves developing software for old operating systems (aka Windows XP o older).

Sounds easy and actually it can be done, I was contributing to a script to achieve this very goal [PyFladesk](https://github.com/smoqadam/PyFladesk). There are some concerns about which version of Qt is the appropiate and the convenience of one over the other.

## The problem

Until now there is no problem, but when you try to bundle everything into one single file problems arise

What kind of problem could occur? Each item in the list is an example:

### Stack Overflow

- [Flask application built using pyinstaller not rendering index.html - jinja2.exceptions.TemplateNotFound](https://stackoverflow.com/questions/32149892/flask-application-built-using-pyinstaller-not-rendering-index-html)
- [Pyinstaller on Flask app, import error](https://stackoverflow.com/questions/47832309/pyinstaller-on-flask-app-import-error)
- [Using Pyinstaller on Python Flask Application to create Executable](https://stackoverflow.com/questions/47018930/using-pyinstaller-on-python-flask-application-to-create-executable)
- [Python 2.7.12, trying to build an executable file using pyinstaller. I keep getting the below error](https://stackoverflow.com/questions/40191441/python-2-7-12-trying-to-build-an-executable-file-using-pyinstaller-i-keep-gett)

### Quora

- [Can I convert a Flask application into an executable file that runs on Windows like an .exe file?](https://www.quora.com/Can-I-convert-a-Flask-application-into-an-executable-file-that-runs-on-Windows-like-an-exe-file)

### Reddit

- [Is it possible to deploy/distribute Flask as an executable for desktop use?](https://www.reddit.com/r/Python/comments/21evjn/is_it_possible_to_deploydistribute_flask_as_an/)

### Blogs

- [Flask and pyinstaller notice](http://mapopa.blogspot.com.ar/2013/10/flask-and-pyinstaller-notice.html)

## Solution

Note: If all you use is flask for served static or pseudo static content you could tried [Frozen Flask](http://pythonhosted.org/Frozen-Flask/).

After reading all the previous posts and some of the [PyInstaller docs](https://pythonhosted.org/PyInstaller/). I found that some people actually solved it! But, the solution they propose was editing the spec file, which is generated after a first run of PyInstaller. I thought that solution was a hack and not the proper way to achieve what I wanted.

So I tried to understand what the changes in the spec file did and it turned out that that changes was to copy the folders Flask uses into the file directory/file (Actually one of the proposed solutions was build and then copy paste the folders, but besides being unpractical it wouldn't work with one file builds). so I search in the docs for a command line argument to achieve the same, there is none, well, actually there is, but it isn't in the docs page.

So after researching a bit I came with following solution (Explanation below):

Windows:

    pyinstaller -w -F --add-data "templates;templates" --add-data "static;static" app.py

Linux (NOT TESTED):

    pyinstaller -w -F --add-data "templates:templates" --add-data "static:static" app.py

This will create a folder `dist` with our executable ready to be shipped. The executable will open the main window of our app.

When a first used this was for a contribution for the [PyFladesk](https://github.com/smoqadam/PyFladesk) project and I realize that since Qt is quite big, our executables were big too. The example app of that repository is 70 MB (much of which was the Qt Component for displaying HTML (WebEngine)). This is reasonable taking into account that we were shipping a self contain web browser.

## Tutorial

If you haven't already, install it with pip (if you use virtual environments you should install it inside it)

    pip install pyinstaller

Some parameters to consider:

- `F` - Bundles everything in a single file
- `w` - Avoid displaying a console
- `--add-data` - Add Folders to the directory/executable

Since Flask relies on a directory structure you should pass it to the folder, in the example case we only have two folders: `templates` and `static`, in case you use a database or some other directory structure you may adapt this.

Note: For more complex scenarios check the [PyInstaller Docs](https://pythonhosted.org/PyInstaller/usage.html)

## The other problem: The size

Is the project using as few dependencies as possible? If yes, continue reading, if not check and then come back. Make sure you create a virtual environment for your project and execute PyInstaller from there, if the size is still big, I recommend you to check one of these:

- Use Virtual Environments and install everything you need there, including PyInstaller (but nothing more!)
- Check if all your dependences are really necessary, try to use the standard library when possible
- Check if your biggest dependencies could be replaced with lightweight alternatives
- Use one-dir option and then see what are the biggest dlls and if you can exclude them
- Use the [ArchiveViewer.py script](http://pyinstaller.readthedocs.io/en/stable/advanced-topics.html#using-pyi-archive-viewer) that's part of PyInstaller and exclude everything you don't need

## Conclusion

Using PyInstaller and Flask is not as hard as people may experience if you have the correct knowledge but it requires a bit of work to get a clean, lightweight file. However, it's possible to create executable with complex apps, with special directory structure, databases and so on, but don't expect that to be a tiny file.
