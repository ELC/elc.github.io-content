Title: Portfolio
Slug: projects
Lang: en
order: 2

Latest Update: 2020.11.02

So far I've worked on several projects, both on my own and in a team. This blog is the result of a side project.

On this page, I want to share the most relevant and important projects of mine as well as my current "Work in Progress". For the most updated material however, I recommend you to check my **[LinkedIn](https://www.linkedin.com/in/ezequielcastano/){: target="_blank"}**.

I also work as a consultant so if you want assistance for any of your projects regarding Data Science, Technical/Academic Writing, Python or Education, feel free to contact me via **[LinkedIn](https://www.linkedin.com/in/ezequielcastano/){: target="_blank"}** and we can discuss the details.

## Currently Working / Work in Progress

These are the projects I am currently working on because most probably I will publish the results as a conference paper, only the title will be disclosed.

- Designing a new method for Time Series Segmentation in Control Systems.
- Solving complex Epidemiological ODE-based Models using Cellular Automata and Optimization.
- Designing AI for a Graph-Based, Two-Player, Combinatorial game using Reinforcement Learning.
- Implementing a Web-Based Tool to compare several Optimization algorithms - [Incomplete Web App Online](https://elc.github.io/interactive-optimization/){: target="_blank"}
- Recording a series of videos about Speed Code Challenges in CodeWars (From 8 Kyu to 4 Kyu)
- Preparing an Expert Python Quiz to assess Python Knowledge.

## Education

**Python For Programmers Course (Originally in Spanish) - [Full Course on Youtube](https://www.youtube.com/playlist?list=PL6L8P83xTjQ43lioPhb7liCeg5fe6ucaE){: target="_blank"}**

I recorded a 4.5 hs course where I explained Python for an audience with some programming background, it covers both basic and complex aspects such as Context Managers, Decorators, Generators, and Coroutines. The content and code are publicly available.

## Data Science Projects

**Bayesian Networks for YouTube - [Research Paper](https://www.researchgate.net/publication/344303125_Using_Hybrid_Bayesian_Networks_to_Detect_Audience_Behaviour_Changes_in_Youtube){: target="_blank"}**

With Professor Guillermo Leale we presented in the European Modelling and Simulation Symposium a research paper where we analyzed YouTube data and implemented a model to identify non-trivial changepoints in a stable channel.

**New Gene Genetic Algorithms - [Research Paper](https://www.researchgate.net/publication/341785248_New_Gene-Level_Probabilistic_Genetic_Algorithm_to_Solve_Multi_Local_Minima_Problems){: target="_blank"}**

During my studies abroad and as a final project for the course "Research Skills" I wrote an open-access Paper with the title "New Gene-Level Probabilistic Genetic Algorithm to Solve Multi Local Minima Problems". The paper covers a new approach to Genetic Algorithms and compares it with the canonical version of the algorithm.

**Lane Detection for Autonomous Driving**

As part of my exchange semester in Germany, I worked in the Process Optimization department as a research student and I worked in a team developing a lane detection algorithm for a scaled car. The technologies used were Python, OpenCV, and Robotic Operative System (ROS)

**ODE Problems with Python - [Blog Post](https://elc.github.io/posts/ordinary-differential-equations-with-python/)**

Different ODE Problems were solved with Python, including different scenarios, like stable, unstable, phase diagram, univariate, multivariate, and basic plotting using Python and Matplotlib.

**Jupyter Map for Education - MapboxJS & GeoJSON - 2018 - [Git Repo](https://elc.github.io/jupyter-map/){: target="_blank"} - [Online Map <i class="fa fa-external-link" aria-hidden="true"></i>](https://elc.github.io/jupyter-map/){: target="_blank"}**

This Interactive Web Map shows University Courses that use Jupyter notebooks. It was built with data collected from the professors and formated in a GeoJSON file and plotted using MapboxJS.

## Simulation Projects

**Inventory Control Simulation - Python 2020 - [Resources Available Soon]**

With Gastón Amengual we developed a Monte-Carlo Inventory control simulation using a discrete-event paradigm and Python. This will be presented in the National Congress for Informatics and Systems Engineering in 2020 Fall.

**Elevators Simulation - AnyLogic - 2018 - [Blog Post](https://elc.github.io/posts/multi-floor-elevator-simulation-anylogic/) - [AnyLogic Cloud](https://elc.github.io/link/simulation-model){: target="_blank"}**

This is a simulation model in which the elevator of the university was represented. It was built with the AnyLogic software and the Free Learning Edition. The model can be [run online](https://elc.github.io/link/simulation-model){: target="_blank"}, as many times as you want. Some of its features are:

- Traffic Flow map for each floor (Heatmap).
- Stairs as an auxiliary system for the people that abandon the queue.
- Custom distribution for the destination floors of each person.
- Some of the KPIs:
    - Average Waiting Time.
    - Average length of the queue.
    - Utilization.

## Software Development Projects

**Personal Website - Pelican & Python - 2018-Present - [Git Repo](https://github.com/ELC/elc.github.io-source){: target="_blank"}**

I developed this website using Pelican, and some plugins (some of which I programmed myself). It is a completely static, lightweight, and modern website using only freely available technologies to share my articles, which are about both personal and professional topics.

Some of the features of the website are:

- Deploying and Integration with **TravisCI**.
- Hosted in **Github Pages** and **Netlify** as a backup.
- Dependencies management via **Pipenv**.
- Build automation with **Invoke** tasks and **Pipenv** Scripts.
- Theme is decoupled in a separate git repository.

The following features were provided via the plugins I developed:

- Service Worker **[Git Repo of Plugin](https://github.com/ELC/service_worker){: target="_blank"}**
    - A service worker is generated at build time which caches all lightweight static files.
    - The site can be viewed offline.
- Bundler **[Git Repo of Plugin](https://github.com/ELC/bundler_cache_busting){: target="_blank"}**
    - All the CSS and JS is bundle in a single file (one for each).
    - All the static files refenced in the HTML use Cache Busting.
- Shortener **[Git Repo of Plugin](https://github.com/ELC/shortener){: target="_blank"}**
    - Custom static shortener.
- Blur Thumbnails **[Git Repo of Plugin](https://github.com/ELC/blur_thumbnails){: target="_blank"}**
    - A blurred version of all the images is generated at build time.

This website was designed to work with the MinimalXYZ theme (see below) to achieve the best results, when using together, there are some additional features:

- All SCSS is compiled and compressed at build time.
- The images are lazily loaded with a blurred version when the connection isn't fast enough.
- The site can be installed on Android as PWA
- Comments via Disqus

Some other third-party plugins used provided the following features:

- Know the estimated time to read an article
- Automatically generate a sitemap
- Get the related posts of an article
- Use Gruvbox theme for code
- Auto-generate anchor tags for titles

---

**MinimalXYZ - Jinja2 HTML5 CSS3 JS Sass - 2018-Present - [Git Repo](https://github.com/ELC/MinimalXYZ){: target="_blank"}**

MinimalXYZ is the Pelican Theme used for this website. It first started as a fork of another theme called MinimalXY and completely rewrite it to my preference.

Some of its main features are:

- Use semantic HTML5 - No "containers" divs.
- All the internal JS and CSS is split into a separate file to obtain lightweight HTML
- Sass (SCSS) as a CSS preprocessor.
- Vanilla Javascript. No JQuery, Lodash, or similar ones to improve performance.
- CSS3 Transform for Animations.
- Responsive design.
- UI Features:
    - Hide menu bar on scroll down.
    - Show/Hide button to scroll to top.
    - Hamburger menu with animation top-down.
    - Toast notifications with animations
    - Smooth Scroll for anchor links
    - LightBox for images
  
This theme was developed specifically for this blog so many features that are possible because of the pelican build step such as:

- All SCSS is compiled and compressed at build time.
- Images are lazily loaded with a blurred version when the connection isn't fast enough.
- Comment system via Disqus

## Open Source Contributions

- **FastAI in Colab Template - Jupyter Notebooks - 2018 - [Github Gist](https://gist.github.com/ELC/756040fe84a8bb3d14c59b0e997c84e9){: target="_blank"}**: I commented some of the issues open in the [FastAI in Colab Template Repo](https://github.com/corykendrick/fastai_in_colab){: target="_blank"} and end up with a fork of the repo with specific cells for supporting both FastAI 0.7 (the one that the main repo supports) and FastAI 1.x (the most current version)
- **Awesome Jupyter Curated List - 2018 - [Git Repo](https://github.com/markusschanta/awesome-jupyter){: target="_blank"}**: I added some of the resources I thought were relevant and useful.
- **PyFladesk - Python, Flask, PyQT - 2018 - [Git Repo](https://github.com/smoqadam/PyFladesk){: target="_blank"}**: Migrate from PyQT4 to PyQT5.5 and then to PyQT5.10, create PyPI, refactoring and update of docs.
- **Yabox - Python - 2018 - [Git Repo](https://github.com/pablormier/yabox){: target="_blank"}**: Refactor and minor improvements.
- **NBFlow - Python Tox Scons - 2018 - [Git Repo](https://github.com/jhamrick/nbflow){: target="_blank"}**: Migrate to Python 3. Add funtionality according to issues. Update tests and CI. Update Docs

## Early Developments

These were my first projects, I have programmed several things earlier but these were the first time I developed a "complete system".

**Booking System - Java - 2017 - [Web](https://github.com/ELC/utn-java-final-assignment-web){: target="_blank"} - [Desktop](https://github.com/ELC/utn-java-final-assignment){: target="_blank"}**

A booking system implemented in the Java programming language which manages 3 main entities, people, bookable types, and bookable items. It creates bookings with no overlapping.

Some of its features are:

- CRUD of 3 different Classes (Users, Booking, and Items).
- Authentication and Authorization (Login and Roles).
- Email notifications when for confirmation (with tokens) and cancellation.

Non-Functional Requirements for both Web and Desktop:

- Develop the System both in Desktop and Web (Servlet and JSP).
- Use of Git and GitHub as a version control system.
- Architecture of 3 layers.
- Custom exceptions and Logs.
- Relational Database with stored procedures using MySQL.
- CRUS operations should be transactional.
- Data bindings with JSTL (Only Web).

---

**Educational System - .NET WPF and ASP.Net MVC - 2017 - [TFS Repo](https://utn2017netg38.visualstudio.com/){: target="_blank"}**

University System developed with the .Net Framework (WPF and ASP MVC). It covers the management of users, subjects, students, permissions, and related entities.

Functional Requirements:

- CRUD of 8 Classes (Users, Permissions, Students, Specialties, Professors, Plan of Studies, Subjects, Courses)
- Assignment of qualifications
- 2 Reports (of any kind)

Non-Functional Requirements for Web and Desktop:

- Authentication and Authorization (Login and Roles).
- The system should implement custom exceptions.
- Use of Visual Studio Team Services as a Version Control System.
- Relational Database with stored procedures using MS Server.
- Credentials are kept secure outside of the codebase.
- ADO.Net used for the data layer.
- Used the layered pattern for the architecture (Entities, Utils, Presentation, Controller, Model).
- Reports generation with export as PDF files.
- Passwords should be stored as a hash.
- Validations are done both in the presentation and logic layer.
- The system should use the MVC pattern for the architecture (only web).
- Partial Views for code reuse (only web).
- A CSS framework was used (only web).
- The login should be modal (only web).

## Other Toy Projects

I enjoy writing scripts, most of the time as a hobby, most of the projects are available as a blog post on this website or as a GitHub Repository.

**Circular Times Table - Python - 2019 - [Blog Post](https://elc.github.io/posts/times-tables/) - [Github Gist](https://gist.github.com/ELC/380e584b87227b15727ec886223d9d4a){: target="_blank"} - [Online Jupyter (MyBinder)](https://mybinder.org/v2/gist/ELC/380e584b87227b15727ec886223d9d4a/HEAD?filepath=circular_times_table.ipynb){: target="_blank"}**: Using a Mathologer video to reproduce the results using basic and advance matplotlib to create HD animations.

**Fractals - Python - 2018 - [Blog Post](https://elc.github.io/posts/plotting-fractals-step-by-step-with-python/)**: Developed nice visuals for Fractals using Python Turtle and L-Systems.

**Genetic Algorithms - Python - 2017 - [Git Repo](https://github.com/ELC/utn-genetic-algorithms){: target="_blank"}**: As a part of a course at university I developed some scripts that implement Genetic Algorithms, this was my first contact with this methodology.
