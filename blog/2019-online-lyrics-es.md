Title: Generador Online de Presentación de Letras de Canciones.
Date: 2019-05-22
Category: Christianity
Tags: Christian, WebApp, Presentation, Lyrics
Slug: online-lyrics-presentation-generator
Authors: Ezequiel Leonardo Castaño
Lang: es
Translation: True
Headerimage: https://elc.github.io/blog/images/online-lyrics/online-lyrics-headerimage.png
<!-- Status: draft -->

[![Online Lyrics Presentation Generator Header Image]({static}images/online-lyrics/online-lyrics-headerimage-thumbnail.png){: .b-lazy width=1920 data-src=/blog/images/online-lyrics/online-lyrics-headerimage.png }](/blog/images/online-lyrics/online-lyrics-headerimage.png){: .gallery }

<!-- PELICAN_BEGIN_SUMMARY -->

La mayoría de las veces me encuentro escribiendo presentaciones en Power Point para pasar las letras de cancioens. Esto usualmente sucede en la reunión de jóvenes de la iglesia y en los campamentos cristianos. Como el proceso es bastante repetitivo y simple, consideré adecuado programar una pequeña aplicación web para generar estas presentaciones automáticamente. En este artículo mostraré cómo utilizarla y para aquellos interesados en la parte técnica también explico cómo funciona.

<!-- PELICAN_END_SUMMARY -->

## El Problema

Como se dijo en la introducción, el objetivo es básicamente evitar escribir una y otra vez presentaciones cada vez que se quieren pasar letras de canciones.

## La Solución

Desarrollar una aplicación Web para generar automáticamente la presentación en PowerPoint. Esta aplicación no requiere ninguna instalación y funcionará desde cualquier navegador, pero para una mejor experiencia de usuario se recomienda utilizarla desde un entorno de escritorio/tablet. En este artículo, dedicaré la siguiente sección a explicar cómo utilizarla para usuarios no técnicos y luego explicaré todos sus componentes desde una perspectiva técnica.

Nota: Entiendo la importancia de un diseño responsivo (apto para móbiles), pero en este caso para producir una presentación que coincida con el texto, se necesitan dimensiones más grandes que las que proporciona el teléfono móvil habitual. Además, es poco probable que el usuario descargue la presentación desde un dispositivo móvil.

## Cómo usarlo

La aplicación está disponible [online](https://elc.github.io/link/lyrics_presentation){: target="_blank"}, tan pronto como la abras, verás algo como lo siguiente:

[![image alt text]({static}images/online-lyrics/tutorial-thumbnail.png){: width=1245 .b-lazy data-src=/blog/images/online-lyrics/tutorial.png }](/blog/images/online-lyrics/tutorial.png ){: .gallery}

En la pantalla hay 3 áreas principales:

- **Área de letras**: es el área marcada en **naranja**, aquí es donde se escribirá el texto de la letra. Para escribir correctamente la letra, hay que seguir las instrucciones (ver abajo).
- **Selección de idioma**: En la esquina superior derecha, hay dos banderas marcadas con **verde**, cada una cambia el idioma de toda la página.
- **Botones** Esta área está marcada con **púrpura**, incluye dos botones, uno para generar la presentación y el otro para borrar el área de texto.

### Instrucciones para escribir la letra

Para escribir la letra, se debe seguir la siguiente guía:

- Escribir cada verso sin líneas en blanco.
- Separar los versos con líneas en blanco.
- Separar las canciones con tres guiones ("---").

El tamaño del área de letras se establece para que coincida con la presentación resultante, de modo que si el texto encaja bien en la página web, también encajará en la presentación.

## Cómo funciona (Técnico)

Esta aplicación web está construida usando vanilla `HTML5`, `CSS3` y `Javascript`. Además, se utiliza una biblioteca `Javascript` para crear la presentación, esta biblioteca es [**PptxGenJS**](https://github.com/gitbrent/PptxGenJS){: target="_blank"}.

El `CSS` está escrito dentro del `HTML` para evitar usar otra petición al servidor, esto se hace porque todo el estilo es de unas 100 líneas y toda la aplicación está contenida en un único archivo html. El `Javascript` está separado para evitar mezclar las capas de lógica y presentación.

Primero mostraré todo el código y luego lo dividiré en partes y explicaré parte por parte.

El código `Javascript` es el siguiente:

    :::javascript
    function createPPT() {
        var pptx = new PptxGenJS();

        pptx.setTitle("Presentation created with ELC's Presentation Generator");

        pptx.defineSlideMaster({
            title: 'Template',
            bkgd: '000000',
            objects: [{
                'placeholder': {
                    options: {
                        name: 'body',
                        type: 'body',
                        x: 0,
                        y: 0,
                        w: "100%",
                        h: "100%",
                        align: "center",
                        fontSize: 44,
                        color: 'FFFFFF',
                        fontFace: 'Verdana',
                        valign: 'middle',
                        paraSpaceAfter: '6',
                        paraSpaceBefore: '6'
                    },
                    text: ''
                }
            }]
        });

        var text = document.getElementById('lyrics').value

        parseLyrics(text).forEach(verse => {
            if (verse === "---") {
                createSlide(pptx, '');
                return;
            }

            createSlide(pptx, verse);
        });

        pptx.save("Presentation - Created with ELCs Presentation Generator");
    }

    function parseLyrics(text) {
        return text.replace(/[\r\n]{3,}/, "\n\n").split("\n\n");
    }

    function createSlide(pptx, text) {
        var slide = pptx.addNewSlide('Template');
        slide.addText(text.toUpperCase(), {
            placeholder: 'body'
        });
    }

    function clearText() {
        document.getElementById('lyrics').value = '';
    }

    function changeLang(locale) {
        document.webL10n.setLanguage(locale);
    }

    window.addEventListener('localized', function () {
        document.getElementById('lyrics').value = document.webL10n.get('verse1') + "\n\n";
        document.getElementById('lyrics').value += document.webL10n.get('verse2') + "\n\n";
        document.getElementById('lyrics').value += document.webL10n.get('separator') + "\n\n";
        document.getElementById('lyrics').value += document.webL10n.get('verse1') + "\n\n";
        document.getElementById('lyrics').value += document.webL10n.get('verse2') + "\n\n";
        document.getElementById('lyrics').value += document.webL10n.get('verse3');
    }, false);

### Función principal

La función `createPPT` es la función principal que se llama cada vez que se hace clic en el botón "Generar presentación". Realiza las siguientes acciones:

1. Crear el objeto de presentación.
1. Configurar el Título.
1. Definir la plantilla
1. Extraer el texto
1. Agregar cada una de las diapositivas
1. Guardar el archivo

Cada una de las acciones está representada en una de las siguientes líneas. Para mantenerlo simple, las tareas más complejas se explican con más detalle a continuación. Los métodos utilizados para establecer el título y guardar son evidentes y no requieren explicación.

    :::javascript
    function createPPT() {
        var pptx = new PptxGenJS();

        pptx.setTitle("Presentation created with ELC's Presentation Generator");

        // Definir la plantilla

        // Extraer el texto

        // Agregar diapositivas

        pptx.save("Presentation - Created with ELCs Presentation Generator");
    }

#### Definición de plantilla

Para lograr un estilo consistente, se debe utilizar una plantilla. Según mi propia experiencia, el fondo negro con letras blancas da los mejores resultados. Para definir una Plantilla se utiliza el método `defineSlideMaster`. Sus parámetros corresponden a la obtención de diapositivas con las siguientes características:

- Color de fondo negro: `bkgd: '000000'`
- Asignar un título único para usar cuando se crea la diapositiva: `title: 'Template'`
- Dar un identificador único a un elemento de texto dentro de la diapositiva: `name: 'body'`
- Establecer las coordenadas del elemento de texto: `x: 0, y: 0,`
- Establezca las dimensiones, tanto de ancho como de alto: `w: "100%", h: "100%",`
- Usar un tamaño de fuente grande: `fontSize: 44`
- Utilice el color Blanco para la fuente: `color: 'FFFFFF'`
- Centrar el texto horizontal y verticalmente: `align: "center", valign: 'middle',`
- Establezca el espacio entre párrafos: `paraSpaceAfter: '6', paraSpaceBefore: '6'`

Al combinar todo lo anterior y siguiendo la sintaxis proporcionada por la documentación oficial, el resultado es el siguiente código:

    :::javascript
    // Definición de Plantilla

    pptx.defineSlideMaster({
        title: 'Template',
        bkgd: '000000',
        objects: [{
            'placeholder': {
                options: {
                    name: 'body',
                    type: 'body',
                    x: 0,
                    y: 0,
                    w: "100%",
                    h: "100%",
                    align: "center",
                    fontSize: 44,
                    color: 'FFFFFF',
                    fontFace: 'Verdana',
                    valign: 'middle',
                    paraSpaceAfter: '6',
                    paraSpaceBefore: '6'
                },
                text: ''
            }
        }]
    });

#### Extracción de texto

Una vez definida la plantilla, se debe extraer el texto, para ello se utiliza una práctica muy común en JS. Simplemente se hace referencia al elemento mediante un ID determinado y luego se extrae su valor. En este caso el elemento es un TextArea definido en HTML5

El código resultante es el siguiente:

    :::javascript
    // Extracción de Texto

    var text = document.getElementById('lyrics').value

#### Añadir diapositiva

Después de extraer el texto, debe ser analizado y luego se debe agregar una nueva diapositiva para cada verso.

La función de parsing devuelve una lista de cadenas, cada una de las cuales puede ser un verso o un `---` que básicamente significa "Diapositiva vacía". Tanto la `parseLyrics` como la `createSlide` se explican a continuación.

    :::javascript
    // Añadir Diapositiva

    parseLyrics(text).forEach(verse => {
        if (verse === "---") {
            createSlide(pptx, '');
            return;
        }

        createSlide(pptx, verse);
    });

### Parsing

Uno nunca podría saber lo que el usuario escribiría, y, para soportar varios idiomas (especialmente aquellos con caracteres especiales), es importante usar un separador que funcione universalmente, en este caso la línea en blanco separará dos versos y los tres guiones (---) separarán las canciones.

Para ignorar varias líneas en blanco y luego dividirla se utiliza una expresión regular y luego se usa el método `split`.

    :::javascript
    function parseLyrics(text) {
        return text.replace(/[\r\n]{3,}/, "\n\n").split("\n\n");
    }

### Crear diapositiva

Cada diapositiva tendrá un texto diferente, así que para crear una diapositiva se debe proporcionar el motor de presentación (en este caso la biblioteca `pptx`) y el texto a insertar (el argumento `text`), luego se crea la nueva diapositiva usando la plantilla predefinida, después de lo cual el texto en mayúsculas se añade usando el placeholder definido en la plantilla.

    :::javascript
    function createSlide(pptx, text) {
        var slide = pptx.addNewSlide('Template');
        slide.addText(text.toUpperCase(), {
            placeholder: 'body'
        });
    }

### Botón Borrar texto

En caso de que el usuario desee eliminar todo en el Área de letras, se proporciona un botón, la funcionalidad es sobrescribir el contenido actual del Área de texto con una cadena vacía.

    :::javascript
    function clearText() {
        document.getElementById('lyrics').value = '';
    }

### Localización

Esta función adicional proporciona localización del lado del cliente a través de [WebL10n](https://github.com/fabi1cazenave/webL10n){: target="_blank"}, cada cadena de caracteres de la aplicación web está disponible tanto en inglés como en español, pero se podrían añadir más idiomas en el futuro si fuera necesario.

    :::javascript
    function changeLang(locale) {
        document.webL10n.setLanguage(locale);
    }

    window.addEventListener('localized', function () {
        document.getElementById('lyrics').value = document.webL10n.get('verse1') + "\n\n";
        document.getElementById('lyrics').value += document.webL10n.get('verse2') + "\n\n";
        document.getElementById('lyrics').value += document.webL10n.get('separator') + "\n\n";
        document.getElementById('lyrics').value += document.webL10n.get('verse1') + "\n\n";
        document.getElementById('lyrics').value += document.webL10n.get('verse2') + "\n\n";
        document.getElementById('lyrics').value += document.webL10n.get('verse3');
    }, false);