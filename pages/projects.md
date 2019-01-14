Title: Projects
Slug: projects
Lang: en
order: 5

As an engineering students I've worked in several projects, alone, in a team and also from a variety of subjects, development of software, project planning, risks evaluation and simulation. I also spend some time in side projects like this blog. Here I want to list the most relevant and important projects I've been part of and at the end I will mention some of the "toy projects" usually made for tutorials or courses.

## Software Development

**Ezequiel Castaño Personal Blog - Pelican & Python - 2018-Present - [Git Repo <i class="fa fa-github"></i>](https://github.com/ELC/elc.github.io-source)**

This website is my personal blog, I develop it using Pelican, and some plugins (some of which I write myself). The main objective of this development is to have a completely static, lightweight and modern website using only freely available technologies. Some of the features of the website are:

- All the building and deploying is manage by **Travis**, a continous integration and deployment system.
- The site is freely hosted in **Github Pages** and **Netlify**.
- All dependencies are manage via **Pipenv**.
- The build step is decomposed into **Invoke** tasks and **Pipenv** Scripts.
- The theme is downloaded at build time from git to ensure the lastest version is used.

The following features were provided via plugins I wrote:

- Service Worker **[Git Repo of Plugin <i class="fa fa-github"></i>](https://github.com/ELC/service_worker)**
    - A service worker is generated at build time which caches all lightweight static files.
    - The site can be viewed offline.
- Bundler **[Git Repo of Plugin <i class="fa fa-github"></i>](https://github.com/ELC/bundler_cache_busting)**
    - All the CSS and JS is bundle in a single file (one for each).
    - All the static files refenced in the HTML use Cache Busting.
- Shortener **[Git Repo of Plugin <i class="fa fa-github"></i>](https://github.com/ELC/shortener)**
    - Custom static shortener.
- Blur Thumbnails **[Git Repo of Plugin <i class="fa fa-github"></i>](https://github.com/ELC/blur_thumbnails)**
    - A blurred version of all the images is generated at build time.

This website was designed to work with the MinimalXYZ theme (see below) to achieve the best results, when using together, there are some additional features:

- All SCSS is compiled and compressed at build time.
- The image are lazily loaded with a blurred version when the connection isn't fast enough.
- The site can be installed on Android as PWA
- Comments via Disqus

Some other third party plugins used provided the following features:

- Know the estimated time to read an article
- Automatically generate a sitemap
- Get the related posts of an article
- Render Latex expressions
- Use Gruvbox theme for code
- Auto generate anchor tags for titles

The project is far from done since it wasn't just the web design but also the creation of a Blog I'm the author, there are some more technical features I would like to add but they will strongly depend on the free technologies I found and the time I have.

---

**MinimalXYZ - HTML5 CSS3 JS Sass - 2018-Present - [Git Repo <i class="fa fa-github"></i>](https://github.com/ELC/MinimalXYZ)**

MinimalXYZ is the Pelican Theme used for this website. It first started as a fork of another theme called MinimalXY and little by little I modify it to fit my needs and soon after I made a complete rewrite. Some of its main features are:

- Use semantic HTML5 - No "containers" divs.
- All the internal JS and CSS is split into a separate file to obtain lightweight HTMLs
- Sass (SCSS) as a CSS preprocesor.
- Pure Javascript, avoid using heavy weight libraries such as JQuery, Lodash and other to improve performance.
- CSS3 Transform for animations to improve user experience and performance.
- Responsive design.
- UI Features:
    - Hide menu bar on scroll down.
    - Show/Hide button to scroll to top.
    - Hamburger menu with animation top-down.
    - Toast notifications with animations
    - Smooth Scroll for anchor links
  
This theme was develop specifically for this blog so there are a number of features that are possible because of the pelican build step such as:

- All SCSS is compiled and compressed at build time.
- The image are lazily loaded with a blurred version when the connection isn't fast enough.
- Comment system via Disqus

The project is in a continous improvement and development, some of the features that will be added are:

- Migrate the styles to follow BEM methodology
- Fix some issues regarding templates for pagination and authors.
- LightBox for images

---

**Booking System - Java - 2017 - [Web <i class="fa fa-github" aria-hidden="true"></i>](https://github.com/ELC/utn-java-final-assignment-web) - [Desktop <i class="fa fa-github" aria-hidden="true"></i>](https://github.com/ELC/utn-java-final-assignment)**

This is a booking system implemented in the Java programming language which manage 3 entities, people, bookable types and bookable items. It creates bookings with no overlapping. Some of its features are:

- CRUD of Users.
- CRUD of Bookable Types.
- CRUD of Bookable items.
- Users must login to enter the system.
- Users can be enable and disable users to login.
- Each bookable type has a max number of bookings per user.
- Each bookable item is of one and only one bookable type.
- Users should be able to see and cancel future bookings.
- Each user must have a role.
- Some bookable types can be only book by a specific role.
- Each bookable type has a limit of time to book an item.
- Each bookable type can have a max number of days before it can be booked.
- Users with the admin role are the only ones who can create users and bookable types.
- Users with the admin role are the only ones who can enable and disable users.
- Users with the admin role can cancel any pending booking, therefore they can see every pending booking.
- An email must be sent to confirm each booking and its cancelation.

Non-Funcitonal Requirements for both Web and Desktop:

- The system should use GitHub as a configuration management system for version control (One for Web and another for Desktop).
- The system should use the 3 layer pattern for the architecture.
- The system should use custom exceptions and logs for errors.
- The Data Base must be MySQL.
- All the CRUD operations should be implemented as transactions when convinient.

Non-Funcitonal Requirements for both Web:

- The web pages should be written using JSP and Servlets.
- The data bindings should be use with JSTL.

---

**Educational System - .NET - 2017 - [WPF and ASP.Net MVC <i class="fa fa-external-link" aria-hidden="true"></i>](https://utn2017netg38.visualstudio.com/)**

This is a system for a university implemented using the .Net Framework.

Functional Requirements:

- CRUD of Users
- CRUD of Permissions
- CRUD of Students
- CRUD of Specialties
- CRUD of Professors
- CRUD of Plan of Studies
- CRUD of Subjects
- CRUD of Courses
- Assignment of qualifications
- 2 Reports (of any kind)

Non-Functional Requirements for Web and Desktop:

- The system should implement authentication.
- The system should implement authorization.
- The system should implement logs.
- The system should implement custom exceptions.
- The system should implement Visual Studio Team Services for version control.
- MS SQL Server should be use as a Data Base.
- The more complex queries should be used as Stored Procedures inside the DB.
- Credentials should be keep secure outside of the codebase.
- ADO.Net should be use for the data layer.
- All reusable functions should be kept in a separate "Utils" layer.
- A standard name convention should be use in the codebase
- Reports should be exported as PDF files.
- Passwords should be stored as hash.
- Passwords should be validated both in the presentation and in the logic layer.

Non-Functional Requirements for Web:

- The system has to be built using ASP.Net MVC.
- The system should use the MVC pattern for the architecture.
- Master Pages, Stylesheets, themes and skins should be used (or similar for ASP.Net MVC).
- Users Controls should be used (Replace with Partial Views for ASP.Net MVC).
- A CSS framework should be use
- The login should be modal

Non-Functional Requirements for Desktop:

- It has to be built using WPF.
- The system should use the 3 layer pattern for the architecture.

## Math and Simulation

**Elevators Simulation - AnyLogic - 2018 - [AnyLogic Cloud <i class="fa fa-external-link" aria-hidden="true"></i>](https://cloud.anylogic.com/model/5b79e7e8-05d3-47fb-b13e-8407d6b64e2f?mode=SETTINGS&tab=GENERAL)**

This is a simulation model in which the elevator of the university was represented. It was build with the AnyLogic software and the Free Learning Edition. The model can be [run online](https://cloud.anylogic.com/model/5b79e7e8-05d3-47fb-b13e-8407d6b64e2f?mode=SETTINGS&tab=GENERAL), as many times as you want. Some of its features are:

- Average Waiting Time in the ground Floor.
- Average Waiting Time inside the elevator.
- Average Waiting Time in floors that aren't the ground floor.
- Average Waiting Time in all the floors.
- Average lenght of the queue in the ground floor.
- Average lenght of the queue in floors that aren't the ground floor.
- Average lenght of the queue in all the floors.
- Utilization of the elevator.
- Average number of people inside the elevator.
- Average load of the elevator.
- Status of the elevator (Waiting, Moving, Empty, Full).
- Traffic Flow map for each floor (Heatmap).
- Stairs as an auxiliary system for the people that abandon the queue.
- Real scale of the blueprints of the University building.
- Custom distribution for the destination floors of each person.

---

**Simulation Basics - Wolfram Mathematica - 2018**

I use the Wolfram Mathematica software to create simulation models for basics scenarios:

- MM1 Queue simulation
- Triangular Distribution simulation
- Exponential Distribution simulation
- Uniform Distribution simulation
- Roulette Simulation
- Custom Random Numbers Generators through CDF

---

**Mathematical Modeling Basics - Wolfram Mathematica - 2017**

I used the Wolfram Mathematica software and the Ordinary Differential Equations to model some basic problems such as:

- Basic Domestic Economy
    - Basic income outcome model with fixed and variable costs
    - Fixed Term accounts added
    - Consumption adjusted proportional to income
    - Inflation Effect added
    - Retirement Effect added
- Inventory Modeling
- Predator-Prey Modeling
- Natural Decay
- Sale of houses and air conditioners

## Research

**Jupyter Map for Education - MapboxJS & GeoJSON - 2018 - [Git Repo <i class="fa fa-github" aria-hidden="true"></i>](https://elc.github.io/jupyter-map/) -  [Online Map <i class="fa fa-external-link" aria-hidden="true"></i>](https://elc.github.io/jupyter-map/)**: This is an interactive map where each University Course is represented. There is also a GeoJSON dataset in the git repo. The main idea of this map is to have access to the resources other universities and professors are using and fork them.

## Open Source Contributions

- **FastAI in Colab Template - Jupyter Notebooks - 2018 - [Github Gist <i class="fa fa-github" aria-hidden="true"></i>](https://gist.github.com/ELC/756040fe84a8bb3d14c59b0e997c84e9)**: I commented some of the issues open in the [FastAI in Colab Template Repo](https://github.com/corykendrick/fastai_in_colab) and end up with a fork of the repo with specific cells for supporting both FastAI 0.7 (the one that the main repo supports) and FastAI 1.x (the most current version)
- **Awesome Jupyter Curated List - 2018 - [Git Repo <i class="fa fa-github" aria-hidden="true"></i>](https://github.com/markusschanta/awesome-jupyter)**: I added some of the resources I thought were relevant and useful.
- **PyFladesk - Python, Flask, PyQT - 2018 - [Git Repo <i class="fa fa-github" aria-hidden="true"></i>](https://github.com/smoqadam/PyFladesk)**: Migrate from PyQT4 to PyQT5.5 and then to PyQT5.10, create PyPI, refactoring and update of docs.
- **Yabox - Python - 2018 - [Git Repo <i class="fa fa-github" aria-hidden="true"></i>](https://github.com/pablormier/yabox)**: Refactor and minor improvements.
- **NBFlow - Python Tox Scons - 2018 - [Git Repo <i class="fa fa-github" aria-hidden="true"></i>](https://github.com/jhamrick/nbflow)**: Migrate to Python 3. Add funtionality according to issues. Update tests and CI. Update Docs

## Scripts

As a hobby I usually write scripts to achieve some nice visualization of an algorithm or to test something I read, this list can get too long if I add every single script I wrote so I will only include some that I find important, more could be found in the posts of this blog.

**Genetic Algorithms - Python - 2017 - [Git Repo <i class="fa fa-github" aria-hidden="true"></i>](https://github.com/ELC/utn-genetic-algorithms)**: As a part of course at university I develop some scripts that implements Genetic Algorithms. And in the same course I develop a script to plot fractals.

- Minimizing a Mathematical Function (Excercise 1).
- Knapsack problem (Excercise 2).
- Travel Salesman Problem (Excercise 3).
- Fractals (Excercise 4)
