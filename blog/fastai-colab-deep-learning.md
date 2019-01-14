Title: Deep Learning With Free GPU (Fastai + Colab)
Date: 2018-09-28
Category: Programming
Tags: Python, fastai, deep-learning
Slug: fastai-colab-deep-learning
Authors: Ezequiel Castaño
Lang: en
level: Begginer
jupyternotebook: https://gist.github.com/ELC/756040fe84a8bb3d14c59b0e997c84e9

Nowadays there are lots of tutorials and material to learn Artificial Inteligence, Machine Learning and Deep Learning but whenever you want to do something interesting you notice you need a Nvidia GPU. In this tutorial we are going to solve this issue with a free cloud solution.

<!-- PELICAN_END_SUMMARY -->

**WARNING: The fastai framework is migrating because of the release of PyTorch 1.0. The content of this notebook will be updated but the code might not work until the version 1.x of fastai has clear instructions about its installation.**

First of all I'm going to introduce some definitions and concepts just for those that are not familiar with these topics. If you just want to  jump directly to the tutorialn, scroll down to the [tutorial section](#tutorial)

## Introduction

More often than not I find people who are confused about the relationship of the terms "Artificial Inteligence", "Machine Learning" and "Deep Learning". Let's try to explain it a bit (no rigorous math!). Artificial Inteligence is the broad term, lots of areas fall into this category for example, neural networks, computer vision, natural language, chatbots, sentiment analisis, etc. When people used Machine Learning they refer to more "statistical" methods such as Support Vector Machines (SVMs), Classification Trees, K-Means, Mean-Shift, etc. Another are is Deep Learning which is the narrower of all since it focuses just in one topic artificial neural networks, there are several type of neural networks and when they have several "hidden layers" we are talking about "Deep" Learning.

If you want to know more about which are the fields of Computer Science, I suggest you to watch [Map of Computer Science by Domain of Science](https://www.youtube.com/watch?v=SzJ46YA_RaA)

One of the most common libraries to solve Machine Learning Problems is Scikit-Learn and they provide a beautiful roadmap to understand which algorithms are inside this field and their categorizations (there may be much more but it's enough for an introduction):

[![Scikit-Learn Roadmap]({attach}images/sklearn-roadmap-thumbnail.png){: .b-lazy width=2122 data-src=/blog/images/sklearn-roadmap.png }](/blog/images/sklearn-roadmap.png){: .gallery }

Simirlarly there is a beautiful image which shows all the types of neural networks, along with [a medium post](https://towardsdatascience.com/the-mostly-complete-chart-of-neural-networks-explained-3fb6f2367464) explaining them.

[![Scikit-Learn Roadmap]({attach}images/neural-networks-types-thumbnail.png){: .b-lazy width=2000 data-src=/blog/images/neural-networks-types.png }](/blog/images/neural-networks-types.png){: .gallery }

## The problem

Generally, when talking about computers, the more you want to scale and parallelize, the simpler the algorithm should be. Complex algorithms are slow and don't usually scale well, this is why nowadays there is a lot of hype arround AI. Artificial Neural Nets were first proposed in 1943! Why nobody used them until now? Because although they are simple, they need lots of computations and CPUs aren't that good at that, they have to perform logic operation, memory management and many other things. But GPUs on the other hand were created primarily for aritmetic calculations and it is today that we have GPUs that powerful that Deep Learning and Machine Learning are indeed possible in a reasonable amount of time. Other things influenced too of course, such as cloud services, fast disks and lots of research.

This is why according to the Gartner Hype Cycle Deep Learning is at its peak:

[![Gartnet Cycle]({attach}images/gartnet-2017-thumbnail.jpg){: .b-lazy width=1385 data-src=/blog/images/gartnet-2017.jpg }](/blog/images/gartnet-2017.jpg){: .gallery }

So, just buy a GPU and you will be ready for Deep learning! Not so fast, frameworks and libraries work better on GPUs, but those should be Nvidia and support CUDA and cuDNN which is another requirement many won't meet. Additionally, the GPU is generally (unless you are building a server), the most expensive part of a PC System.

This is why finding a way to experiment with deep learning may not be free. There are several cloud based services where you can rent a GPU for hour and even seconds and they are pretty cheap, but if you just want to try without paying, those might not be a suitable option. This is where [Colaboratory](https://colab.research.google.com/) comes in, it's a service offered by Google which provides free GPU (up to 12 GB of Video RAM) for your computations, it also supports colaboratory editing (like Google Docs) and it can be saved in Google Drive or Github.

## Tools and requirements

Developing software implies learning a programming language, usually a framework, learn arquitecture patterns, best practices and of course a lot more. But AI goes in another direction, it is math heavy (although you can build amazing stuff with high school algebra), it realies in a predifined set of algorithms and the cutting edge news usually comes in the form of a scientific paper rather than a fancy framework. Because of this, two different roles emerged, in one hand, there is the Software Developer and in the other hand there is the Data Scientist, both know data structures, algorithms, programming but their skillset is quite different. We will see which tools you will need to start digging in AI and Deep Learning.

First you will need to learn programming basics, control flow structures and decisions, it isn't needed to know OOP or Functional programming although it might be useful for some. Second, you will need to know Python, it is the most used language in the field and it seems it will continue like that and third you will need to feel confortable with a new "environment" called notebooks, particularly Jupyter Notebooks. I know some might disagree, specially in the last point, there are lots of opinions and I strongly believe that if you learn these things you will be able to watch most of video-tutorials on youtube and you will be on track without issues. You can convice yourselves looking at this survey, based on 10.153 responses:

[![data-science-tools]({attach}images/data-science-tools-thumbnail.png){: .narrow .b-lazy width=601 data-src=/blog/images/data-science-tools.png  }](/blog/images/data-science-tools.png){: .gallery }

Once you know this prerequirements, you will face a very common dilemma, which Deep Learning Framework should you use? Using a framework is recommended (although doing it manually help a lot to understand the underlying process) so for this tutorial I chose fastai because it's built over PyTorch which is known for being the most pythonic and thus the friendlier to begginers.

## Tutorial

In case you want to see the final result, this is the final notebook:

<script src="https://gist.github.com/ELC/756040fe84a8bb3d14c59b0e997c84e9.js"></script>

Now I'm going to explain how that notebook works.

First we have to make sure GPU acceleration is enabled, to achieved this by setting "Hardware Accelerator" to GPU in the menu: `Edit > Notebook settings > set "Hardware Accelerator" to GPU`.

[![Colab Edit]({attach}images/colab-edit-thumbnail.png){: .narrow .b-lazy width=484 data-src=/blog/images/colab-edit.png }](/blog/images/colab-edit.png){: .gallery }

[![Colab GPU]({attach}images/colab-gpu-thumbnail.png){: .narrow .b-lazy width=532 data-src=/blog/images/colab-gpu.png }](/blog/images/colab-gpu.png){: .gallery }

Since Fastai is not built in Colaboratory, we have to install it manually, the best way is by source since it's in rapid development and the realeses found via pip could be outdated. Additionally we can install PyTorch 3.1 with CUDA 9.1 in the same cell.

    :::bash
    %%bash

    if ! [ -d fastai ]
    then
    git clone https://github.com/fastai/fastai.git
    fi

    cd fastai

    git pull

    pip -q install .

    pip -q install http://download.pytorch.org/whl/cu91/torch-0.3.1-cp36-cp36m-linux_x86_64.whl

    pip -q install torchvision

Now we can import fastai with all its modules

    :::python
    from fastai.imports import *
    from fastai.transforms import *
    from fastai.conv_learner import *
    from fastai.model import *
    from fastai.dataset import *
    from fastai.sgdr import *
    from fastai.plots import *

And we are ready to go! You can check that the GPU is enabled with the following command:

    :::python
    f'Is CUDA and CUDNN enabled: {torch.cuda.is_available() and torch.backends.cudnn.enabled}'

And if you want to check exactly how much Video RAM you have you can run the following snippet:

    :::python
    !ln -sf /opt/bin/nvidia-smi /usr/bin/nvidia-smi
    !pip3 -q install gputil
    !pip3 -q install psutil
    !pip3 -q install humanize

    import psutil
    import humanize
    import os
    import GPUtil as GPU

    GPUs = GPU.getGPUs()
    gpu = GPUs[0]
    process = psutil.Process(os.getpid())

    print(f"Number of GPUs: {len(GPUs)}")
    print(f"Gen RAM Free: {humanize.naturalsize( psutil.virtual_memory().available )} | Proc size: {humanize.naturalsize( process.memory_info().rss)}")
    print("GPU RAM Free: {0:.0f}MB | Used: {1:.0f}MB | Util {2:3.0f}% | Total {3:.0f}MB".format(gpu.memoryFree, gpu.memoryUsed, gpu.memoryUtil*100, gpu.memoryTotal))

## Conclusion

It is indeed possible to do Deep Learning with GPU without paying nothing, we just have to wait until the right set of technologies is available.