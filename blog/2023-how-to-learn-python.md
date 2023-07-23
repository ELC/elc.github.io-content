Title: ANGEL - An Oppinionated Guide on how to Learn Programming (focusing on Python) 
Date: 2023-07-22
Category: Programming
Tags: Python, learning
Slug: angel
Authors: Ezequiel Leonardo Castaño
Lang: en
Headerimage: https://elc.github.io/blog/images/streamlit-mutipage/streamlit-mutipage_headerimage.png
Status: draft

<!-- PELICAN_BEGIN_SUMMARY -->

Courses and trainings that promises fast results are on the rise nowadays,
however it is not always clear how to filter the noise of the plethora of online
resources. This is ANGEL, which stands for "ANGEL's Not a Guide to Effortlessly
Learning". The goal is to show the reader an approach towards the learning
experience in programming. Examples are specific to Python but the content could
be applied to any programming language/framework.

<!-- PELICAN_END_SUMMARY -->

This article is written in a way that may help the two potential readers, I will
use the "learner" as the protagonist, in a more impersonal way but, if you are a
learner or someone wanting to learn, YOU are the learner, if you are a teacher,
the learner represents YOUR learners. This may sound trivial, but writing for
both audiences means that they may be resources that are more oriented to
learners and other more oriented to teachers.

Programming is not an innate hability, it is a skill one has to develop. It is
not impossible to learn but [neither is it something everyone should
know](https://www.youtube.com/watch?v=EFwa5Owp0-k). This guide is a meta
analysis from a angel's point of view (pun intended), **there are no precise
resources or a specific order of topics to cover**, instead it focuses on the
learning process itself, giving some tips to avoid frustration, keep engagement
and provide a framework for progression.

There are some key ideas that should be taken into consideration while reading:

- **Ownership**: the learning process belongs to the learner, no one will be
  able to help them with "learning to learn" better than themselves. Teachers
  and mentors are of course needed but they cannot guide you the learner through
  the process of discovering how they best learn. It is important that the most
  interested person in improving the learner experience is the learner
  themselves.
- **Overshooting and Undershooting**: these come from control theory, in
  practical terms, it means that being too strict or too loose may hinder the
  learning process. It is important to understand the process, advantages and
  disadvantages, however big deviations could lead to uncharted territory and
  make things more challenging than they may be. The learner should  try new
  things, but always in a controlled way, do explore but avoid chaos.
- **Same Destination**: if one is following a roadmap to learn something, this
  does not mean that everyone will follow the same path. Diversity is ubiquous
  in learning and one should not underestimate or overestimate other learners
  just because they learn in a different way, shape or form. At the end of the
  day, with enough time and dedication everyone will reach a comparable level,
  although personal objetives may lead them to slightly different outcomes. 

The post is organized as follows:

- Learner profiles: background information and personal goals.
- Learning approaches: how content is structured and organized.
- Thinking style: how data is processed and information is generated.
- Learning material: considerations when choosing material.
- Roadmap: four stages to become a competent and independent programmer.
- Closing Thoughts: conclusions, next steps and useful resources

**SPOILER ALERT**: If you are looking for a fast guide, or a learn X in Y
minutes, this post may not be for you, there are no TL;DR, summaries or
skippable sections. This guide will only benefit those who are willing to spend
time reading it thoroughly.

## Learner Profiles

People decide to learn programming for different reason and with different
backgrounds. Understanding and adjusting expectation is important to ensure a
proper roadmap to acquire the desired knowledge.

The following sections will describe some typical learner stereotypes. They are
not accurate and definitely do not include the wide variety and diverty of
profiles but it is a fair simplification to plan and organize.

## Other Field Professional

Learners coming from finance, biology, marketing or any non-IT field, may be
interested in learning programming or Python in particular to enhance their
professional skills. They typically have specific goals in mind, such as
automating repetitive tasks, data analysis, or building applications relevant to
their domain. 

For instance, someone with stocks market background knowledge may want to learn
Python for algorithmic trading. As this [FreeCodeCamp Course with 2M
views](https://www.youtube.com/watch?v=xfzGZB4HhEE) proposes.

They usually have expertise in their fields, with little or no programming
background. They are results-oriented and do not necessarily want high quality
code, just something that will have the job done.

Python is particularly useful for those with this profile, as it can be seen in
the [PyData Conferences](https://www.youtube.com/user/PyDataTV), many
professional from non-IT fields use Python on a daily basis.

## Tinkerers

Python attracts learners who are curious and enjoy experimenting with code.
These learners may engage in personal projects, create utilities, or explore
Python's potential for creative expression. 

An example of this kind is someone who wants to learn Python to automate
something on their home using Raspberry PIs and domotics. As this [Sentdex Guide
with 500K
views](https://www.youtube.com/playlist?list=PLQVvvaa0QuDesV8WWHLLXW_avmTzHmJLv)
shows.
 
They like to learn what they are doing, however they will not deepen their
knowledge on the theory side, they usually test several solutions and look for
performance. They want to understand the code even if it is just superficially.

## Career Switchers / Levearage Seeker

These are learners who want to change their career focus, they may or may not
come from a programming background and usually look for leverage, how to
maximize returns with low/minimal effort.

An example of this kind is someone who works with a technology that feels
lock-in and wants to change their job or company by using something like Python.
As this [FreeCodeCamp Course with 40M
views](https://www.youtube.com/watch?v=rfscVS0vtbw) shows

Although not always, these people are often not confortable doing their daily
job and look for a change, some may want to spend some time but most will look
for a quick exit. They usually do not want to learn anything that will not yield
immediate benefit in interviews or a raise in their paycheck.

A typical subtype is the high school / college student who only wants to learn
what is needed to pass an exam.

## Theorists / Scholars

People with Computer Science or similar background that want (or must) learn
Python to implement algorithms, data structures and focuses a lot on code
analysis, such as time and space complexity.

An cannonical example is the college student attending and Algorithms and Data
Structures class or someone working in research on that field. As this [MIT
Course with 5M
views](https://www.youtube.com/playlist?list=PLUl4u3cNGP61Oq3tWYp6V_F-5jb5L2iHb)
demonstrates.

They have usually a narrow view about code, they focus about performance,
correctness and theoretic analysis. They do not usually care about what is
"idiomatic" or how a software project would be managed. Their focus is
maximazing any given piece of code.

## Professional Developer

They work with Python or other programming languages and have software
development interest. They see Python as another programming language that have
its uses and may provide a benefit in certain scenarios.

One example could be someone who learnt Python but want to dig deeper into
design patterns to make their code more robust. As this [Arjan's Software Design
Playlist with 250K
views](https://www.youtube.com/playlist?list=PLC0nd42SBTaNuP4iB4L6SJlMaHE71FG6N).

They have luggage from their background and usually do not adapt to Python's
"way of doing things" but their strive for quality in their code and have a
product-oriented approach.

## Learning approaches

Independently of the learner profile, courses have their own style and approach,
which may or may not be compatible with everyone. This sections discusses three
of the most typical learning approaches available online.

## Bottom-Up

This strategy start from the foundations, teaching how with a lot of building
blocks one can build something bigger.

### Pros

- It gives a solid foundation one can trust. Since the smaller pieces are
  well-understood, there are only few things that can go wrong, debugging is
  usually easier and the confidence in one's own solution is high.
- It focuses on easy-to-digest bits, so everything is well understood.
- It builds new knowledge based on previously taught material.
- Gives a feeling of continuity and progression.

### Cons

- Takes time to see tangible results. Most of the time is dedicated towards
  learning the basics and the building blocks, that means that even after a
  couple of months the learner may render their learning experience useless
  since they did not "build anything".
- One can be specially susceptible to a strong [impostor syndrome](#MISSING).
  Things like "I never built anything, I just know the building blocks" is a
  typical way of thinking for learners following this approach. This
  considerable overestimates the complexity of the problem.
- Most of the "successes" are independent parts and it is hard to see the big
  picture.
- It usually involves start from scratch, which is unrealistic as one could
  always find a similar enough example to start working from.
- Knowledge is usually fragmented and could hinder long-term retention is not
  periodically reviewed.

### Example

Most of the guides and tutorials online operate in this fashion, universities
usually follow this pattern as well, specially if they focus on research. The
cannonical example is teaching variables, then control structures, then data
structures and then solving larger problems re-using previously taught concepts.

Proponents would say "You cannot start with X unless you cover W, Y, Z in detail
first."

Detractor would say one may be "Missing the forest for the trees".

## Top-Down

This approaches focuses on "The Big Picture", make something work even if you
don't understand how fully, and then work from there.

### Pros

- It avoid excessive frustration. Specially for begineers, the errors one faces
  are usually trivial, some syntax errors, wrong operators and such. In this
  approach one generally starts with a known solution so these types of errors
  are minimized
- It provides a "working solution" relatively fast and with all components
  working
- It has a natural project-based approach, with frequenty resonates with
  learners.
- It gives the learner a database of examples they can use in the future,
  reducing the need for long-term recall.

### Cons

- One may be specially susceptible to a strong [Dunning-Krugger
  Effect](https://www.youtube.com/watch?v=kcfRe15I47I). Thinking that since the
  solution worked from the start, one understands how and overestimates their
  competence. This also applies to the teachers, "if the learners were able to
  do X, they sure are able to do Z" is not always true in a full top-down
  approach.
- It uses knowledge from different places and includes many concepts at once
  that the learner may not have been exposed to.
- Troubleshooting becomes difficult for the student when left on their own, as
  they may not have the tools to explore why and how errors happened.
- Since everything is a project with some boilerplate already fill in, it may be
  difficult for the learner to start something from scratch.
- Sometimes concepts may be oversimplified hiding the complexity of the topic,
  when the learner deviates from the taught path, all those complexities may be
  daunting.

### Example

One of the most prominent resources in this space is [FastAI's Practical Deep
Learning for Coders](https://course.fast.ai/). 

Proponents would say:

- X is not hard, you just need W, Y, Z.
- Don't worry if you don't understand now, it will become clearer later. 

Detractor would say one may be "Ignoring the devil in the details".

## Experimental

This is a try and error approach, it tries to make some specific solution work,
without caring too much about other solutions or how the building blocks
interact.

### Pros

- It creates domain expertise as many paths are being explored.
- Consolidates learning by hands-on experience.
- Prevents Dunning-Kruger effect by facing errors multiple times.
- Prevents Impostor Syndrom because one faces failure and success multiple
  tymes.
- Creates a strong reinforcement towards similar problems in the future. One can
  recall how a problem was solved much faster.

### Cons

- It may take an incredible amount of time. Trying different things out.
- The knowledge acquired may be too domain specific or unapplicable to other
  areas.
- The knowledge acquired could be highly fragmented. The pieces may come
  together for this particular solution but understanding their use in other
  domains may not be clear.
- Creates a strong bias towards past solutions. Since many hours were spent
  trying to solve a particular problem, one may prematurely discard options that
  were dismissed to solve the initial problem but that could work in other
  problems.

### Example

One Youtube channel that usually goes this route is the [Stuff Made
Here](https://www.youtube.com/@StuffMadeHere), the problem is new, previous
solutions are suboptimal, so many attemps are done in order to gain experience
and understand how to approach the problem. This channel is particularly useful
because it combines both software and hardware. 

Another example is Hackathons, which use this approach heavily.

Proponents would say "You just need to sit down and focus on it until it works".

Detractor would say one could be "A one-trick pony".

## Thinking Style

People process information differently, and this affects the way in which they
learn and prefer information to be presented.

People who prefer to break down complex information into details, smaller
subgroups, are known as analytic thinkers. Conversely, those who find it easier
to see the grand scheme at once and consider the information as a whole, are
called holistic thinkers.

A similar categorization can be done regarding information organization
organized. Those who prefer taxonomies, that is, every concep belongs to a
group, that group belongs to a broader group and so on, like files in a
directory structure. Furthermore, those who thinks of concepts as independent
ideas that are interconnected, like social relationships. The first group is
called hierarchical thinkers and the second as networked thinkers.

This is relevant because the way some authors present information may resonate
more with one style or the other, as the author itself could be leaning towards
one type. Usually holistic thinkers will prefer a Top-Down approach, focusing on
the big picture, whereas networked thinkers will build concepts from smaller
pieces like the Bottom-Up approach.

If you are interested in this topic, have a look at the following resources:

- [How culture made Japanese Internet design
  "Weird"](https://www.youtube.com/watch?v=Opy-SjDU0UY)
- [Notion vs. Roam - core philosophies and the behaviors they
  enable](https://win.hyperquery.ai/p/notion-vs-roam-core-philosophies)


## Learning Material

Independently of the learner type and the learning approach, there is also the
question of the learning material. Some people prefer videos, others text, other
prefer MOOCs, others 1:1 mentoring and so on.

The [Veritasium's video on Visual
Learners](https://www.youtube.com/watch?v=rhgwIhB58PA) could help understand why
there is not such a thing a "visual learner", instead, the more diverse the
approaches, the better the learning experience will be. And the best approach
requires making the learning actively participate, gamification is one technique
that may help teachers get to students, even for complicated concepts.

There are some remarks worth noting about learning materials: attention spans,
noise to signal ratio and recommendations.

### Attention Spans

Nowadays, attention spans are decresing, hence the rise of short-text and
short-videos in modern social networking sites. However, it is extremely
difficult to present information in such a brief format without either making
great oversimplifications or assuming a non-trivial amount of prior knowledge.

That is why most [tutorials at
PyCon](https://us.pycon.org/2023/schedule/tutorials/) last of more than 3hs,
they are hands on, not something one can learn in 30 seconds or less.

### Noise to Signal Ratio

This concept refers to the amount of noise a signal has, in the topic it refers
to "good resources to mediocre resources ratio". Information online has been
growing exponentially and now it consumes a significant amount of time to
identify truly useful resources.

For complete begginers, it is advisable to avoid social media posts and even to
some extend personal blogs, it is hard to identify correctness and assessing how
useful something is. This requires a skill a begineer does not yet have.

Whenever possible try to use reviewed sources, if reviews are not available, try
a proxy:

- How many people reviewed it possitively? (e.g. at Coursera/Udemy/Pluralsight)
- How many people watch it? (e.g. on Youtube)
- How many people like it? (e.g. on Medium)
- Where was it published? (e.g. at a PyCon)
- Is this official documentation?

### Recommendations

Be wary of recommendations though, as it is particularly tricky due to the
[expert blindness](#MISSING). Many resources show "How I would learn X if I had
to start over" and even though they are legit in their intention, they are
inevitably biased, they already know what they did not know at the start, and
that conditions themselves it favoring one approach over other because they
cannot unlearn what they learnt.

To illustrate, an experienced programmer may recommend to start with a fully
fledge IDE because they are extremely helpful. However, that's because they
already know how to use it. If that tool was presented to them as extreme
beginners, they could have been overwhelmed by the number of options and menus,
thus hindering the learning process.

I still struggle to recommend resources to other people because "what I find
useful" is only useful due to the *prior knowledge* I already have, and it is
nearly impossible to estimate how useful it would have been have I not had that
knowledge in the first place.

The bottom line is that assessing which material, roadmap or approach to use may
be more subjective than one initially thinks and one should not overestimate
"experts' advice". They give it for a reason, of course, but take it with a
grain of salt. Apply the same to this post.

One recurrent example of this problem is "Learning Git", if one asks someone who
is proficient and knows git pretty well, it is likely that that's to their
collective learning and experience and not just because one unique resource, one
may ask them a recommendation to learn but it is often the case that that single
resource will not be enough.

Some times, people have "Aha!" moments with one particular resource, and they
may deem that single resource as the "key to understand" the topic. The truth is
that maybe that single resource may be the worst thing one can give to a
beginner, however for that person it was illuminating. It is normal to have
those moments, but it usually differs from person to person due to their
existing knowledge

## Self Identification

One might identify onself with one or more types of learners. It is common to
identify with different types as time goes by. No one is right or wrong, but
knowing which "state" one sits in helps identify if a particular learning
resource will be helpful.

For example, "Tinkerers" would most likely prefer the "Experimental" approach,
Theorists are usually biased towards the "Bottom-Up" and "Other Field
Professional" towards the "Top-Down". There are definitely other factors at play
so "Professional Developers" and "Career Switchers" may lean towards any of the
approaches.

This post is oriented to a combination of the "Theorist" and the "Professional
Developer". It is not the typical "Learn Python in X days/months" that a "Career
Switcher" may want nor a "How to automate things with Python" that a "Tinkerer"
might be interested in. Although, depending on your interests, you may find
benefit if you are an "Other Field Professional".

### Working in a Team

If studying or working in team, best returns could be yielded if there are
people with different profiles. Assuming all are equally competent, having one
analytical and one holistic thinker may enrich the experience more than if all
were one type.

Generally the higher one is in the hierarchy, the more holistic one needs to
become, first one thinks of a particular problem, then how that problem
contributes to a feature, then how that features contributes to a product, then
how that product contributes to a portfolio and then how the portfolio
contributes to a strategy and then how the strategy contributes to value and
profit. C-Suite usually works at the strategy level, they may not even know
exactly which are the next feature to be released as that is abstracted away.

This is the nature of an organization as it grows, and it also explains to some
extend the difference between the Individual Contributor (IC) and Manager.
Individual Contributors are usually analytic thinkers, they can handle great
complexities but they prefer to be single focus, whereas managers are usually
people-centric, they are holistic in their approach and keep the big picture in
mind rather than the details. Some people can do the migration from one to
another, but not everyone, there are plently of stories online about people
wanting to transition from IC to Manager and then regretting it.

This should help shape the career outlook the learner wants for themselves.

## The Roadmap

The remaining of the article will explore a subjective approach to learning from
scratch until reaching independence. The idea is to divide the learning process
into different stages and give specific recommendations to each stage. Before
continuing, remember that ["All models are wrong, but some are
useful"](https://www.wikiwand.com/en/All_models_are_wrong)

## Knowledge vs Competence

There is a key distintion between offer and demand when learning programming,
learning material teaches "Knowledge" but learners want to become "Competent".
Knowledge refers to information and facts about a particular topic whereas
competency refers to the hability to apply that knowledge effectively in a
real-world situation. 

Learners want compentency, employeers want competency, everyone wants
competency, but there is a problem. There are limited tools to test competency,
but plenty to test knowledge. This is the reason why many interview processes
are flawed. In an time-boxed interview, only so many things can be assessed.
That is why proxies such as quizzes, code challenges or design questions are
used. Another proxy is the evaluation of soft-skills which are a necessary by
product of competence in some roles, e.g. a skilled software architect must be
able to articulate how to design a complex system effectively or to estimate the
resources needed to achieve that in a given time. To read more about this topic,
have a look at [Fagner Brack's
article](https://fagnerbrack.com/the-fate-metrics-for-hiring-98724fb0416).

The other side of the coin is that passing a lot of knowledge tests does not
imply competency. One may think that because one passes a test or an exam that
automatically implies competency, that is wrong and misleading. There is a
tradeoff when evaluating someone, competency evaluation requires time and it
involves analysing the individual's strengths and weaknesses in a real-world
situation, that is something that unfortunately does not scale. 

The inevitable consequence is that any teaching process that involves more than
a single learner is testing knowledge and not competency. That is, any course,
class or bootcamp will only provide knowledge assessment, some of the learners
may develop competency, but not necessarily all, hence job offers are given to
the top-performers, which are the most likely indivuals who had both knowledge
and competence. One exception to this rule is mentorships, they are so valuable
because they test competency rather than knowledge, that is because the full
attention of the mentor is on a single learner at a time.

There are some better proxies for competency that could help landing a job:
online portfolios. They swap the time-consuming part of the competency
assessment process from the interview to prior the interview. It is an
opportunities for learners to prepare projects that would be very difficult to
built without the expected competency. This is a proxy and many other factors
are at play as well, but it is a definitely better proxy than a "Certificate of
Completion of X", regardless of how many hours X took. One exception to this are
official certifications, which are carefully design by a company to ensure
professionals are competent in a specific set of tools, e.g. Microsoft, AWS,
Cisco, etc.

For complete beginners, knowledge and competency are obtained somewhat
concurrently, but once the competency is present, it can be transfer to other
domains with relative ease. That is why learning a second programming language
is much easier than the first one, regardless of which the first one was,
because the first time two things were learnt: (1) the particular syntax of the
programming language and (2) problem solving with programming. The former is
knowledge, the latter is a competency. One exception is when assumtions no
longer holds, for instance, Haskell has some unique features that require
special competencies that may not be easily obtainable in other languages. 

The remaining of this article will focus on how to achieve competence, for that,
consider the [Four Stages of
Competence](https://www.wikiwand.com/en/Four%20stages%20of%20competence) plus
some personal contributions:

1. **Unconscious Incompetence**: one is unaware of programming and does
   notrealize that it is a skill they can learn.
1. **Conscious Incompetence**: one becomes aware of programming, but strugglesto
   write code and recognizes their lack of proficiency.
1. **Conscious Competence**: one gains programming skills through practice,
   butstill needs to concentrate and think deliberately while coding.
1. **Unconscious Competence**: programming becomes second nature, and one
   canwrite code effortlessly, with deep knowledge and skill.
1. **Reflective Competence**: they identify their weaknesses and always try to
   go outside of their comfort zone.
1. **Replicative Competence**: they have a multiplicative effect on others
   around them, they help other grow their level of competence exponentially.

## Unconscious Incompetence - Take Off

This is a stage everyone was in at some point, it means "I don't know how much I
don't know". People at this stage cannot even articulate how or what to learn
next.

This is potentially the most critial point in the learning process as a bad
start could cause the learner abandon the whole study. It is also when one is
most susceptible to frustration and disappointment.

I strongly recommend starting with a Bottom-Up approach, spend [100 hours or
so](#MISSING) and then decide if you want to persue learning or switch gears.
Focus on pure Python only, do not include any libraries, frameworks or tools
other than the plain language. 

There are many resources online for this and as already described, choose the
one you are most comfortable with. My personal recommendation is some
fast-feedback online environment where you can try things and see errors
**without installing** anything. Instalation and setup are sometimes
problematic, and better avoided at this point to prevent premature
disappointment, use an online environment whenever possible.

For Python, the following are good free online environments (not sponsored):

Single File:

- [Python Tutor](https://pythontutor.com/python-debugger.html)
- [TutorialsPoint](https://www.tutorialspoint.com/execute_python3_online.php)
- [W3
  Schools](https://www.w3schools.com/python/trypython.asp?filename=demo_compiler)

Multi File:

- [Replit](https://replit.com/languages/python3)
- [Online Python](https://www.online-python.com/)
- [Programiz](https://www.programiz.com/python-programming/online-compiler/)

**Important note**: restrain yourself from using help tools such as forums,
chatbots or other guides, do not focus on solving exercises, focus on learning
what things are, how they work and why they do what they do. Using something
like an AI Chat is like trying to learn multiplication with the aid of a
calculator, it hinders the true learning experience. Leave those tools for a
later stage.

This stage could be colloquially called "Take Off", leave the total inexperience
ground and graduate from being totally unaware.

## Conscious Incompetence - Consolidation

A couple dozens hours has been already spent learning or maybe there is existing
background that brought the learner to this stage. The important part is that
now one can say "I knows what I don't know". It may seem like a something
impossible to achieve and to some extend it is true but, at this stage one has a
clear understanding on what's ahead.

This could be because one knows programming already, but maybe not Python, or
one has been playing with Python for a long time, or maybe because there is
expertise in other fields that served as a good proxy to estimate the upcomming
complexity. Regardless of the source, there is significant improvement from the
last stage.

At this point, I suggest continuing with the Bottom-Up approach, this time with
more complex topics such as popular Python libraries, frameworks or patterns but
always with well known sources, avoid experimental or hobbist projects, look for
healthy and active communities. At the same time, start watching some Top-Down
material using those resources, but always understanding how pieces work
together.

Now the learner should have a proper installation of Python in their local PC,
they already know the language, it is okay to deal with some problems while
installing, but they should learn how to install Python from scratch by now. I
would know bother with virtual environments or dependency locking just yet,
leave that to the next stage.

Consider a back-end developer as an example, these are some of resources one may
look for:

- Learn how APIs work (Bottom-Up)
- Learn how Flask work (Bottom-Up)
- Learn how to structure a Flask app (Bottom-Up)
- Develop an ToDo list with Flask (Top-Down)

Keep concentration on learning, not building. Familiarize yourself with the
tools until you gain some intuition on how to do the things you want to do. This
is a good moment to **slowly** incorporate tools like AI Chats.

This stage may take a couple of months, it involves try and error and a lot of
back and forth, but since the basics are well understood, that should not be a
problem. This is why I would refer to this stage as "Consolidation"

## Conscious Competence - Portfolio

At this point, one understands how the tools work with a comfortable degree of
proficiency. However, most of the time was spent learning, now is the time to
build. Bottom-Up materials would start to feel repetitive, teaching the same
content.

You will know you are in this stage where you are spending more time reading
documentation and forums rather than beginners tutorials. You reached
"Intermediate Level" but you lack experience. You have quite a bit of knowledge,
but maybe not competence.

Focus now on "Top-Down" resources, create a porfolio of projects, build things
you understand and can explain to others. Publish your progress in social media
or on your own blog (or build one as part of the portfolio).

It is fine if it is still hard, or if you feel you are blindly following
tutorials online, you will still need that. You have to be exposed to many
different projects to start gaining intuition about how things are done. Do not
try to do things from scratch yet. Now would be a good moment to incorporate
virtual environments and dependency locking tools like pipenv, poetry or
similar. It would be important to learn git and publish those projects in Github
as public repositories.

Most of the building happens at this stage, so this is the "Portfolio" stage. It
is okay to try some experimental frameworks but the bulk of the building you be
done should be in well stablished frameworks and tools.

## Unconscious Competence - Independence

You have built so many projects that you know the steps by heart, it feels
second nature and you do not have doubts about how things work the way they do.

However, there is caveat, keeping onself at this level of competence requires
uninterrupted practice, knowledge may last longer but competency rusts over
time. This stage is also a risky position as it can cause stagnation, either
willingly or unwillingly. Once one masters something, a create a comfort zone
around is created and all the effort put in may become friction to move beyond.

You can consider "Independent", you are most likely not a junior
any more but maybe your comfort zone is quite limited, try to expand it little
by little to include more topics. Look for a mentor that knows much more than
you to give you advice, do not expect other people to invest time without
compensation.

This is a good moment to continue Top-Down and start incorporating Experimental
learning. Nevertheless, this is the first "stable" stage, where one can sit back
and just keep the status quo, depending on your context you may never be forced
to move.

A perfect example of this is experts in an old, unpopular yet still used
language like COBOL, they are competent and independent and may never leave
COBOL for as long as it is still use. But this situation is also fragile, the
more one stays the same, the harder it will be to move to something different.

Without continuous and conscious action, one's unconscious competence could fade
into unconscious incompetence, like a developer specializing in Flash now
realizing Flash is not used anywhere and migrating to alternative technologies
is not trivial.

Remember: Expertise is not a free ticket to rest on one's laurels.

## Reflective Competence - Research and Development

The original model of four stages of competences does not include a fifth stage
but some authors proposed one called "Reflective Competence". This stage is when
individuals not only possess a skill to the point where they can perform it
effortlessly and automatically but also have the ability to reflect on their own
performance and continuously improve.

At this stage, one is aware and understands their own thought process, i.e.
metacognition. They developed a metacompetency: proactiveness. The hability to
self-assess oneself, take initiative, anticipate future needs, adapt in advance
and actively seek feedback. This stage is the highest level of competency that
one can achieve individually.

In the technology world, change is always constant and to avoid getting
outdated, I suggest always pushing yourself outside of your comfort zone but
[not too agressively](https://mcfunley.com/choose-boring-technology). 

Learn new frameworks, try new tools, new methodologies, mentor someone, start
side projects, get involved with the community, contribute to open source
projects. This stage is "Research and Development" and it is time to go
"Experimentation" mode.

Some examples:

- You master relational databases, try learning ORMs or NoSQL databases
- You master Keras, try learning FastAI or Bayesian Frameworks
- You master Pytest, try learning Hyphotesis
- You master Flask, try learning FastAPI
- You master Type Hints, try learning Pydantic
- You master your field's favourite library, try fixing some issues or develop
  new features

People in this group can act with just some small pieces of information, an idea
may be enough to spark the whole process and they can keep it burning. The
industry usually call these individuals different names "Leaders", "Seniors",
"Tech Leads", "Mentors/Coach" and so on.

## Replicative Competence - Exponential Growth

This stage is not formal and it is my personal contribution. Once an individual
reaches Reflective Competence, there is only one way to continue growing:
horizontally. This stage assumes one does not operate in a silo and has people
around them.

People at this stage not only can perpetually grow themselves but also foster an
environment for efficient, engaging and motivating grow for everyone around
them. 

This involves several competencies that exceeds the technical side and may not
be something desirable for everyone, as previously mentioned, not everyone wants
to leave the IC role. These individuals are people who C.A.R.E.S

C - Competence in the Domain: They are experts in the specific domain or skill
they aim to multiply in others.

A - Adaptive Communication: They have effective and adaptable communication
skills, ensuring clear and relatable knowledge transfer.

R - Relational Empathy: They build strong relationships and connect with others'
needs and emotions.

E - Encouraging Patience: They cultivate patience and persistence to support and
guide individuals through their learning journey, even during challenging
moments.

S - Supportive Coaching: They provide constructive feedback, coaching, and
mentorship, fostering growth and critical thinking in others.

By having a single individual at this level on a team, they make it possible for
the other team members to grow at a rate which would not have been possible
otherwise. They enable others and by doing so produce "Exponential Growth".

These is the stage any person aspiring for a leadership possition should aim,
people at this level are influential, they lead by example and they create a
subculture in an organization. They are sought and they actively look for
opportunities, not just for them, but for people around them. They are a never
ending fountain of knowledge and experience.

## Self-Assessment and Criticism

It would be ironical that the whole article talks about self-assessing oneself
without providing an example of such excercise. The roamap for the different
levels of competence presented is incomplete and protays an image of reality
that is quite different from what actually happens.

There are two main criticism of these approach, but I encourage the reader to
also provide their feedback and we can expand this section further:

- Beginners do not care about X, Y, Z level of competence, they just want to
  gain the skill and that is it.
- This is utopian and unrealistic and there are many external factors not
  considered in this article.

## Begineers do not Care

The fact that beginners may or may not care is subjective. However, I
anticipated at the beginning, this is a process every learner should own. Going
for pre-backed solutions is not owning the process.

The content presented was thought for programming and Python, but most of it is
applicable to any field. That being said, there is indeed one assumption, this
content is for people who want a plan and not just a quick-fix solution or just
the inmediate next step. It is for people who sit down and thinks in advance and
want to have a goal long term, something they could aim, even if it is far away.

I recognize the value deliver by this content is not a short-term gain, it
focuses on long-term processes and thus has a long-term return. It is meant to
be something one slowly internalizes and incorporates into their own learning
process.

## This is Utopian and Unrealistic

People may argue that this is written as if the only thing one does is learning,
there is work, family, travel, and any other number of things a person does in
life. There are also negative things than impedes progress such as toxic
cultures, economic instability, family problems, etc.

All of the previous is true, and it is a fair point, the approach is flawed as
any other guide one may find online. It is impossible to tackle the problem for
all possible angles, but, if we have a goal, albeit it idealistic, we can make
adjustments to our own situation to cope with the challenges and adapt, in the
end, that is a competence worth having.

The real world is not only rush, it is chaotic, but having in mind some order
about what loose next steps are, could help us weather the storm.

## Closing Thoughts

There are no perfect resources, everyone learns at different rates and with
different approaches. Beware of your know strenghts and weaknesses when learning
and create a roadmap that is compatible and comfortable to your style.

Do not trust too much what you see online (including this article), but also
avoid going on your own adventure unless you know what you are doing. Always
question yourself and look for feedback from people more experience than you.

Exposed yourself to things that contradicts your beliefs on a regular basis,
otherwise you may experience confirmation bias.
