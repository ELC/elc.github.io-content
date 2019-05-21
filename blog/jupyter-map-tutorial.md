Title: Jupyter Education Map - How to create Online Interactive Maps with MapBox
Date: 2019-05-21
Category: Tutorial
Tags: Programming, Tutorial, Maps
Slug: jupyter-mapbox-tutorial
Authors: Ezequiel Leonardo Castaño
Lang: en
Headerimage: https://elc.github.io/blog/images/jupyter-mapbox-tutorial/jupyter-mapbox-tutorial-headerimage.png
Status: draft

[![Elevator Header Image]({attach}images/jupyter-mapbox-tutorial/jupyter-mapbox-tutorial-headerimage-thumbnail.png){: .b-lazy width=1920 data-src=/blog/images/jupyter-mapbox-tutorial/jupyter-mapbox-tutorial-headerimage.png }](/blog/images/jupyter-mapbox-tutorial/jupyter-mapbox-tutorial-headerimage.png){: .gallery }

<!-- PELICAN_BEGIN_SUMMARY -->

One of the most important part of any project is visualize the results in a comprehensible manner and, when dealing with coordinates and georeferencing data, there is no better option to use a Map. This is a quick guide where I showed how I used free technologies to create an online interactive map to show which universities are using Jupyter in class and some details of the courses. The tech stack was: HTML, CSS, JS + Mapbox + GeoJSON.

<!-- PELICAN_END_SUMMARY -->

## The Problem

When I was in my 3rd year of university, I found myself using Jupyter a lot but I realized that this practical tool wasn't used in any of the university courses. Seeing it very frequently in the PyCons and PyData I started to think that maybe Jupyter Notebooks were much more popular in the industry and hobbyists spheres rather than the academic.

In order to test my initial hypothesis I tried to recollect data and created a dataset and then display it on a map, since I suspected there might be geographical influences too. I joint the [Jupyter Education Group](LINK) and then start to think how should I develop a piece of software that could show the data practical and efficiently.

## The solution

I decided to develop a simple Web App, using only free technologies and deploying it using some free hosting service. Since I wanted it to be as simple as possible I chose not to use a framework and instead use only vanilla HTML, CSS and JS. I would use some map library but nothing else.

## The Dataset

The real key component of this project is the data, since without it, it is impossible to create the map.

The dataset was based on a previous [survey made by Jessica Hamrick](https://github.com/jupyter/surveys/tree/master/surveys/2016-05-education-survey), then an open questions was published in the [Jupyter Education Google Group](LINK) and some emails were sent to some of the teachers of the institutions represented in the mentioned group.

This could potentially allow noisy or false data but to avoid this issue, in order to submit a particular response, the sender should provide an email with ".edu" domain. Then an email was sent to that address and if answered, the response is added to the dataset.

The dataset is freely available in the [respository](LINK) and in case you need to cite it, there is an [associated DOI](LINK)

## The Tech Stack

To develop this project the following technologies are used:

- **GitHub Pages**: Free hosting for Github Repositories.
- **HTML5**: To give structure to the different sections.
- **CSS3**: To provide aesthetics to the site, no preprocessor is used (such as Sass or Less) because the site should be ready to deploy without any building step.
- **Javascript**: Some custom interactions with the user is programmed with vanilla JS
- **Google Analytics**: To add tracking and analytics to the site
- **Mapbox**: A Javascript library to create and interact with maps
- **OpenStreetMap**: A free alternative to Google Maps, it isn't used directly but rather under the hood by Mapbox
- **GeoJSON**: This is a special format based on JSON to represent simple geographical features. 

### Why not using a JS Framework?

Nowadays, there are lots of JS frameworks, and there is a clear trend to use them even for the simplest apps. I see little benefic in doing so when the vanilla equivalent solution takes so few lines.

For this particular scenario, a single web page is needed, which will in turn display a map to the user, and the user will interact with it. Then some additional features will be added but keeping everything in a single page.

The lines of code of this project could be split in the following areas:

- Structure (HTML): 77 lines
- Style (CSS): 100 lines
- Behaviour (JS): 220 lines

As one would expect, the Javascript part is the largest but it is fine, 200 or so lines are quite manageable. On the other hand, if a JS framework were used, the project would end up with several JS files that are not comprehensible by the developer, the project should separate the source and build files and the whole process should be automated via CI or similar.

Using a vanilla approach the source and build files are the same, no CI is needed for building (since this step doesn't take place) and the files are very easy to understand.

With this section, I don't want to say that I'm against Front-End Frameworks such as Angular, React, Vue, etc. but rather show that each technology has its advantages and disadvantages and in this case, the vanilla alternative is shorter, easier to deploy and easier to understand.

## Step by Step Guide

Now we are going to dive into the code and see how to create the website. First, the full code for the section will be shown and then comes an explanation. Basic HTML and Javascript knowledge is assume so I won't get into details of basic functionalities.

In every case, the HTML code will be shown first and then the javascript, each with its explanation.

Note: Since CSS is only the style, it won't be shown here, you can check the full CSS code [in the repository](LINK)

### Basic Functionality

The basic functionality covers:

- **Display all the points in the map**: This is almost trivial since if one host the GeoJSON in github, the default presentation already shows all the points in a map. But it will be necessary to program it in order to use it as a base for the next parts
- **Show a pop up on hover with the data of the point**: Since our points have more data than just its coordinates it would be very nice to visualize them in a pretty way. So a Pop Up on Hover is used. Using Click instead of hover would result in a much more mobile friendly experience but since I want to later add "Zoom on click", the click event can't be used for both.
- **Show basic navigation controls**: To the unexperienced user might result helpful and its implementation is trivial in the code.

HTML Code:

```html
<!DOCTYPE html>
<html>
  <head>
    <script src="https://api.mapbox.com/mapbox-gl-js/v0.44.2/mapbox-gl.js"></script>
    <link href="https://api.mapbox.com/mapbox-gl-js/v0.44.2/mapbox-gl.css" rel="stylesheet"/>
    <link href="style.css" rel="stylesheet" />
    <title>Jupyter Map</title>
  </head>

  <body>
    <div id="map"></div>
    <script src="./mapbox.1.js"></script>
  </body>
</html>
```

**HTML Explanation**

This is the basic structure for any HTML5 document, it has a **`DOCTYPE`**, a **`head`** tag and a **`body`** tag, the last two inside a **`html`** tag.

Inside the **`head`** a **`script`** tag is used to import the Mapbox-GL library, also two **`link`** tags are used, one for the Mapbox style and the other for our custom styles, finally a **`title`** tag is used to show the title of this page.

Inside the **`body`** only two tags are used, the first is a **`div`** with **`id="map"`**, it is where the map will be rendered, the second is a **`script`** tag where our custom script is loaded, this tag is placed at the end to avoid blocking the rendering of the document.

Javascript Code:

    :::javascript
    mapboxgl.accessToken = 'TOKEN';

    var center =  [10, 20]
    var initial = [ -60.643775, -32.954626]
    var zoom = 1.5
    var url = 'https://raw.githubusercontent.com/ELC/jupyter-map/master/jupyter-map.geojson';
    var places; // Get value async below

    var map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/light-v9',
        center: initial,
        zoom: 4,
        minZoom: zoom
    });

    // Add zoom and rotation controls to the map.
    map.addControl(new mapboxgl.NavigationControl());

    // Add data
    async function addData() {
        const response = await fetch(url);
        places = await response.json();

        // Add a layer of places from external file
        map.addSource('data', { type: 'geojson', data: places });
        map.addLayer({
            "id": "places",
            "type": "symbol",
            "source": 'data',
            "layout": {
                "icon-image": "marker-15",
                "icon-allow-overlap": true,
                "icon-size": 1.5,
                "text-field": "",
                'text-allow-overlap': true,
                'text-size': 16,
                "text-letter-spacing": 0.05,
                "text-offset": [0, 2]
            }
        });

    }

    // First time
    map.on('load', () => {
        addData();
    });

    // PopUp on Hover

    var popup = new mapboxgl.Popup();

    map.on('mouseenter', 'places', function(e) {
        // Change the cursor style as a UI indicator.
        map.getCanvas().style.cursor = 'pointer';

        // Create a popup, but don't add it to the map yet.

        let coordinates = e.features[0].geometry.coordinates.slice();
        let properties = e.features[0].properties;

        while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
            coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
        }

        // Populate the popup and set its coordinates based on the features found.

        let contactInfo = `
            <p><strong>Contact: </strong>${properties.contact_name}</p>
            <p><strong>Contact Email: </strong><a href="mailto:${properties.contact_email}" target="_blank">${properties.contact_email}</a></p>`

        if (properties.instructor_name && 0 !== properties.instructor_name.length){
            if (properties.contact_name.localeCompare(properties.instructor_name) !== 0){
                contactInfo = `
                    <p><strong>Instructor: </strong>${properties.instructor_name}</p>
                    <p><strong>Instructor Email: </strong><a href="mailto:${properties.contact_email}" target="_blank">${properties.instructor_email}</a></p>
                    ${contactInfo}`
            } else{
                contactInfo = `
                    <p><strong>Instructor: </strong>${properties.instructor_name}</p>
                    <p><strong>Instructor Email: </strong><a href="mailto:${properties.contact_email}" target="_blank">${properties.instructor_email}</a></p>`
            }
        }

        popup.setLngLat(coordinates)
            .setHTML(`
                <h2><a href="${properties.institution_url}" target="_blank">${properties.institution_name}</a></h2>
                <p><strong>Course Name: </strong> <a href="${properties.course_url}" target="_blank">${properties.course_name}</a></p>
                <p><strong>Course Area: </strong> ${properties.course_area}</p>
                ${contactInfo}`
            )
            .addTo(map);
    });

Since the code is quite long, I will first split it into pieces and explain piece by piece.

#### Initial declaration and Map Object Instantiation

    :::javascript
    mapboxgl.accessToken = 'TOKEN';

    var center =  [10, 20]
    var initial = [ -60.643775, -32.954626]
    var zoom = 1.5
    var url = 'https://raw.githubusercontent.com/ELC/jupyter-map/master/jupyter-map.geojson';
    var places; // Get value async below

    var map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/light-v9',
        center: initial,
        zoom: 4,
        minZoom: zoom
    });

#### Add Naviation Controls

    :::javascript
    // Add zoom and rotation controls to the map.
    map.addControl(new mapboxgl.NavigationControl());

#### Add Data Function

    :::javascript

    // Add data
    async function addData() {
        const response = await fetch(url);
        places = await response.json();

        // Add a layer of places from external file
        map.addSource('data', { type: 'geojson', data: places });
        map.addLayer({
            "id": "places",
            "type": "symbol",
            "source": 'data',
            "layout": {
                "icon-image": "marker-15",
                "icon-allow-overlap": true,
                "icon-size": 1.5,
                "text-field": "",
                'text-allow-overlap': true,
                'text-size': 16,
                "text-letter-spacing": 0.05,
                "text-offset": [0, 2]
            }
        });

    }

#### On Load Event

    :::javascript
    // First time
    map.on('load', () => {
        addData();
    });


#### PopUp

    :::javascript
    // PopUp on Hover

    var popup = new mapboxgl.Popup();

    map.on('mouseenter', 'places', function(e) {
        // Change the cursor style as a UI indicator.
        map.getCanvas().style.cursor = 'pointer';

        // Create a popup, but don't add it to the map yet.

        let coordinates = e.features[0].geometry.coordinates.slice();
        let properties = e.features[0].properties;

        while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
            coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
        }

        // Populate the popup and set its coordinates based on the features found.

        let contactInfo = `
            <p><strong>Contact: </strong>${properties.contact_name}</p>
            <p><strong>Contact Email: </strong><a href="mailto:${properties.contact_email}" target="_blank">${properties.contact_email}</a></p>`

        if (properties.instructor_name && 0 !== properties.instructor_name.length){
            if (properties.contact_name.localeCompare(properties.instructor_name) !== 0){
                contactInfo = `
                    <p><strong>Instructor: </strong>${properties.instructor_name}</p>
                    <p><strong>Instructor Email: </strong><a href="mailto:${properties.contact_email}" target="_blank">${properties.instructor_email}</a></p>
                    ${contactInfo}`
            } else{
                contactInfo = `
                    <p><strong>Instructor: </strong>${properties.instructor_name}</p>
                    <p><strong>Instructor Email: </strong><a href="mailto:${properties.contact_email}" target="_blank">${properties.instructor_email}</a></p>`
            }
        }

        popup.setLngLat(coordinates)
            .setHTML(`
                <h2><a href="${properties.institution_url}" target="_blank">${properties.institution_name}</a></h2>
                <p><strong>Course Name: </strong> <a href="${properties.course_url}" target="_blank">${properties.course_name}</a></p>
                <p><strong>Course Area: </strong> ${properties.course_area}</p>
                ${contactInfo}`
            )
            .addTo(map);
    });

### Add Some Extra functionality

Additionally, several other features could be added such as (from the simplest to the most complex):

- Integration with Google Forms and Github
- Show Text only with certain zoom
- Initial Animation
- Zoom to the point on click
- Modify Cursor
- Reset Zoom Button
- Style Menu
- Live Filter


#### Integration with Google Forms and Github

HTML Code:

```html
<button class="side-button add-button">
  <a href="https://kutt.it/jupyter-map" target="_blank">Add Institution</a>
</button>
<button class="side-button star-button">
  <a href="https://github.com/ELC/jupyter-map" target="_blank">See the Repo - Give a Star</a>
</button>
```

#### Show Text only with certain zoom

Code:

    :::javascript
    // Auto Display text based on Zoom

    map.on('zoomend', function(e) {
        map.setLayoutProperty('places', "text-field",
            map.getZoom() > 4.5 ? "{institution_name}" : "" )
    });


#### Initial Animation

Code:

    :::javascript
    map.on('load', () => {

        // Previos Code

        // Initial Animation
        setTimeout(() => {
            map.flyTo({
                center: center,
                zoom: zoom,
                speed: 1
            });
            }, 500)
    });

#### Zoom to the point on click

Code:

    :::javascript
    // Fly on click

    map.on('click', 'places', function (e) {
        map.flyTo({
            center: e.features[0].geometry.coordinates,
            zoom:16
        });
    });


#### Modify Cursor

Code:

    :::javascript
    //Modify Cursor
    map.on('mouseleave', 'places', function(e) {
        map.getCanvas().style.cursor = '';
    });

    map.on('click', function(e) {
        let event = new Event('keyup');
        map.getCanvas().style.cursor = '';
    });

#### Reset Zoom Button

HTML Code:

```html
<button id="reset">Reset Zoom</button>
```

Javascript Code:

    :::javascript
    // Reset Button

    document.getElementById('reset').addEventListener('click', function() {
        map.setLayoutProperty('places', "text-field", "")
        map.flyTo({
            center: center,
            zoom: zoom,
            speed: 1.2
        });
    });

#### Style Menu

HTML Code:

```html
<div id="menu">
  <span class="menu__item">
    <input id="basic" type="radio" name="rtoggle">
    <label for="basic">Basic</label>
  </span>
  <span class="menu__item">
    <input id="streets" type="radio" name="rtoggle">
    <label for="streets">Streets</label>
  </span>
  <span class="menu__item">
    <input id="bright" type="radio" name="rtoggle">
    <label for="bright">Bright</label>
  </span>
  <span class="menu__item">
    <input id="light" type="radio" name="rtoggle" checked="checked">
    <label for="light">Light</label>
  </span>
  <span class="menu__item">
    <input id="dark" type="radio" name="rtoggle">
    <label for="dark">Dark</label>
  </span>
  <span class="menu__item">
    <input id="traffic-night" type="radio" name="rtoggle">
    <label for="traffic-night">Night</label>
  </span>
  <span class="menu__item">
    <input id="traffic-day" type="radio" name="rtoggle">
    <label for="traffic-day">Day</label>
  </span>
</div>
```

Javascript Code:

    :::javascript

    function switchLayer(layer) {
        let layerId = layer.target.id;
        let version = '-v9'
        if (layerId.includes('traffic')){
            version = '-v2'
        }
        map.setStyle('mapbox://styles/mapbox/' + layerId + version);
    }

    map.on('load', () => {

        // previous code

        // Style Menu
        let layerList = document.getElementById('menu');
        let inputs = layerList.getElementsByTagName('input');

        for (let i = 0; i < inputs.length; i++) {
            inputs[i].onclick = switchLayer;
        }
    });

#### Live Filter

HTML Code:

```html
<div class="filter-ctrl">
    <input id="filter-input" type="text" name="filter" placeholder="Filter Institution by Name"/>
</div>
```

Javascript Code:

    :::javascript
    var filterInput = document.getElementById('filter-input');

    async function addData() {

        // Previous Code

        // Filter by Input
        let layerIDs = [];

        places.features.forEach(function(feature) {
            var symbol = feature.properties['institution_name'];
            var layerID = symbol.trim().toLowerCase();

            // Add a layer for this symbol type if it hasn't been added already.
            if (!map.getLayer(layerID)) {
                map.addLayer({
                    "id": layerID,
                    "type": "symbol",
                    "source": "data",
                    "layout": {
                        "icon-image": "marker-15",
                        "icon-allow-overlap": true,
                        "icon-size": 1.5,
                        "text-field": "",
                        'text-allow-overlap': true,
                        'text-size': 14,
                        "text-letter-spacing": 0.05,
                        "text-offset": [0, 2],
                    },
                    "paint": {
                        "text-color": "#202",
                        "text-halo-color": "#fff",
                        "text-halo-width": 2
                    },
                    "filter": ["==", "institution_name", symbol]
                });

                layerIDs.push(layerID);
            }
        });

        filterInput.addEventListener('keyup', function(e) {
            // If the input value matches a layerID set
            // it's visibility to 'visible' or else hide it.
            map.setLayoutProperty('places', "visibility",
                !e.target.value ? "visible" : "none");

            var value = e.target.value.trim().toLowerCase();
            layerIDs.forEach(function(layerID) {
                map.setLayoutProperty(layerID, 'visibility',
                    layerID.includes(value) ? 'visible' : 'none');
                map.setLayoutProperty(layerID, 'text-field',
                    (e.target.value && layerID.includes(value)) ? '{institution_name}' : '');
            });
        });
    }

##### Add Layer for every element

    :::javascript
    // Filter by Input
    let layerIDs = [];

    places.features.forEach(function(feature) {
        var symbol = feature.properties['institution_name'];
        var layerID = symbol.trim().toLowerCase();

        // Add a layer for this symbol type if it hasn't been added already.
        if (!map.getLayer(layerID)) {
            map.addLayer({
                "id": layerID,
                "type": "symbol",
                "source": "data",
                "layout": {
                    "icon-image": "marker-15",
                    "icon-allow-overlap": true,
                    "icon-size": 1.5,
                    "text-field": "",
                    'text-allow-overlap': true,
                    'text-size': 14,
                    "text-letter-spacing": 0.05,
                    "text-offset": [0, 2],
                },
                "paint": {
                    "text-color": "#202",
                    "text-halo-color": "#fff",
                    "text-halo-width": 2
                },
                "filter": ["==", "institution_name", symbol]
            });

            layerIDs.push(layerID);
        }
    });

##### Add Event Listener

    :::javascript
    filterInput.addEventListener('keyup', function(e) {
        // If the input value matches a layerID set
        // it's visibility to 'visible' or else hide it.
        map.setLayoutProperty('places', "visibility",
            !e.target.value ? "visible" : "none");

        var value = e.target.value.trim().toLowerCase();
        layerIDs.forEach(function(layerID) {
            map.setLayoutProperty(layerID, 'visibility',
                layerID.includes(value) ? 'visible' : 'none');
            map.setLayoutProperty(layerID, 'text-field',
                (e.target.value && layerID.includes(value)) ? '{institution_name}' : '');
        });
    });

## Online Map

The final result can be seen [online](LINK) or below:

<div class="iframe-container" style="padding-top: 71%">
    <iframe class="b-lazy" data-src="https://elc.github.io/jupyter-map/"></iframe>
</div>