Title: Guía introductoria de Git con Interfaz Visual
Date: 2019-01-30
Category: Software Engineer
Tags: Git, GUI, GitKraken
Slug: git-guide-with-visual-interface
Authors: Ezequiel Leonardo Castaño
Lang: es
Headerimage: https://elc.github.io/blog/images/git-guide-with-visual-interface/git-guide-with-visual-interface-headerimage.png

[![Git Tutorial Header Image]({attach}images/git-guide-with-visual-interface/git-guide-with-visual-interface-headerimage-thumbnail.png){: width=2000 .b-lazy width=2000 data-src=/blog/images/git-guide-with-visual-interface/git-guide-with-visual-interface-headerimage.png }](/blog/images/git-guide-with-visual-interface/git-guide-with-visual-interface-headerimage.png ){.gallery}

<!-- PELICAN_BEGIN_SUMMARY -->

Siendo estudiante de ingeniería en sistemas, en sucesivas oportunidades me encontré con sistemas de control de versiones, algunas veces desde materias relacionadas con la programación y otras en materias relacionadas con la ingeniería de software.

Recordando que cuando yo tuve que aprender todos estos conceptos (especialmente como funciona Git), pasé por varias dificultades, decidí hacer una guía introductoria con conceptos básicos de Git y cómo utilizarlo mediante un software con interfaz visual.

<!-- PELICAN_END_SUMMARY -->

Personalmente, pienso que para empezar, utilizar una interfaz visual puede ser útil y didáctico, sin embargo, comparto la idea de que entender como funciona la herramienta desde la consola es fundamental para una comprensión profunda de los conceptos.

En este tutorial se verán de manera resumida las características principales de un software particular que personalmente pienso que es el mejor, llamado GitKraken. Esta guía no pretende en ninguna medida ser exhaustiva ni detallada en todas las funciones de GitKraken, sino dar al usuario el conocimiento básico para que pueda usar la herramienta y poco a poco pueda ir explorando las demás características por su cuenta.

[Al final del documento](#caracteristicas-adicionales) se detallan algunas de las funcionalidades avanzadas para que el usuario pueda conocer que otras características tiene Git.

A continuación dejo el índice de contenidos en caso de que se desee saltear a alguna sección determinada

- [Introducción a Git](#introduccion-a-git)
    - [Areas en Git](#areas-en-git)
    - [Stage vs Commit](#stage-vs-commit)
    - [Repositorios remotos](#repositorios-remotos)
    - [Branches](#branches)
    - [Software adicional](#software-adicional)
- [Fork de un repositorio](#fork-de-un-repositorio)
    - [1. Encontrar el repositorio original](#1-encontrar-el-repositorio-original)
    - [2. Realizar el Fork](#2-realizar-el-fork)
- [Clonar un repositorio](#clonar-un-repositorio)
    - [1. Crear un repositorio](#1-crear-un-repositorio)
    - [1 (Alternativa). Crear un repositorio](#1-alternativa-crear-un-repositorio)
    - [2. Completar la información necesaria](#2-completar-la-informacion-necesaria)
    - [3. Obtener URL del Repositorio](#3-obtener-url-del-repositorio)
    - [4. Abrimos la ventana de Clone dentro del GitKraken](#4-abrimos-la-ventana-de-clone-dentro-del-gitkraken)
    - [4 (Alternativa 1). Abrimos la ventana de Clone dentro del GitKraken](#4-alternativa-1-abrimos-la-ventana-de-clone-dentro-del-gitkraken)
    - [4 (Alternativa 2). Abrimos la ventana de Clone dentro del GitKraken](#4-alternativa-2-abrimos-la-ventana-de-clone-dentro-del-gitkraken)
    - [5. Pegamos la URL](#5-pegamos-la-url)
    - [5. Notificación de Éxito](#5-notificacion-de-exito)
- [Abrir un repositorio](#abrir-un-repositorio)
    - [1. Ventana de Open](#1-ventana-de-open)
    - [1 (Alternativa 1). Ventana de Open](#1-alternativa-1-ventana-de-open)
    - [1 (Alternativa 2). Ventana de Open](#1-alternativa-2-ventana-de-open)
    - [2. Seleccionar el repositorio](#2-seleccionar-el-repositorio)
    - [3. Seleccionar la carpeta](#3-seleccionar-la-carpeta)
- [Elementos de la interfaz](#elementos-de-la-interfaz)
    - [Interfaz básica](#interfaz-basica)
    - [Arbol de Commits y Branches](#arbol-de-commits-y-branches)
- [Añadir Cambios](#anadir-cambios)
- [Sincronización con repositorios remotos](#sincronizacion-con-repositorios-remotos)
    - [Descargar los cambios del repositorio remoto](#descargar-los-cambios-del-repositorio-remoto)
    - [Subir los cambios al repositorio remoto](#subir-los-cambios-al-repositorio-remoto)
    - [Ejemplo de Fetch y Pull](#ejemplo-de-fetch-y-pull)
- [Trabajo en múltiples branches](#trabajo-en-multiples-branches)
    - [Crear Branch](#crear-branch)
    - [Unir Branches (Merge)](#unir-branches-merge)
    - [Borrar Branch](#borrar-branch)
- [Pull Requests](#pull-requests)
- [Características Adicionales](#caracteristicas-adicionales)

## Introducción a Git

Git es una tecnología de sistema de control de versiones (VCS), surge como alternativa a SVN, Hg y TFS y su propósito original fue controlar las versiones del kernel de Linux.

Antes de comenzar con el vocabulario específico es necesario explicar por qué se debe usar git u otro VCS.

Problema: Al estar trabajando en un proyecto, los archivos sufren múltiples transformaciones, esto es especialmente notorio en proyectos de diseño gráfico y de desarrollo de software. Con el avance del tiempo, es normal que se detecten errores y se desee volver a una instancia anterior, muchas veces lo que hace en este caso es hacer copias de respaldo, sin embargo, este enfoque es poco práctico en entornos con cambios constantes y al aumentar la cantidad de archivos y crece de manera sustancial cuando se trabaja en equipos grandes.

Solución de los VCS: Cada sistema propone una solución distinta, en el caso de Git siempre se hablan de cambios a nivel de línea, es decir, un archivo cambia cuando una de sus líneas cambias y si se realizan varios cambios en una misma línea, cuenta como un único cambio. Asimismo, si se realiza un cambio en varias líneas en un mismo archivo, cuentan como varios cambios, tantos como líneas se hayan modificado. Siempre que se hable de cambios se hará con este sentido, cambios en líneas. Esto hace que Git sea sumamente útil para archivos de texto con múltiples líneas (como los archivos fuente de un lenguaje de programación) y poco aplicable a archivos que no siguen este formato (como por ejemplo, los ejecutables, imágenes, etc.)

### Areas en Git

Git trabaja principalmente separando los cambios en 3 áreas:

1. Working Area: Son los archivos con los que uno está actualmente trabajando.
1. Staging Area: Son los próximos cambios que serán guardados en el repositorio.
1. Repository: Son los archivos guardados, generalmente local y en internet.

Así mismo, para pasar de un área a otro, existen distintas transiciones. Para pasar del Working Area al Staging Area se realiza un "Stage" y para pasar del Staging Area al repository se realiza un “Commit”

### Stage vs Commit

En un proceso, un usuario trabaja con sus archivos en el Working Area, una vez que haya terminado los cambios deseados, puede seleccionar exactamente que cambios desea agregar al repositorio, estos cambios son elegidos y se "mueven" a la Staging Area (el término mover en este caso es engañoso ya que en el sistema local los archivos no sufren ninguna modificación). Una vez que todos los cambios hayan sido movidos al Staging Area se puede realizar un “Commit”, el commit consiste básicamente en “empaquetar todo lo que esté en el Staging Area, asociarle un título y una descripción y subirlo al repositorio”.

Al principio esta forma de trabajo podría dar la impresión de que la Staging Area no cumple ninguna función, sin embargo cobra relevancia especialmente cuando uno quiere realizar un commit con un subconjunto de todos los cambios hechos, por ejemplo, se realizaron cambios en la interfaz gráfica y en la base de datos y uno quiere que cada "paquete de cambios" esté en un commit distinto, para eso, primero movería al Staging Area los cambios de la base de datos, haría el commit y luego repetiría el proceso con los cambios de la interfaz gráfica.

El usuario no está obligado a realizar un commit con todos los cambios. OJO: Uno podría mover al Staging Area sólo un subconjunto de las líneas modificadas en un archivo, es por eso que es importante recordar que el término "cambio" hace referencia a líneas y no a archivos.

Una vez realizado el commit, los cambios quedan definitivamente guardados en el repositorio, el repositorio siempre existe en un nivel local en la máquina del usuario y adicionalmente suele utilizarse una copia de manera remota en algún proveedor que lo permita, los más comunes son GitHub, Gitlab y Bitbucket.

### Repositorios remotos

Cuando uno trabaja con un repositorio remoto, surgen dos términos importantes: Pull (Tirar), Push (Empujar), Clone. Como sugieren los nombres, Pull trae los cambios del repositorio remoto y los aplica en el repositorio local, Push sube los cambios del repositorio local al repositorio remoto. Clone, por otro lado, copia el repositorio remoto y crea uno local, esta operación sólo se realiza una vez (No confundir con Fork).

**Fork vs Clone:**  Un Fork es una copia independiente de un repositorio. Cuando uno realiza un Clone, se tiene la intención de trabajar en ese repositorio, cuando uno realiza un Fork se tiene la intención de realizar una variante e independizarse (hasta cierto punto) del repositorio original. Hacer un Fork reemplaza el proceso de creación del repositorio y para hacerlo uno debe ir al repositorio original

NOTA: Siempre y cuando los cambios no se solapen (es decir que dos usuarios no hayan modificado la misma línea), el mismo sistema Git se encarga de combinarlos. Cuando dos o más usuarios modifican la misma línea del mismo archivo es necesaria una "Resolución de conflictos". Es un tema avanzado sin embargo puede requerirse a diario en entornos con múltiples programadores, aquellos que utilicen git como únicos usuarios no deberían preocuparse por este aspecto.

### Branches

El último concepto importante son las "branches", esta es la clave de la utilidad de Git, dentro de un repositorio uno puede tener múltiples branches (ramas en español), cada branch permite tener una Working Area independiente, esto se hace para mantener los cambios aislados, si bien el proceso de Stage-Commit es el mismo que el mencionado anteriormente, uno puede desear experimentar una nueva característica pero sin riesgos que se pierda o mezcle con el código que ya funciona correctamente, para eso se hace un nuevo branch y en el caso de éxito, se puede unir (merge en inglés) a la branch principal. Existen múltiples criterios para la creación de branches, algunas organizaciones utilizan una branch por características, otras una branch por desarrollador, etc. A la forma de utilizar las branches se la suele llamar “Git Strategy” o “Git Workflow”, siendo considerada una buena práctica tener un esquema simplificado con las siguientes branches:

- Master: Donde se tiene el código de la última versión estable
- Release: Donde se concentran todos los cambios que estarán en la próxima versión y se realizan las pruebas finales
- Develop: Donde se tiene el código experimental y que aún está siendo probado
- Hot Fix: Donde se reparan errores detectados a posteriori (fuera de las pruebas)
- Features: Una rama independiente por cada característica que se le quiera agregar al software.

Lo anterior puede visualizarse mucho mejor en una imagen. Cada flecha indica una operación de unión (merge)

[![image alt text]({attach}images/git-guide-with-visual-interface/image_0-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_0.png }](/blog/images/git-guide-with-visual-interface/image_0.png ){.gallery}

### Software adicional

Git es una aplicación de consola, sin embargo, existen múltiples softwares con interfaz gráfica construidos sobre la aplicación de consola base. En este caso vamos a detallar el uso típico de uno de los más populares: GitKraken

Por cuestiones de simplicidad, se asume que el usuario tiene correctamente instalado el software Gitkraken y que está listo para usarse, por lo tanto no se detallan pasos de instalación y configuración inicial.

## Fork de un repositorio

Como se mencionó, un fork es una copia independiente de un repositorio. El repositorio ya tiene su propio creador e historial de branches y commits pero uno desea hacer una copia independiente. Este procedimiento puede variar de un proveedor de repositorios remoto a otro, a continuación se muestra el procedimiento para hacer esto en Github

### 1. Encontrar el repositorio original

Primero buscamos en Github el repositorio del cual queremos hacer un Fork, en este caso se utilizará el repositorio de Manim, el motor de animaciones creado  por 3Blue1Brown

[![image alt text]({attach}images/git-guide-with-visual-interface/image_1-thumbnail.png){: width=2000 .gallery .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_1.png }](/blog/images/git-guide-with-visual-interface/image_1.png ){.gallery}

Como se puede ver en la imagen, el creador del repositorio es 3b1b y el usuario logeado actualmente es ELC por lo que el repositorio no es propio.

### 2. Realizar el Fork

Para hacer un fork, basta con hacer clic en el botón Fork en la parte superior

[![image alt text]({attach}images/git-guide-with-visual-interface/image_2-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_2.png }](/blog/images/git-guide-with-visual-interface/image_2.png ){.gallery}

Inmediatamente después, GitHub nos redireccionará a una pantalla que nos indica que se está creando el Fork

[![image alt text]({attach}images/git-guide-with-visual-interface/image_3-thumbnail.png){: width=2000 .gallery .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_3.png }](/blog/images/git-guide-with-visual-interface/image_3.png ){.gallery}

Una vez finalizado el proceso, se creará un repositorio homónimo en la cuenta logeada

[![image alt text]({attach}images/git-guide-with-visual-interface/image_4-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_4.png }](/blog/images/git-guide-with-visual-interface/image_4.png ){.gallery}

Como se puede ver en la imagen anterior, ahora el repositorio pertenece a ELC, con una pequeña leyenda debajo que indica que el repositorio es un Fork. Una muestra de que este repositorio es independiente y pertenece a la cuenta logeada es que aparece una nueva sección "Settings" que de otra forma no aparecería 

**NOTA:**  Esta sección podría aparecer si uno fuera colaborador del repositorio, sin embargo esa característica puede variar de proveedor en proveedor y no se detallará en esta guía.

Una última confirmación podría ser el conteo de Forks que es un número común para todos los Forks.

A partir de ahora el avance de este nuevo repositorio puede ser completamente independiente del original.

**IMPORTANTE:** ¿Cúal es la diferencia entre hacer un fork y crear un repositorio idéntico con los mismos archivos? Al realizar un Fork uno tiene una historia de commits compartida con el repositorio original, de forma tal que es posible combinar cambios nuevos del original a cualquiera de los Forks (merge) y de los Forks de nuevo al original (Pull Request).

El procedimiento alternativo de crear un repositorio desde cero así como clonarno desde GitKraken se detalla en la siguiente sección

## Clonar un repositorio

El enfoque más tradicional es crear primeramente el repositorio en el servidor remoto (Github o similar) y luego clonarlo. En este caso vamos a crear un repositorio llamado "gitkraken-tutorial" en Github.

### 1. Crear un repositorio

Esto puede hacerse desde la página principal de Github

[![image alt text]({attach}images/git-guide-with-visual-interface/image_5-thumbnail.png){: width=2000 .gallery .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_5.png }](/blog/images/git-guide-with-visual-interface/image_5.png ){.gallery}

### 1 (Alternativa). Crear un repositorio

O desde la sección de repositorios

[![image alt text]({attach}images/git-guide-with-visual-interface/image_6-thumbnail.png){: width=2000 .gallery .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_6.png }](/blog/images/git-guide-with-visual-interface/image_6.png ){.gallery}

### 2. Completar la información necesaria

**IMPORTANTE:** Para poder clonar nuestro repositorio debe estar "Inicializado" por lo tanto, es indispensable tildar la opción “Initialize this repository with a README”. Las opciones de gitignore permiten a git ignorar ciertos archivos (archivos temporales, caches, etc.) y la licencia permite elegir una licencia estándar entre un listado.

[![image alt text]({attach}images/git-guide-with-visual-interface/image_7-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_7.png }](/blog/images/git-guide-with-visual-interface/image_7.png ){.gallery}

### 3. Obtener URL del Repositorio

Para poder clonar el repositorio desde GitKraken pueden utilizarse dos perspectivas:

1. Vincular la cuenta de GitHub con la de Gitkraken
1. Utilizar la URL del repositorio

Todos los servicios de repositorios tienen una URL pública así que se tomará este enfoque por ser el más universal. Una vez seguido los pasos en las imágenes, la URL quedará copiada en el portapapeles.

[![image alt text]({attach}images/git-guide-with-visual-interface/image_8-thumbnail.png){: width=2000 .gallery .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_8.png }](/blog/images/git-guide-with-visual-interface/image_8.png ){.gallery}

[![image alt text]({attach}images/git-guide-with-visual-interface/image_9-thumbnail.png){: width=2000 .gallery .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_9.png }](/blog/images/git-guide-with-visual-interface/image_9.png ){.gallery}

### 4. Abrimos la ventana de Clone dentro del GitKraken

En el menú File, Seleccionar la opción "Clone Repo"

[![image alt text]({attach}images/git-guide-with-visual-interface/image_10-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_10.png }](/blog/images/git-guide-with-visual-interface/image_10.png ){.gallery}

### 4 (Alternativa 1). Abrimos la ventana de Clone dentro del GitKraken

En todo momento, se puede utilizar el botón que se encuentra en la esquina superior izquierda

[![image alt text]({attach}images/git-guide-with-visual-interface/image_11-thumbnail.png){: width=2000 .gallery .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_11.png }](/blog/images/git-guide-with-visual-interface/image_11.png ){.gallery}

A continuación, se deberá escoger la opción Clone

[![image alt text]({attach}images/git-guide-with-visual-interface/image_12-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_12.png }](/blog/images/git-guide-with-visual-interface/image_12.png ){.gallery}

### 4 (Alternativa 2). Abrimos la ventana de Clone dentro del GitKraken

En caso de no tener ningún repositorio abierto, puede accederse al menú directamente desde la pantalla de inicio

[![image alt text]({attach}images/git-guide-with-visual-interface/image_13-thumbnail.png){: width=2000 .gallery .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_13.png }](/blog/images/git-guide-with-visual-interface/image_13.png ){.gallery}

### 5. Pegamos la URL

Adicionalmente se puede detallar la ruta donde se clonará el repositorio y así como cambiar el nombre de la carpeta destino. Es recomendable tener una carpeta "Repositories" y clonar todos los repositorios allí.

[![image alt text]({attach}images/git-guide-with-visual-interface/image_14-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_14.png }](/blog/images/git-guide-with-visual-interface/image_14.png ){.gallery}

### 5. Notificación de Éxito

Una vez clonado el repositorio deberá aparecer en la parte superior una notificación que detalla que la operación fue exitosa. Uno puede utilizar el botón "Open Now" para abrir el repositorio inmediatamente. En este caso no se hará para ilustrar como se abre un repositorio desde cero.

[![image alt text]({attach}images/git-guide-with-visual-interface/image_15-thumbnail.png){: width=2000 .gallery .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_15.png }](/blog/images/git-guide-with-visual-interface/image_15.png ){.gallery}

## Abrir un repositorio

Una vez clonado el repositorio es necesario abrirlo para empezar a trabajar.

**NOTA:** El repositorio podría haber sido inicializado en lugar de clonado pero este escenario es poco probable ya que luego se debería realizar una vinculación con el repositorio remoto. Por lo que por lo general se utiliza el enfoque planteado al principio, la inicialización de repositorios queda fuera del alcance de esta guía.

### 1. Ventana de Open

En el menú File, seleccionar la opción "Open Repo"

[![image alt text]({attach}images/git-guide-with-visual-interface/image_16-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_16.png }](/blog/images/git-guide-with-visual-interface/image_16.png ){.gallery}

### 1 (Alternativa 1). Ventana de Open

Adicionalmente puede utilizarse el ícono de la esquina superior izquierda

[![image alt text]({attach}images/git-guide-with-visual-interface/image_17-thumbnail.png){: width=2000 .gallery .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_17.png }](/blog/images/git-guide-with-visual-interface/image_17.png ){.gallery}

### 1 (Alternativa 2). Ventana de Open

En caso de no tener ningún repositorio abierto, puede utilizarse el botón de la pantalla de inicio.

[![image alt text]({attach}images/git-guide-with-visual-interface/image_18-thumbnail.png){: width=2000 .gallery .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_18.png }](/blog/images/git-guide-with-visual-interface/image_18.png ){.gallery}

### 2. Seleccionar el repositorio

Se seleccionar "Open a Repository"

[![image alt text]({attach}images/git-guide-with-visual-interface/image_19-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_19.png }](/blog/images/git-guide-with-visual-interface/image_19.png ){.gallery}

### 3. Seleccionar la carpeta

Navegar hasta la carpeta donde se encuentra el repositorio, una manera fácil de identificarla es que debería verse una carpeta llamada ".git" (Esta carpeta puede no aparecer si uno no tiene habilitados los archivos ocultos de Windows).

[![image alt text]({attach}images/git-guide-with-visual-interface/image_20-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_20.png }](/blog/images/git-guide-with-visual-interface/image_20.png ){.gallery}

## Elementos de la interfaz

### Interfaz básica

Al abrir un repositorio nos encontraremos con la interfaz básica

[![image alt text]({attach}images/git-guide-with-visual-interface/image_21-thumbnail.png){: width=2000 .gallery .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_21.png }](/blog/images/git-guide-with-visual-interface/image_21.png ){.gallery}

### Arbol de Commits y Branches

Al tener varios commits y branches, en la parte central, es posible ver las bifurcaciones y las uniones, en la siguiente imagen se muestra un proyecto con varios branches (Sólo a modo de ejemplo).

[![image alt text]({attach}images/git-guide-with-visual-interface/image_22-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_22.png }](/blog/images/git-guide-with-visual-interface/image_22.png ){.gallery}

## Añadir Cambios

Las herramientas de git pueden separarse en dos categorías:

- Integradas con los IDE
- Desacopladas

Muchos IDE vienen con su propia integración con Git, algunos ejemplos de esto son Eclipse, Visual Studio, PyCharm. Sin embargo, es posible utilizar aplicaciones completamente desacopladas como Gitkraken, Github Desktop o el mismo git de consola.

Las primeras tienen la ventaja de que el usuario no tiene que salir de la aplicación en la que desarrolla el código y las pruebas, pero tiene la desventaja de que puede confundir fácilmente cual es su branch actual y si el sistema está en un estado consistente, además, cada IDE tendrá su interfaz especial, y los IDE suelen cambiar si se cambia el lenguaje de programación. Por otro lado, las herramientas desacopladas como Gitkraken permiten que el desarrollador utilice el IDE sólo para lo que fue diseñado, la programación, la depuración y las pruebas, abstrayéndose totalmente del sistema de control de versiones, este enfoque tiene como ventaja que el usuario sólo debe preocuparse por el control de versiones al comenzar a trabajar y al momento de hacer los Stage-Commit y que se utiliza la misma interfaz independientemente de que IDE se haya utilizado, pero trae como desventaja que debe contarse con otro software adicional instalado.

Gracias a que Gitkraken tiene este enfoque es posible trabajar como se suele hacer habitualmente en el IDE tradicional y cuando se deseen añadir cambios al repositorio lo que aparecerá será algo como lo siguiente:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_23-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_23.png }](/blog/images/git-guide-with-visual-interface/image_23.png ){.gallery}

La sigla WIP (Work in Progress) hace referencia al Working Area. Al hacer clic en este recuadro se podrá ver en la parte derecha los cambios realizados separados por archivos y también una clara división entre la Working Area y la Staging Area.

[![image alt text]({attach}images/git-guide-with-visual-interface/image_24-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_24.png }](/blog/images/git-guide-with-visual-interface/image_24.png ){.gallery}

Asimismo, es importante aclarar la función de tres botones:

- Cesto de basura en la esquina superior derecha: BORRA todos los cambios del Working Area, usar sólo si se sabe lo que se está haciendo
- Tree: Permite visualizar los archivos en forma de árbol de directorios, dependiendo de la configuración puede no estar seleccionado por defecto, se recomienda utilizarlo
- Stage Files/changes to commit: Genera un commit con el título y la descripción dados de todos los cambios que están en el Staging Area

[![image alt text]({attach}images/git-guide-with-visual-interface/image_25.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_25.png }](/blog/images/git-guide-with-visual-interface/image_25.png ){.gallery}

[![image alt text]({attach}images/git-guide-with-visual-interface/image_26.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_26.png }](/blog/images/git-guide-with-visual-interface/image_26.png ){.gallery}


Si uno hace clic sobre alguno de los archivos ya sea dentro del Working como del Staging Area, puede ver un detalle de los cambios:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_27-thumbnail.png){: width=2000 .gallery .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_27.png }](/blog/images/git-guide-with-visual-interface/image_27.png ){.gallery}

Cada línea sombreada con rojo implica que esa línea estaba en la última versión y será eliminada, las sombreadas con verde indican que no estaban en la última versión y serán añadidas. En Git no existe el concepto de modificar una línea por lo tanto si se hace una modificación, se borrará la línea de la versión anterior y se añadirá una idéntica pero con los cambios realizados.

Si uno posiciona el mouse sobre una de esas líneas aparecerá un botón con un signo más (+) que nos permitirá mover líneas individuales al Staging Area:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_28-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_28.png }](/blog/images/git-guide-with-visual-interface/image_28.png ){.gallery}

Gitkraken, a su vez, identifica cambios por secciones en archivos y permite agregar varias secciones al Staging Area

[![image alt text]({attach}images/git-guide-with-visual-interface/image_29-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_29.png }](/blog/images/git-guide-with-visual-interface/image_29.png ){.gallery}

Por último, si uno desea añadir todos los cambios de un archivo al Staging Area, puede posicionar el cursor sobre ese archivo y utilizar el botón "Stage File" que aparecerá. También es posible pasar TODOS los archivos del Working Area al Staging Area con el botón “Stage all Changes”:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_30-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_30.png }](/blog/images/git-guide-with-visual-interface/image_30.png ){.gallery}

El proceso para quitar cambios del Staging Area y pasarlos al Working Area es idéntico, sólo se debe seleccionar primeramente el archivo correspondiente desde el Staging Area, en este caso los botones son de color rojo y el botón con el más (+) pasa a ser un menos (-):

[![image alt text]({attach}images/git-guide-with-visual-interface/image_31-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_31.png }](/blog/images/git-guide-with-visual-interface/image_31.png ){.gallery}
[![image alt text]({attach}images/git-guide-with-visual-interface/image_32-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_32.png }](/blog/images/git-guide-with-visual-interface/image_32.png ){.gallery}
[![image alt text]({attach}images/git-guide-with-visual-interface/image_33-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_33.png }](/blog/images/git-guide-with-visual-interface/image_33.png ){.gallery}

Una vez movidos l](ith-visual-interface/image_33.png }

Una vez movidos)os cambios deseados al Staging Area, se puede crear el commit deseado, para ello hace falta asignarle un título, también se puede detallar una descripción opcional:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_34-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_34.png }](/blog/images/git-guide-with-visual-interface/image_34.png ){.gallery}

Una vez hecho el commit, aparecerá en la pantalla principal con el nombre que se le haya asignado:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_35-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_35.png }](/blog/images/git-guide-with-visual-interface/image_35.png ){.gallery}

Es importante descatar que esto genera el commit en el repositorio LOCAL y que estos cambios no impactaron aún en el repositorio remoto, Gitkraken nos muestra esto utilizando una computadora para el repositorio Local y el logo del usuario de Github para representar el repositorio remoto. En la siguiente sección se verá como sincronizar ambos repositorios.

## Sincronización con repositorios remotos

Como se mencionó antes, para mantener dos repositorios actualizados hace falta utilizar las acciones de Pull y Push

### Descargar los cambios del repositorio remoto

Es considerado una buena práctica, siempre antes de subir los cambios, hacer un Pull para traer cualquier cambio que no pudiéramos tener en nuestro equipo local. En esta oportunidad tendremos que distinguir entre la acción Pull y la acción Fetch.

- Fetch: Revisa si hay cambios en el repositorio remoto y nos muestra cual es el estado del remoto con respecto al local
- Pull: Hace Fetch y aplica esos cambios en el repositorio local.

Fetch es por lo tanto una acción completamente segura, mientras que Pull puede traer cambios que generen colisiones con los nuestros, a pesar de que lo anterior no sea frecuente y sólo sea posible en entornos con múltiples usuarios, es considerado una buena práctica que el usuario resuelva los conflictos en su computadora local y que luego pueda subir los cambios. De no ser así, el repositorio remoto podría quedar en un estado inconsistente, deteniendo el avance de los demás miembros del equipo.

En la barra de acciones del Gitkraken tenemos la acción de Fetch:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_36-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_36.png }](/blog/images/git-guide-with-visual-interface/image_36.png ){.gallery}

Para acceder a la acción Pull debemos elegir la flecha que está junto a Fetch:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_37-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_37.png }](/blog/images/git-guide-with-visual-interface/image_37.png ){.gallery}

[![image alt text]({attach}images/git-guide-with-visual-interface/image_38-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_38.png }](/blog/images/git-guide-with-visual-interface/image_38.png ){.gallery}

En el caso del repositorio de ejemplo el Pull debería ser exitoso ya que no hubo cambios en el repositorio remoto

### Subir los cambios al repositorio remoto

Para subir los cambios es necesario primero realizar un Pull para resolver los conflictos (si los hubiera) una vez resueltos, se puede realizar un Push utilizando el botón asociado en la barra de acciones:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_39-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_39.png }](/blog/images/git-guide-with-visual-interface/image_39.png ){.gallery}

Una vez realizado, la forma más fácil de verificar que fue exitoso se ver el árbol de commits

[![image alt text]({attach}images/git-guide-with-visual-interface/image_40-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_40.png }](/blog/images/git-guide-with-visual-interface/image_40.png ){.gallery}

En esta oportunidad tanto el logo de usuario de Github como la computadora se encuentran juntos, mostrando así que el contenido se encuentra sincronizado.

### Ejemplo de Fetch y Pull

Para ilustrar como se vería una situación inversa (se hicieron cambios en el repositorio remoto y queremos descargarlos). Primeramente hacemos Fetch y veremos algo como lo siguiente:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_41-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_41.png }](/blog/images/git-guide-with-visual-interface/image_41.png ){.gallery}

Como se puede ver, el branch master está "adelantado" y tiene un commit llamado “Update README.md” que sólo está en el repositorio remoto (evidenciado por el logo de la cuenta de Github). Y nuestra versión local está “detrás”. En esta situación debemos evaluar los cambios y si existen conflictos (incluyendo los archivos del Working Area).  Es recomendable no tener nada en el Working Area al momento de hacer Pull, es decir, que todos los cambios ya estén dentro de commits, esto simplifica el proceso y disminuye la probabilidad de hallar conflictos. 

**NOTA:**  Existen situaciones avanzadas donde uno puede guardar temporalmente los cambios del Working Area en un Stash pero esta característica se encuentra fuera del alcance de esta guía.

En caso de no existir conflictos, se puede realizar un Pull sin problemas:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_42-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_42.png }](/blog/images/git-guide-with-visual-interface/image_42.png ){.gallery}

El resultado es el esperado, tanto el repositorio local como el remoto se encuentran sincronizados.

## Trabajo en múltiples branches

Una vez que se pueda trabajar eficientemente en una rama, es sumamente recomendable seleccionar una Git Strategy y utilizar múltiples ramas.

### Crear Branch

Para crear rama primero debemos posicionarnos en una rama base, esta es la rama de la cual se bifurcará el nuevo branch 

**NOTA:**  Existe el concepto de ramas huérfanas, que son ramas que no se derivan de ninguna otra rama. Sin embargo su uso suele ser muy particular y específico y por ende están fuera del alcance de esta guía.

En este caso vamos a crear una rama de master, le agregaremos dos commits, la uniremos y luego la borraremos.

En primer lugar nos posicionamos en master, para ello bastan con hacer doble clic en "master"

[![image alt text]({attach}images/git-guide-with-visual-interface/image_43-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_43.png }](/blog/images/git-guide-with-visual-interface/image_43.png ){.gallery}

Luego utilizamos el botón "Branch" de la barra de acciones

[![image alt text]({attach}images/git-guide-with-visual-interface/image_44-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_44.png }](/blog/images/git-guide-with-visual-interface/image_44.png ){.gallery}

Luego escribimos el nombre de la rama y presionamos enter:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_45-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_45.png }](/blog/images/git-guide-with-visual-interface/image_45.png ){.gallery}

Gitkraken nos permite ver en varios lugares que la rama fue creada con éxito

[![image alt text]({attach}images/git-guide-with-visual-interface/image_46-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_46.png }](/blog/images/git-guide-with-visual-interface/image_46.png ){.gallery}

Sin embargo, es posible observar que en el árbol de commits no aparece la rama master, esto se debe a que se encuentra oculta en el ícono +1:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_47-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_47.png }](/blog/images/git-guide-with-visual-interface/image_47.png ){.gallery}

Al pasar el cursor por arriba podemos ver que la rama es visible nuevamente:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_48-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_48.png }](/blog/images/git-guide-with-visual-interface/image_48.png ){.gallery}

Esta simplificación de la intefaz se debe a que el contenido de ambas ramas es idéntico (todavía no realizamos cambios) y si bien puede ser un poco confusos para los principiantes es sumamente útil cuando se tienen múltiples ramas. Por otro lado, la ayuda visual de GitKraken nos permite observar que el branch "add-license" sólo existe en el contexto local y que aún no existe en el repositorio remoto.

### Unir Branches (Merge)

Para poder unir dos branches es necesario que éstas sean diferentes, para ello se añaden algunos commits a la rama "add-license". Luego de añadir los commits, se obtiene algo como lo siguiente:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_49-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_49.png }](/blog/images/git-guide-with-visual-interface/image_49.png ){.gallery}

Si bien la rama sigue existiendo sólo en el contexto local, es importante ver como se encuentra "adelantada" a la rama master. Si bien en el esquema presentado al principio las ramas se disponen de forma paralela una a la otra, Gitkraken sólo las dispone de esa forma cuando existen varias “líneas de cambios”, es decir, sólo cuando la rama master se haya modificado y que esa modificación no sea alguno de los commits de la rama con la que está alineada (add-license) en este caso. Para ilustrar este ejemplo se añadirá un cambio a la rama master directamente (no en la rama add-license).

[![image alt text]({attach}images/git-guide-with-visual-interface/image_50-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_50.png }](/blog/images/git-guide-with-visual-interface/image_50.png ){.gallery}

Esta forma de visualizar las ramas es más similar a la vista con anterioridad, la vista cambió porque se agregó el commit "Add Contribution Guide" directamente en master.

Antes de unir las ramas vamos a realizar un Push, en este caso, como la rama no existe en el repositorio remoto, nos preguntará si la queremos vincular con alguna rama del repositorio remoto ya existente, en caso de dejar el espacio en blanco y clickear en "Submit", creará una rama homónima en el repositorio remoto.

[![image alt text]({attach}images/git-guide-with-visual-interface/image_51-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_51.png }](/blog/images/git-guide-with-visual-interface/image_51.png ){.gallery}

Ahora ambas ramas están sincronizadas con el repositorio remoto:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_52-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_52.png }](/blog/images/git-guide-with-visual-interface/image_52.png ){.gallery}

Si bien no era necesario hacer un Push de la rama antes de unirla, es considerado una buena práctica para que quede público el historial de cambios y que los demás usuarios puedan visualizar quien, y como hizo los cambios.

Para unir las ramas (merge) Uno debe hacer clic en el nombre de la rama origen y arrastrar y soltar en el nombre de la rama destino, esto desplegará el siguiente menú, donde seleccionamos la opción de Merge.

[![image alt text]({attach}images/git-guide-with-visual-interface/image_53-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_53.png }](/blog/images/git-guide-with-visual-interface/image_53.png ){.gallery}

[![image alt text]({attach}images/git-guide-with-visual-interface/image_54-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_54.png }](/blog/images/git-guide-with-visual-interface/image_54.png ){.gallery}

Una vez elegida la opción, el árbol de commits y branches se verá similar al siguiente:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_55-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_55.png }](/blog/images/git-guide-with-visual-interface/image_55.png ){.gallery}

Como puede verse el merge fue exitoso, sin embargo aún no se verá reflejado en el repositorio remoto, por lo tanto, es necesario activar el repositorio master (haciendo doble click en el nombre) y luego hacer un Push.

[![image alt text]({attach}images/git-guide-with-visual-interface/image_56-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_56.png }](/blog/images/git-guide-with-visual-interface/image_56.png ){.gallery}

Una vez hecho el Push, tanto las ramas como la operación de Merge se encuentran sincronizadas en el repositorio remoto y local

### Borrar Branch

A lo largo de la vida de un proyecto de desarrollo pueden crearse infinidad de ramas, por lo tanto, para mantener la interfaz limpia, es una buena práctica eliminar las ramas luego de que se unieron (merge) a master (o a la rama que corresponda según el Git Workflow establecido)

Para eliminar una rama basta con hacer clic derecho sobre el nombre y seleccionamos la opción que la elimina tanto del repositorio local como del remoto

[![image alt text]({attach}images/git-guide-with-visual-interface/image_57-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_57.png }](/blog/images/git-guide-with-visual-interface/image_57.png ){.gallery}

GitKraken nos advertirá que esta es una operación destructiva y que no puede deshacerse, seleccionamos Delete

[![image alt text]({attach}images/git-guide-with-visual-interface/image_58-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_58.png }](/blog/images/git-guide-with-visual-interface/image_58.png ){.gallery}

Una vez que la rama se haya eliminado exitosamente el árbol de commits y branches se verá similar al siguiente:

[![image alt text]({attach}images/git-guide-with-visual-interface/image_59-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_59.png }](/blog/images/git-guide-with-visual-interface/image_59.png ){.gallery}

Como puede verse, ya no existe la rama borrada ni en el repositorio local ni en el remoto, sin embargo, y es en esto donde está la utilidad, puede verse como claramente alguna vez existió y consistió en dos commits que luego fueron unidos al master. La ventaja de esta funcionalidad es que uno puede eliminar las ramas y no perder la historia de lo que se hizo, teniendo una separación en los commits que permite fácilmente rastrear quien hizo que cambios y como fueron hechos. Esto no sería posible (o mejor dicho, sería muchísimo más complejo) si sólo se trabajara con la rama master.

## Pull Requests

En un entorno de desarrollo, es poco común que los desarrolladores realicen merge a master directamente, es por eso que se utiliza un mecanismo de aprobación y revisión antes de que se puedan realizar los merge en las ramas críticas. Cada proveedor llama a ese proceso de manera distinta, en el más popular (Github) ese proceso se llama Pull Request.

Una Pull Request es básicamente decir lo siguiente: Tengo cambios hechos y quisiera unirlos a esta rama. Es una práctica común en las ramas más críticas dentro de proyectos de desarrollo, donde a la persona encargada de esas revisiones y aprobaciones se la suele llamar Release Manager y también es sumamente popular en los proyectos Open Source, donde se tiene el repositorio principal y las personas que quieran contribuir, al no tener permisos de editar el repositorio directamente, pueden realizar Pull Requests. El creador del repositorio podrá, luego, aceptarlas o rechazarlas.

Si bien las Pull Requests suelen hacerse mediante la interfaz del proveedor (Github en este caso). Son posibles hacerlas desde GitKraken también.

Sólo con fines ilustrativos se muestra el procedimiento:

1. Se hace clic derecho en la rama desde la cual se quiere hacer la Pull Request
1. Se selecciona la opción de la Pull Request
1. Se completan los campos solicitados

[![image alt text]({attach}images/git-guide-with-visual-interface/image_60-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_60.png }](/blog/images/git-guide-with-visual-interface/image_60.png ){.gallery}

[![image alt text]({attach}images/git-guide-with-visual-interface/image_61-thumbnail.png){: .narrow .b-lazy data-src=/blog/images/git-guide-with-visual-interface/image_61.png }](/blog/images/git-guide-with-visual-interface/image_61.png ){.gallery}

**NOTA:**  Las Pull Requests generalmente se deben realizar de una manera específica que se detalla en el mismo repositorio del software al que uno quiere contribuir por lo que el ejemplo mostrado es trivial, sólo para tener una noción de cómo sería el procedimiento.

## Características Adicionales

Aparte de todo lo mencionado en esta guía, queda aún mucho terreno para explorar tanto en lo que permite Git como en lo que se puede hacer con GitKraken, a continuación se listan algunas de estas posibilidades para que el lector pueda indagar en mayor detalle si lo desea

- Tener repositorios dentro de repositorios. Buscar: **Submodules** y** Subtree**
- Aplicar sólo un commit de una rama a otra y no hacer una unión de historial. Buscar: **Cherry Pick Commit**
- Tener ramas completamente independientes de otras: Buscar: **Orphan Branch**
- Unificar ramas olvidando la historia. Buscar: **Rebase**
- Agregar contenidos a un commit anterior. Buscar: **Amend**
- Deshacer varios commits conservando los cambios. Buscar: **Soft Reset**
- Forzar cambios en el repositorio remoto. Buscar: **Push Force**
- Es posible revertir cambios de un commit específico. Buscar: **Revert**
- Guardar en un espacio temporal los cambios del Working Area. Buscar: **Stash**
- Crear etiquetas para identificar versiones específicas de todo el repositorio cuando se encuentra en un estado consistente (linea base). Buscar: **Tags**

Algunas de las características mencionadas sólo pueden realizarse desde la consola, es decir, no son soportadas completamente en GitKraken
