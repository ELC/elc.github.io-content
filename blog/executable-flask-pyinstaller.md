Title: Create one executable file for a Flask app with PyInstaller
Date: 2018-02-24
Category: Programming
Tags: Python, Flask, PyInstaller
Slug: executable-flask-pyinstaller
Authors: Ezequiel Leonardo Castaño
Lang: en
headerimage: https://elc.github.io/blog/images/flask_pyinstaller/flask-pyinstaller_headerimage.png
level: Begginer

[![Flask_pyinstaller_logo]({attach}images/flask_pyinstaller/flask-pyinstaller_headerimage-thumbnail.png){: .b-lazy width=1401 data-src=/blog/images/flask_pyinstaller/flask-pyinstaller_headerimage.png }](/blog/images/flask_pyinstaller/flask-pyinstaller_headerimage.png){: .gallery }

**EDIT 2019.05.03:** The content order was change and the ideas were express more succinctly.

<!-- PELICAN_BEGIN_SUMMARY -->

Having a single executable file could be a great advantage in so many cases and nowadays more a more desktop applications are using web technologies (React Native, Cordova, Ionic, etc.). It was time for the Python stack to join the Group via PyFlaDesk, a simple script to combine Flask, Qt and PyInstaller to create desktop Apps.

<!-- PELICAN_END_SUMMARY -->

I wanted to create a single executable desktop application and since PyInstaller was there for a while I thought it would be pretty easy, it turns out that after after trying lots of solutions from Stack overflow, Quora and several blogs without success, I decided to post how I managed to solve the problem.

Note: A full list of the resources mentioned is [below](#additional-resources)

If you just want to read the solution, scroll down to the [solution section](#solution)

## The Problem

Well, Flask is a **WEB** framework (or Microframework as it desribes itself), used to create WEBsites that will be served by a WEB server and view from a WEB browser. Problems emerge when we try to replace 'WEB' with desktop in the previous sentence, we are trying to force something built for a particular scenario with its limitations to work in a completely different one.

## Motivation

Desktop applications aren't the most popular use for Python, those positions belongs to Web Development, DevOps and Data Science and, among the technologies used in the Web Development, Django and Flask are the most popular frameworks.

Using the tools one already knows for something completely different is a great advantage, in this case we want to create a desktop app with a single executable file from a web app built with Flask.

Some of the main advantages of the self-contained (also known as portable) software are:

- No virtual environment required.
- Knowing which software is installed in the destination machine isn't necessary.
- No installation required, just copy and paste or execute from removable drive.
- Easier to tell the final user where is the program and how to execute it.
- Harder (yet not impossible) to reverse engineer the software.

There are some obvious disadvantages such as:

- Since all dependencies are included, files could get BIG (Hello World app in Flask is about 25MB).
- No version control support for binaries.
- If you consume self-contained software you have to **trust** your provider about its safety.
- Working with external files, databases and other external sources has to be strongly tested.

This are some points to consider, they could be advantages or disadvantages depending on the case:

- You treat the software as a black box.
- When a new version is released you just replace the file and you're done.

## Flask comes into the action

If you attempt to port a web app to a desktop one without changing the framework chances are you will use a lightweight framework like Flask. Now, how do you create a desktop app? Using a desktop framework (Qt, Tk, wx, etc), the most commonly used framework for this task is Qt. The idea is to create a minimal web browser capable of rendering HTML and then, execute the flask application server and browse to the url of the server inside this browser.

But what are the differences between creating a web browser and using the systems default? Well, first of all, you assume there will be one, and that that one would be able to render all the HTML, CSS and JS you are using, that could not be the case. More often than not we found ourselves developing software for old operating systems (aka Windows XP o older).

Sounds easy and actually it can be done, I was contributing to a script to achieve this very goal [PyFladesk](https://elc.github.io/link/pyfladesk_repo){: target="_blank"}. There are some concerns about which version of Qt is the appropriate and the convenience of one over the other.

**Note:** If all you use is Flask for served static or pseudo static content you could tried [Frozen Flask](http://pythonhosted.org/Frozen-Flask/){: target="_blank"}.

## Solution

After reading all the previous posts and some of the [PyInstaller docs](https://pythonhosted.org/PyInstaller/){: target="_blank"}. I found that some people actually solved it! But, the solution they propose was editing the spec file, which is generated after a first run of PyInstaller. I thought that solution was a hack and not the proper way to achieve what I wanted.

So I tried to understand what the changes in the spec file did and it turned out that that changes was to copy the folders Flask uses into the file directory/file (Actually one of the proposed solutions was build and then copy paste the folders, but besides being unpractical it wouldn't work with one file builds). After a little reasearch, I came across the command line arguments to achieve the same.

Windows:

    pyinstaller -w -F --add-data "templates;templates" --add-data "static;static" app.py

Linux (NOT TESTED):

    pyinstaller -w -F --add-data "templates:templates" --add-data "static:static" app.py

This will create a folder `dist` with our executable ready to be shipped. The executable will open the main window of our app.

It first started as a contribution for the [PyFladesk](https://elc.github.io/link/pyfladesk_repo){: target="_blank"} project and then, I realize that since Qt is quite big, our executable were big too. The example app of that repository is 70 MB (much of which was the Qt Component for displaying HTML (WebEngine)). This is reasonable taking into account that we were shipping a self contain web browser.

There is no simple solution to the size problem but some suggestions are proposed in a [following section](#the-size-problem).

## Tutorial

If you haven't already, install it with pip (if you use virtual environments you should install it inside it)

    pip install pyinstaller

Some parameters to consider:

- `F` - Bundles everything in a single file
- `w` - Avoid displaying a console
- `--add-data` - Add Folders to the directory/executable

Since Flask relies on a directory structure you should pass it to the folder, in the example case we only have two folders: `templates` and `static`, in case you use a database or some other directory structure you may adapt this.

Note: For more complex scenarios check the [PyInstaller Docs](https://pythonhosted.org/PyInstaller/usage.html){: target="_blank"}

## The Size Problem

Is the project using as few dependencies as possible? If yes, continue reading, if not check and then come back. Make sure you create a virtual environment for your project and execute PyInstaller from there, if the size is still big, I recommend you to check one of these:

- Use Virtual Environments and install everything you need there, including PyInstaller (but nothing more!)
- Check if all your dependences are really necessary, try to use the standard library when possible
- Check if your biggest dependencies could be replaced with lightweight alternatives
- Use one-dir option and then see what are the biggest dlls and if you can exclude them
- Use the [ArchiveViewer.py script](http://pyinstaller.readthedocs.io/en/stable/advanced-topics.html#using-pyi-archive-viewer){: target="_blank"} that's part of PyInstaller and exclude everything you don't need

## Conclusion

Using PyInstaller and Flask is not as hard as people may experience if you have the correct knowledge but it requires a bit of work to get a clean, lightweight file. However, it's possible to create executable with complex apps, with special directory structure, databases and so on, but don't expect that to be a tiny file.

## Additional Resources

The following are the pages where this topic was mentioned and I couldn't find a proper answer:

- [Flask application built using pyinstaller not rendering index.html - jinja2.exceptions.TemplateNotFound](https://stackoverflow.com/questions/32149892/flask-application-built-using-pyinstaller-not-rendering-index-html){: target="_blank"} (Stack Overflow)
- [Pyinstaller on Flask app, import error](https://stackoverflow.com/questions/47832309/pyinstaller-on-flask-app-import-error){: target="_blank"} (Stack Overflow)
- [Using Pyinstaller on Python Flask Application to create Executable](https://stackoverflow.com/questions/47018930/using-pyinstaller-on-python-flask-application-to-create-executable){: target="_blank"} (Stack Overflow)
- [Python 2.7.12, trying to build an executable file using pyinstaller. I keep getting the below error](https://stackoverflow.com/questions/40191441/python-2-7-12-trying-to-build-an-executable-file-using-pyinstaller-i-keep-gett){: target="_blank"} (Stack Overflow)
- [Can I convert a Flask application into an executable file that runs on Windows like an .exe file?](https://www.quora.com/Can-I-convert-a-Flask-application-into-an-executable-file-that-runs-on-Windows-like-an-exe-file){: target="_blank"} (Quora)
- [Is it possible to deploy/distribute Flask as an executable for desktop use?](https://www.reddit.com/r/Python/comments/21evjn/is_it_possible_to_deploydistribute_flask_as_an/){: target="_blank"} (Reddit)
- [Flask and pyinstaller notice](http://mapopa.blogspot.com.ar/2013/10/flask-and-pyinstaller-notice.html){: target="_blank"} (Personal Website)