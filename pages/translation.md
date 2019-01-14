Title: Translate
Slug: translate
Lang: en
order: 6
status: hidden

Translation is one way you can help and contribute to this project, this is a short tutorial of how you can do it

1. Create an free account in [crowdin](https://crowdin.com)
1. Enter in [this project inside crowdin](https://crwd.in/elc-web)
1. Select the language you want to translate into
1. Read the important section below
1. Happy translating

## Important!

## Translating Pages

The header of each file is like the following:

    Title: About
    Slug: about
    Lang: en
    order:1

This text is crucial to Pelican, the static site generator behind this website, so in order to translate this you have to follow this template

    Title: <- Translated Title ->
    Slug: about <- DO NOT CHANGE ->
    Lang: es <- Two letter code of your lang (es, de, fr) ->
    Translator: <- Your Name Here ->
    Translation: True <- You have to add this line->
    order:1 <- DO NOT CHANGE ->

## Translating Articles

The header of each file is like the following:

    Title: Haskell pattern matching in Python
    Date: 2018-02-18
    Category: Programming
    Tags: Haskell, Python, Tuple Unpacking
    Slug: haskell-pattern-matching-in-python
    Authors: Ezequiel Castaño
    Lang: en
    level: Begginer

This text is crucial to Pelican, the static site generator behind this website, so in order to translate this you have to follow this template

    Title: <- Translated Title ->
    Date: 2018-02-18 <- DO NOT CHANGE ->
    Category: Programming <- DO NOT CHANGE ->
    Tags: Haskell, Python, Tuple Unpacking <- DO NOT CHANGE ->
    Slug: haskell-pattern-matching-in-python <- DO NOT CHANGE ->
    Authors: Ezequiel Castaño <- DO NOT CHANGE ->
    Lang: <- Two letter code of your lang (es, de, fr) ->
    Translator: <- Your Name Here ->
    Translation: True <- You have to add this line->
    level: <- Translated Level ->
