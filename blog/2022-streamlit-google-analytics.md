Title: Add Google Analytics (or any custom HTML) to Streamlit with Github Pages
Date: 2022-01-14
Category: Programming 
Tags: Streamlit, Python, Github Pages, Google Analytics
Slug: streamlit-google-analytics
Authors: Ezequiel Leonardo Castaño 
Lang: en 
Headerimage: https://elc.github.io/blog/images/streamlit-google-analytics/streamlit-google-analytics_headerimage.png

[![Jupyter Publishing Header Image]({static}images/streamlit-google-analytics/streamlit-google-analytics_headerimage-thumbnail.png){: .b-lazy width=1444 data-src=/blog/images/streamlit-google-analytics/streamlit-google-analytics_headerimage.png }](/blog/images/streamlit-google-analytics/streamlit-google-analytics_headerimage.png)

<!-- PELICAN_BEGIN_SUMMARY -->

Streamlit is one of the most popular libraries for creating web apps using
Python, and they also provide 
[a service](https://share.streamlit.io/){: target="_blank"} to freely host and
share your apps. One of the issues with this free sharing capability is that
one losses control over the app, for instance, it is no longer possible to
control how the precise HTML will look like or add custom
[Open Graph](https://en.wikipedia.org/wiki/Facebook_Platform#Open_Graph_protocol){: target="_blank"}
or analytics. This post shows a simple and easy way to add all of this by using
Github Pages.

<!-- PELICAN_END_SUMMARY -->

This post is one part of a three posts series regarding Streamlit, the posts
can be read in any order and the three are built around the same demo app:

- **Add Google Analytics (or any custom HTML) to Streamlit with Github Pages** (this post)
- [Multipage, State-Persistent Apps with Streamlit]({filename}./2022-streamlit-multipage.md)
- [Lessons learnt After Developing Finance Web Tools with Streamlit and Altair (No HTML/CSS/JS)]({filename}./2022-personal-finance-tools.md)

## TL;DR

This post covers how to upload a Streamlit app to the Streamlit Sharing
platform and embed it as an iframe in a custom HTML hosted in Github Pages.
This is NOT suitable for sensitive data or commercial use.

The technique used here *is a hack*, meaning it is not the best practice, but
it will get the job done. In the end, a more *robust and professional*
alternative will be mentioned for those interested.

An [example Github Repo](https://github.com/ELC/finance-tools){: target="_blank"}
is available for inspiration, there is also a 
[demo app](https://elc.github.io/finance-tools/){: target="_blank"}
attached to check the final result.

## Initial Clarification

This post assumes the Streamlit App is hosted via Streamlit Sharing since if
the app is being hosted on its own servers, there should not be a problem to add
tracking, Open Graph, or any custom HTML since one has full control over the
code and deployment. Instead, this post focuses on a purely free and managed
solution with no servers involved.

## Streamlit Sharing

Streamlit offers a free-forever Community plan for hosting and sharing an
unlimited number of public Streamlit apps, the [full plan comparison is available on their page](https://streamlit.io/cloud#plans){: target="_blank"}.
To use that free service one has to create a free account and upload all the
code to a Github Repo (Gitlab, BitBucket, and Azure DevOps only in Paid plans
at the moment).

### Deployment

To deploy a Streamlit app it is important not to have any uncommitted changes,
otherwise, streamlit will block the deployment. If all changes have been
committed (and pushed), first run the app locally, typically with:

```
streamlit run python_script.py
```

And then go to the Hamburger Menu -> "Deploy this app"

[![Deploy to Streamlit]({static}images/streamlit-google-analytics/deploy-streamlit-thumbnail.png){: .narrow .b-lazy width=500 data-src=/blog/images/streamlit-google-analytics/deploy-streamlit.png}](/blog/images/streamlit-google-analytics/deploy-streamlit.png)


This will redirect to the Streamlit Sign in Page and after logging in, the
Deployment Options will be shown, here the repository, the branch, and the file
should be specified. It is also possible to add additional parameters (and even
secrets) in the "Advanced Settings", there is a [tutorial to do this in the docs](https://docs.streamlit.io/streamlit-cloud/get-started/deploy-an-app/connect-to-data-sources/secrets-management){: target="_blank"}

[![Deploy to Streamlit]({static}images/streamlit-google-analytics/deployment-options-thumbnail.png){: .narrow .b-lazy width=500 data-src=/blog/images/streamlit-google-analytics/deployment-options.png}](/blog/images/streamlit-google-analytics/deployment-options.png)

Once the app is deployed it should be available at a URL with this format:

```
https://share.streamlit.io/GITHUB_USERNAME/REPOSITORY_NAME/MAIN_SCRIPT.py
```

That URL is completely functional but it has the drawbacks mentioned in the
introduction, namely it is not possible to:

- Add any kind of tracking/analytics
- Customize the Open Graph meta tags for social media sharing
- Add custom HTML

It is not possible however to alter the Javascript, the HTML, or the CSS of the
streamlit app itself because it is in a domain (`share.streamlit.io`) to which
no access is granted. Nevertheless, analytics and meta tags are not "visible"
content and should therefore not disrupt the typical user experience of the
app. The main goal is to provide the final user with a seamless "Streamlit
Experience" while enhancing the features on the developer's end.

## Github Pages

One advantage of Github repositories is that they come with a static webserver
directly built-in called "Github Pages". It is disabled by default, but can be
enabled by going to Settings -> Pages -> Enable. For simplicity, the master
branch will be used but other branches can be used if configured.

[![Deploy to Github Pages]({static}images/streamlit-google-analytics/github-pages-thumbnail.png){: .narrow .b-lazy width=500 data-src=/blog/images/streamlit-google-analytics/github-pages.png}](/blog/images/streamlit-google-analytics/github-pages.png)

Once enabled, the root of the repository will be served at this URL:

```
http://GITHUB_USERNAME.github.io/REPOSITORY_NAME
```

That means that an `index.html` can be added to the root of the repo and that
file will be the landing page of the URL.

A basic HTML as the following can be used for testing:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>My App</title>
  </head>
  <body>
    <h1>Hello World</h1>
  </body>
</html>
```

## Embedding Streamlit

Once both the Github Pages and the Streamlit Sharing are online, it is possible
to embed the latter in the former by using an `iframe`. The `iframe`` by
default will show the app in smaller dimensions but with some minimal CSS it is
possible to extend the `iframe` to provide the same look and feel as the
streamlit app.

Moreover, it is also possible to add Google Analytics or another custom
HTML/CSS/JS into the page, always checking it does not affect the user
experience.

The below example shows how to add the `iframe` to the boilerplate shown in the
previous section.

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>My App</title>

    <style>
    body {
      margin: 0;
    }

    iframe {
      display: block;
      background: #000;
      border: none;
      height: 100vh;
      width: 100vw;
    }
    </style>

  </head>
  <body>
    <iframe src="https://share.streamlit.io/GITHUB_USERNAME/REPOSITORY_NAME/MAIN_SCRIPT.py">
        Your browser doesn't support iframes
    </iframe>
  </body>
</html>
```

To add Google Analytics, the JS snippet can be appended after the `iframe`, do
remember to add the `google-site-verification` as meta tag:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!-- Google Verification -->
    <meta name="google-site-verification" content="GOOGLE_SITE_VERIFICATION_TOKEN" />

    <title>My App</title>

    <style>
    body {
      margin: 0;
    }

    iframe {
      display: block;
      background: #000;
      border: none;
      height: 100vh;
      width: 100vw;
    }
    </style>

  </head>
  <body>
    <iframe src="https://share.streamlit.io/GITHUB_USERNAME/REPOSITORY_NAME/MAIN_SCRIPT.py">
        Your browser doesn't support iframes
    </iframe>

    <!-- Google Analytics -->
    <script>
      window.ga = window.ga || function () {
        (ga.q = ga.q || []).push(arguments)
      };
      ga.l = +new Date;
      ga('create', 'UA_TRACKING_CODE', 'auto');
      ga('send', 'pageview');
    </script>
    <script async src='https://www.google-analytics.com/analytics.js'></script>
  </body>
</html>
```

With this last change and upon committing and pushing the Github Pages site
should show the Streamlit app seamlessly and it should also appear in the Real
Time tracking of Google Analytics.

## Bonus: Custom Domains

As an additional advantage, Github Pages allows custom domain names, which, if
using streamlit is a paid-only feature. To learn more about this feature, check
the [official docs](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site){: target="_blank"}


## Do it the right way

The steps described above can and should be considered merely a *hack* since it
is not the intended way to use the Streamlit Sharing platform.

There is indeed one other way to achieve the same, building a custom Streamlit
Component that achieves the same functionality. Streamlit Components are custom
Web Components that can extend the built-in Streamlit features, programming
those require React knowledge though and even if the result is *proper* and of
higher quality it will be more time-consuming.

If the *iframe-trick* does not work for a given use case, using Streamlit
Components is a good next step.

There is documentation about Streamlit Components in the [official Docs](https://docs.streamlit.io/library/components/create){: target="_blank"}.


## Other Alternatives

Some alternatives to the shown method could be:

1. Run a Flask server and use Jinja2 to inject the custom HTML into the served
   streamlit
1. Modify the default index.html the Streamlit library uses
1. Host the HTML/CSS/JS snippet and embed that inside Streamlit using
   `st.components.v1.iframe`

All of these are either less *elegant* or much more complex. The author
recommends either the *iframe-trick* or *custom-components*.

## Conclusion

Streamlit is one of the most popular dashboarding platforms in the Python
Ecosystem and allows to create apps with ease, Streamlit Sharing provides a
free forever hosting platform for unlimited public apps. However, it is not
possible to add analytics or custom HTML out of the box. When embedded in a
static site like a plain `index.html` and served via a free web server like
Github Pages one can add these features on top of it without issues.

An [example Github Repo](https://github.com/ELC/finance-tools){: target="_blank"} 
is available for inspiration, there is also a 
[demo app](https://elc.github.io/finance-tools/){: target="_blank"}
attached to check the final result.

## Check the Series

If you liked this post, it is highly likely that you will also like the other
in this 3 part Streamlit Series:

- **Add Google Analytics (or any custom HTML) to Streamlit with Github Pages** (this post)
- [Multipage, State-Persistent Apps with Streamlit]({filename}./2022-streamlit-multipage.md)
- [Lessons learnt After Developing Finance Web Tools with Streamlit and Altair (No HTML/CSS/JS)]({filename}./2022-personal-finance-tools.md)
