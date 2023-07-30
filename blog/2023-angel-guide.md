Title: ANGEL - An Oppinionated Guide on how to Learn Programming (focusing on Python) 
Date: 2023-07-22
Category: Programming
Tags: Python, learning
Slug: angel
Authors: Ezequiel Leonardo Castaño
Lang: en
Headerimage: https://elc.github.io/blog/images/angel-guide/angel-guide-headerimage.png
Status: draft

[![Article Header Image]({static}images/angel-guide/angel-guide-headerimage-thumbnail.png){: .b-lazy width=1280 data-src=/blog/images/angel-guide/angel-guide-headerimage.png }](/blog/images/angel-guide/angel-guide-headerimage.png)

<!-- PELICAN_BEGIN_SUMMARY -->

Courses and pieces of training claiming to deliver rapid results have become
increasingly popular these days. Nonetheless, amidst the abundance of online
resources, it can be challenging to distinguish valuable ones from the noise.
Enter ANGEL, which stands for "ANGEL's Not a Guide to Effortlessly Learning."
This guide presents readers with a practical approach to the programming
learning experience. While the examples will be specific to Python, the reader
can apply the core content to any programming language or framework.

<!-- PELICAN_END_SUMMARY -->

Indeed, writing with both potential readers in mind is essential to ensure that
the content resonates with learners and teachers alike. In this article, we'll
address "the learner" as the protagonist in a more impersonal manner. Whenever
"the learner" is mentioned, it refers to YOU if you are someone eager to learn,
and if you are a teacher, "the learner" represents YOUR learners. By striking
this balance, we can provide valuable insights and guidance to everyone involved
in the learning process.

Programming is not an innate ability but rather a skill that requires deliberate
development. Although not impossible to learn, it may not be [necessary or
suitable for everyone](https://www.youtube.com/watch?v=EFwa5Owp0-k){: target="_blank"}. This guide
takes a meta-analysis approach from an "angel's" point of view (pun intended).
Rather than providing a rigid set of precise resources or a specific order of
topics, this guide concentrates on the learning journey. It offers valuable
insights and tips to help learners avoid frustration, maintain engagement, and
establish a clear framework for progression.


Some key ideas should be taken into consideration while reading:

- **Ownership**: The learning process belongs to the learner. No one can guide
  them better in "learning to learn" than themselves. While teachers and mentors
  are valuable sources of support and guidance, the learner must take charge of
  discovering how they learn best, being actively involved and interested in
  shaping their learning process to make it more effective and enjoyable.
- **Overshooting and Undershooting**:  drawing from control theory, in practical
  terms, it means that Being too strict or too lax in one's approach can hinder
  progress. While understanding the advantages and disadvantages of different
  method is vital, excessively deviating from a structured approach may lead to
  confusion and challenges. The learner should be open to exploring new things
  in a controlled and measured way while avoiding chaos.
- **Same Destination**: when following a roadmap to learn something, it's
  crucial to recognize that not everyone will take the same path. Diversity in
  learning styles and methods is natural and should be embraced. Each learner's
  unique approach doesn't necessarily indicate superiority or inferiority in
  learning ability. With enough time and dedication, everyone can achieve a
  comparable level of proficiency, although individual objectives may lead to
  slightly different outcomes. 

The sections in this article are thoughtfully structured as follows:


- **Learner Profiles**: This section provides background information about the
  learners, including their previous experiences and personal goals related to
  programming.
- **Learning Approaches**: Here, the post explores how the content is structured
  and organized, potentially outlining different learning paths or
  methodologies.
- **Thinking Style**: This section delves into how learners process information
  and generate insights, which can impact their learning experience.
- **Learning Material**: Considerations for selecting appropriate learning
  materials. The quality and relevance of the resources chosen can significantly
  impact the learning journey.
- **Roadmap**: This roadmap serves as a clear path to follow, highlighting
  stages for learners to progress steadily in their programming competence.
- **Closing Thoughts**:  It wraps up the guide, giving learners a sense of
  direction and motivation to continue their learning journey.

**SPOILER ALERT**: It's essential to note that this guide isn't a quick and
superficial "Learn X in Y minutes" type of resource. There are no TL;DR,
summaries, or skippable sections. This post is thought for those genuinely
invested and wanting to thoroughly read and absorb the content. 

## Learner Profiles

Individuals embark on learning programming for various reasons and bring diverse
backgrounds to the table. Acknowledging these differences and adjusting
expectations is vital to create a roadmap that facilitates effective knowledge
acquisition.

Below, some typical learner stereotypes will be examined. While it's crucial to
recognize that these stereotypes are not entirely accurate and may not encompass
the full breadth of learner profiles, they provide a fair simplification that
allows for better planning and organization.

## Other Field Professional

Learners from diverse fields like finance, biology, marketing, or any non-IT
domain, often seek to learn programming, particularly Python, to enhance their
skill sets. Their motivation stems from specific goals, such as automating
repetitive tasks, conducting data analysis, or developing applications relevant
to their respective domains. While they might not prioritize high-quality code,
their main objective is to achieve efficient and effective solutions that get
the job done.

For instance, individuals with a background in the stock market may be
interested in learning Python for algorithmic trading, as highlighted in this
[FreeCodeCamp Course with 2M
views](https://www.youtube.com/watch?v=xfzGZB4HhEE){: target="_blank"} .

These learners typically possess expertise in their respective fields but may
have limited or no programming background. They are focused on achieving
tangible results and may prioritize functionality over writing high-quality
code. [PyData Conferences](https://www.youtube.com/user/PyDataTV){: target="_blank"}  are a
testament to the widespread adoption of Python among learners  from non-IT
fields, where many professionals showcase how they employ Python as an effective
tool in their daily work.

## Tinkerers

Python has a magnetic appeal for learners who have a tinkering spirit and love
to experiment with code. These learners are naturally curious and enjoy the
process of experimenting with code, embarking on personal projects, creating
utilities, and exploring Python's vast potential for creative expression.

A prime example of this kind of learner is someone who aims to learn Python to
automate tasks in their home using Raspberry Pi and delve into the world of
domotics, as showcased in the [Sentdex Guide with 500K
views](https://www.youtube.com/playlist?list=PLQVvvaa0QuDesV8WWHLLXW_avmTzHmJLv){: target="_blank"} .
 
While they are keen on understanding what they are doing, they might not
necessarily delve deeply into the theoretical aspects of programming. Instead,
the focus lies on testing multiple solutions and optimizing for performance.
They prefer practical and tangible outcomes rather than diving into the
intricacies of the underlying algorithms.

## Career Switchers / Leverage Seeker

These learners want to transition to a new career as their primary goal, often
utilizing programming as leverage to achieve this change. They may or may not
have a background in programming but are especially interested in maximizing
returns with minimal effort.

An example could be someone feeling locked into their current job or career
path. They are not entirely comfortable with their daily job and seek an exit
strategy. As a result, they are often looking for efficient and rapid ways to
acquire the necessary programming skills that can open new opportunities. As
this [FreeCodeCamp Course with 40M
views](https://www.youtube.com/watch?v=rfscVS0vtbw){: target="_blank"}  shows

A typical subtype within this category is the high school or college student who
solely wants to learn what is needed to pass an exam or fulfill specific
academic requirements. Their focus is on attaining the necessary skills to
achieve academic success.

## Theorists / Scholars

Theorists and scholars, often coming from a Computer Science or related
background, approach learning Python with a specific purpose – to implement
algorithms and data structures with a strong emphasis on code analysis,
particularly time and space complexity.

A classic example of this type of learner is a college student attending an
Algorithms and Data Structures class or someone involved in research within this
field. For instance, this [MIT Course with 5M
views](https://www.youtube.com/playlist?list=PLUl4u3cNGP61Oq3tWYp6V_F-5jb5L2iHb){: target="_blank"} .

Theorists and scholars typically have a narrow perspective on code, emphasizing
performance, correctness, and theoretical analysis. They are less concerned with
"idiomatic" or conventional coding practices and may not prioritize aspects
related to software project management. Instead, they focus on maximizing the
efficiency and effectiveness of individual pieces of code.

## Professional Developer

Professional developers who work with Python or other programming languages
bring a wealth of experience and software development knowledge to the table.
For them, Python is another valuable tool in their arsenal that can be
beneficial in specific scenarios and alongside other languages.

An exemplary case of this type of learner is someone who has already learned
Python but is now looking to deepen their understanding of design patterns to
enhance the robustness of their code. As this [Arjan's Software Design Playlist
with 250K views
shows](https://www.youtube.com/playlist?list=PLC0nd42SBTaNuP4iB4L6SJlMaHE71FG6N){: target="_blank"} .

These learners often come with a set of pre-existing skills and practices from
their background in software development. As a result, they might not fully
embrace Python's "way of doing things," but they are dedicated to maintaining
high-quality code and adopting a product-oriented approach.

## Learning approaches

Learning approaches can vary widely across available resources, and not all
styles may be suitable for every learner, regardless of their profile. In this
section, we'll explore three of the most typical learning approaches:

## Bottom-Up

The Bottom-Up learning strategy is characterized by starting from foundational
concepts and gradually building upon them to understand more complex ideas. This
approach breaks down concepts into smaller, easy-to-digest pieces, emphasizing a
solid foundation before tackling more advanced topics.

### Pros

- **Solid Foundation**: Learners gain a reliable and solid foundation in
  programming. By understanding the smaller building blocks, they can construct
  more significant and complex solutions.
- **Easy-to-Digest**: Focusing on manageable and easy-to-understand bits ensures
  learners grasp the fundamentals thoroughly, preventing information overload.
- **Progressive Learning**: New knowledge is built upon previously taught
  material, creating a sense of continuity and progression in the learning
  journey.

### Cons

- **Time to Tangible Results**: The emphasis on learning basics and building
  blocks may delay seeing tangible results or practical applications, leading to
  frustration or an unproductive sensation.
- **Impostor Syndrome**: Learners may develop [impostor
  syndrome](https://en.wikipedia.org/wiki/Impostor_syndrome){: target="_blank"}
  , feeling that they only know the building blocks and haven't built anything
  substantial, underestimating their capabilities.
- **Fragmented Knowledge**: The focus on independent parts can hinder learners
  from seeing the big picture and understanding how different concepts relate.
- **Start from Scratch**: This approach often involves starting from scratch,
  which may not align with real-world scenarios where learners might work with
  existing codebases.
- **Long-Term Retention**: As learners progress through individual components,
  their knowledge can become fragmented and hinder long-term retention if not
  periodically reviewed.

### Example

Most guides, tutorials, and even university courses often follow the bottom-up
learning approach. They start by teaching foundational concepts such as
variables, control structures, and data structures, and then progressively move
to solving larger problems by reusing the previously taught concepts.

Proponents would say "You cannot start with X unless you cover W, Y, and Z in
detail first."

Detractor would say one may be "Missing the forest for the trees".

## Top-Down

The top-down learning approach focuses on starting with the "big picture" and
making something work even if the learner doesn't fully understand all the
underlying details. From there, they build on the working solution and delve
into the specifics.

### Pros

- **Avoiding Excessive Frustration**: it helps avoid excessive frustration as
  learners start with a known solution, reducing trivial errors like syntax
  mistakes or wrong operators.
- **Fast Working Solution**: Learners can achieve a functional result relatively
  quickly, gaining a sense of accomplishment early on.
- **Project-Based Approach**: The top-down approach naturally adopts a
  project-based learning style, resonating well with many learners who prefer
  practical, hands-on experiences.
- **Database of Examples**: By starting with working solutions, learners build a
  database of examples that can be leveraged in future projects, reducing the
  need for extensive long-term recall.

### Cons

- **[Dunning-Krugger 
  Effect](https://www.youtube.com/watch?v=kcfRe15I47I){: target="_blank"}**: 
  Learners may be susceptible to overestimating their
  competence, believing they understand more than they do, leading to a false
  sense of mastery.
- **Difficulty in Troubleshooting**: When faced with errors or issues, learners
  may struggle to troubleshoot effectively, lacking the foundational knowledge
  to explore the reasons behind them.
- **Starting from Scratch**: Learners might experience challenges when starting
  a project from scratch, as they have accustomed to pre-filled boilerplate code
  during the initial phase.
- **Oversimplification of Concepts**: In some cases, concepts may be
  oversimplified, hiding their true complexities. When learners deviate too
  much, they may encounter daunting intricacies.

### Example

A prominent resource that follows the top-down approach is [FastAI's Practical
Deep Learning for Coders](https://course.fast.ai/){: target="_blank"} . 

Proponents would say:

- X is not hard, you just need W, Y, Z.
- Don't worry if you don't understand now, it will become clearer later. 

Detractor would say one may be "Ignoring the devil in the details".

## Experimental

The experimental learning approach is characterized by a trial-and-error
mindset. Learners focus on making a specific solution work without overly
concerning themselves with alternative approaches or how individual building
blocks interact.

### Pros

- **Domain Expertise**: The experimental approach allows learners to explore
  multiple paths, creating domain-specific expertise in the process.
- **Hands-On Learning: Learners consolidate their knowledge through hands-on
  experience, gaining practical insights into problem-solving.
- **Avoiding Dunning-Kruger Effect**: By facing errors and challenges multiple
  times, learners avoid the Dunning-Kruger effect and develop a more realistic
  assessment of their skills.
- **Overcoming Impostor Syndrome**: Encountering both failures and successes
  reinforces learners' confidence, preventing impostor syndrome.
- **Reinforcement and Faster Recall**: This approach strengthens learners'
  understanding of solutions for similar problems. They can recall how certain
  problems were solved more efficiently in the future.

### Cons

- **Time-Consuming**: The experimental approach can be time-consuming, as learners
  try out different approaches and solutions.
- **Domain-Specific Knowledge**: The knowledge acquired through experimentation may
  be highly domain-specific and not easily applicable to other areas.
- **Fragmented Knowledge**: Learners may end up with fragmented knowledge,
  understanding how pieces fit together for specific solutions but struggling to
  apply them in different contexts.
- **Bias Towards Past Solutions**: Having invested many hours in trying to solve a
  particular problem, learners might prematurely dismiss options that were
  previously discarded, limiting their exploration of alternative solutions.

### Example

One example of the experimental learning approach can be found in the YouTube
channel ["Stuff Made Here"](https://www.youtube.com/@StuffMadeHere){: target="_blank"} .This channel
tackles novel problems where previous solutions are suboptimal, and the creator
explores multiple attempts to gain experience and refine the approach. This
channel effectively combines software and hardware aspects, making it a valuable
resource for hands-on learning.

Another scenario where the experimental approach is commonly used is in
hackathons. Participants often explore different solutions and experiment with
various technologies to find the most suitable and innovative solutions within a
short timeframe.

Proponents would say "You just need to sit down and focus on it until it works".

Detractor would say one could be "A one-trick pony".

## Thinking Style

Understanding the thinking style of learners is crucial in presenting
information in a way that resonates with them and enhances their learning
experience. People can be categorized into two main thinking styles:

- **Analytic Thinkers**: These individuals prefer to break down complex
  information into smaller, more manageable details and subgroups. They excel at
  analyzing and dissecting concepts to understand their intricacies thoroughly.
  They often appreciate a bottom-up learning approach, where they start with
  foundational concepts and gradually build a comprehensive understanding.

- **Holistic Thinkers**: Holistic thinkers, on the other hand, find it easier to
  see the grand scheme of things at once. They prefer to see how various
  concepts are interconnected and how they create a cohesive structure. For
  holistic thinkers, a top-down learning approach, starting with an overview and
  then delving into specifics, may be more appealing.

Additionally, information organization preference can be categorized into two
styles:

- **Hierarchical Thinkers**: Hierarchical thinkers prefer taxonomies and
  hierarchical structures to organize information. They find it natural to group
  concepts into categories, subcategories, and broader groups, similar to
  organizing files in a directory structure.
- **Networked Thinkers**: Networked thinkers see concepts as independent ideas
  interconnected through relationships, much like social networks. They prefer
  to understand how various concepts relate to one another rather than
  organizing them hierarchically.

Authors and educators might naturally lean towards one thinking style or
information organization. The alignment between the author's presentation style
and the reader's thinking style can significantly impact how well the
information is understood and absorbed.

If you're interested in exploring this topic further, the resources:

- [How culture made Japanese Internet design
  "Weird"](https://www.youtube.com/watch?v=Opy-SjDU0UY){: target="_blank"} 
- [Notion vs. Roam - core philosophies and the behaviors they
  enable](https://win.hyperquery.ai/p/notion-vs-roam-core-philosophies){: target="_blank"} 


## Learning Material

There is no one-size-fits-all approach, and diversity in learning resources can
be beneficial for learners. Different individuals may prefer various formats,
including videos, text-based materials, MOOCs (Massive Open Online Courses), 1:1
mentoring, interactive exercises, and more. Each format has its advantages and
appeals to different learning styles and preferences.

The idea of a "visual learner" [has been
challenged](https://www.youtube.com/watch?v=rhgwIhB58PA){: target="_blank"} , as the most effective
learning experiences often involve a combination of various approaches. The more
diverse the learning methods, the better learners can engage with the material
and enhance their understanding.

Active participation is a crucial aspect of effective learning. Engaging
learners and making them actively participate in the learning process can
significantly improve knowledge retention and understanding. Gamification, a
technique that uses game elements and mechanics in a non-gaming context, is one
approach that teachers and educators can use to make learning more interactive,
enjoyable, and effective, especially when dealing with complex concepts.

### Attention Spans

In today's fast-paced digital age, attention spans have been decreasing, and
there is a growing demand for short and easily digestible content, especially on
social networking sites. However, presenting complex information in such a brief
format can be challenging, as it may require oversimplifications or assume a
significant amount of prior knowledge.

[Python tutorials at events like
PyCo](https://us.pycon.org/2023/schedule/tutorials/){: target="_blank"}  often last for more than 3
hours because they aim to provide hands-on and in-depth learning experiences.
Learning programming concepts and skills requires time and practice, and it
cannot be condensed into quick soundbites or short videos. Programming is a
skill that needs to be nurtured and honed through active engagement and
practical application.


### Noise to Signal Ratio

With the vast amount of information available on the internet, distinguishing
between valuable and mediocre resources can be challenging, especially for
complete beginners. This concept essentially refers to the ratio between
high-quality, valuable resources (the signal) and less useful or irrelevant
information (the noise).

For complete beginners, it's essential to exercise caution and be selective
about the sources they rely on for learning. Beginners may lack the experience
and knowledge to distinguish credible and accurate resources from those
containing errors or outdated information.

When reviews are not available, learners can use proxy indicators to gauge a
resource's value:

- How many people reviewed it positively? (e.g. at Coursera/Udemy/Pluralsight)
- How many people watch it? (e.g. on Youtube)
- How many people like it? (e.g. on Medium)
- Where was it published? (e.g. at a PyCon)
- Is this official documentation?

### Recommendations

Be wary of recommendations, as it is particularly tricky due to [expert
blindness](https://www.youtube.com/watch?v=yCfMIZupyfE){: target="_blank"} . Expert blindness can
influence how experienced individuals perceive and recommend certain materials
or approaches. What works well for them at their current level of expertise
might not be the most suitable choice for beginners who lack that prior
knowledge.

For example, recommending a fully-fledged IDE to a beginner might overwhelm them
with its complexity and hinder their learning process. While it might be an
invaluable tool for an experienced programmer, it might not be the best starting
point for someone just beginning their programming journey.

Assessing which learning material, roadmap, or approach to use can be
subjective, and what works for one person might not work as effectively for
another. Learners should take experts' advice with a grain of salt.

Learning Git is a classic example of the challenges with recommendations. Git is
a powerful version control system, and learning resources are numerous. What
might be a "game-changer" for one person might not be the best fit for someone
else. Beginners often benefit from exploring multiple resources and finding the
ones that resonate best with their learning style.

"Aha!" moments can be transformative, but they can differ for each individual
due to their unique backgrounds and existing knowledge. Some learners might have
breakthroughs with a specific resource, while others might find that same
resource less helpful.

## Self Identification

Understanding one's self-identification as a learner is crucial as it can guide
the choice of learning approaches and resources that best suit individual needs.
It's common for individuals to identify with one or more types of learners, and
these identifications may change over time as one gains more experience and
knowledge.

For example, those who identify as "Tinkerers" may naturally gravitate towards
the "Experimental" approach, enjoying hands-on exploration and experimentation.
"Theorists" may lean towards the "Bottom-Up" approach, delving into the
theoretical aspects and code analysis. "Other Field Professionals" might prefer
the "Top-Down" approach, seeking to apply Python to their specific domains.
"Professional Developers" and "Career Switchers" might find benefit in various
approaches, depending on their specific interests and goals.

This post is primarily oriented toward a combination of the "Theorist" and the
"Professional Developer" learner types. It is not a quick "Learn Python in X
days/months" guide for "Career Switchers," nor a "How to automate things with
Python" tutorial for "Tinkerers." However, depending on te learner's interests
and background, those identifying as an "Other Field Professional" may still
find valuable insights and benefits in this guide.

### Working in a Team

Working in a team can yield the best results when there is a diverse mix of
profiles among team members. Assuming equal competence, having a combination of
analytical and holistic thinkers can enrich the team's experience more than if
everyone had the same thinking style.

As one climbs higher in the organizational hierarchy, the need for a more
holistic approach becomes apparent. Higher-level positions require considering
problems in the context of features, products, portfolios, strategies, and
overall value and profit. C-Suite executives often work at the strategy level,
where specific feature details may be abstracted away.

As organizations grow, this hierarchical nature becomes more pronounced. This
also explains the distinction between Individual Contributors (IC) and Managers.
Individual Contributors typically possess analytical thinking skills, capable of
handling complex tasks with a single-minded focus. In contrast, Managers tend to
be people-centric and adopt a holistic approach, keeping the big picture in mind
while managing details.

Transitioning from an IC to a Manager role is not always a seamless process, and
not everyone may find it suitable for them. Some individuals might prefer to
remain in IC roles, as they excel in handling complexities and prefer focused
tasks. On the other hand, those who embrace a more holistic mindset and enjoy
managing teams and projects may thrive in managerial positions.

Understanding these dynamics can help shape the career outlook for learners. By
recognizing their strengths and preferences, learners can make informed
decisions about the type of role and career path they want to pursue.

## The Roadmap

The remainder of the article will explore an approach to learning from scratch
through different levels of competence. The idea is to divide the learning
process into different stages and give specific recommendations for each stage.
Before continuing, remember that ["All models are wrong, but some are
useful"](https://www.wikiwand.com/en/All_models_are_wrong){: target="_blank"} 

## Knowledge vs Competence

The distinction between knowledge and competence is crucial when it comes to
learning programming. Learning materials typically focus on imparting knowledge,
which comprises information and facts about a specific topic. However, learners,
employers, and everyone involved ultimately seek competence, which refers to the
ability to apply that knowledge effectively in real-world situations.

A challenge arises when evaluating competency, as there are limited tools
available for its assessment compared to the abundance of tools to test
knowledge. Job interviews, for instance, are often time-boxed, limiting the
depth of competency assessment. As a result, proxies such as quizzes, code
challenges, or design questions are commonly used. Evaluating soft skills is
also a valuable proxy, as they are essential for competence in certain roles,
such as effective communication for a skilled software architect. To read more
about this topic, have a look at [Fagner Brack's
article](https://fagnerbrack.com/the-fate-metrics-for-hiring-98724fb0416){: target="_blank"} .

Passing knowledge tests, such as exams, does not automatically imply competency.
Competency evaluation is a more time-consuming process that involves analyzing
an individual's strengths and weaknesses in practical situations. Due to its
complexity, it does not scale well for large groups of learners. As a result,
most teaching processes involving multiple learners primarily assess knowledge,
with some individuals developing competency to varying degrees.

Mentorships stand out as an exception, as they focus on testing competency
rather than knowledge. A mentor's full attention is on a single learner,
allowing for a deeper assessment of their real-world problem-solving skills.

For those seeking job opportunities, online portfolios can be a better proxy for
demonstrating competency. Portfolios showcase projects that require the expected
level of competence, and they offer a chance for learners to prepare and present
their abilities before interviews. While this is not a foolproof method, it
provides a more tangible representation of a learner's potential compared to
mere completion certificates, regardless of the hours invested in a course. One
exception to this is official certifications, which are carefully designed by a
company to ensure professionals are competent in a specific set of tools, e.g.
Microsoft, AWS, Cisco, etc.

For complete beginners, knowledge, and competency are often acquired
concurrently. However, once competency is established, it can be transferred to
other domains with relative ease. Learning a second programming language, for
instance, becomes more accessible as learners have already grasped general
problem-solving with programming, and they only need to adapt to the specific
syntax of the new language. One exception is when assumptions no longer hold,
for instance, Haskell (or any other pure functional programming language) has
some unique features that require special competencies that may not be easily
obtainable in other languages.

This roadmap focuses on how to achieve different levels of competence, for that,
consider the [Four Stages of
Competence](https://www.wikiwand.com/en/Four%20stages%20of%20competence){: target="_blank"}  plus
some personal contributions:

1. **Unconscious Incompetence**: one is unaware of programming and does not realize
   that it is a learnable skill. They might not even recognize the significance
   of programming in today's world.
2. **Conscious Incompetence**: individuals become aware of programming and its
   importance. However, they struggle to write code and acknowledge their lack
   of proficiency. They are conscious of their limitations and the need to
   improve their skills.
3. **Conscious Competence**: they can write code, but it requires concentration and
   deliberate thinking. They are competent programmers, but the process still
   demands effort and focus.
4. **Unconscious Competence**: programming becomes second nature to learners. They
   can write code effortlessly, with deep knowledge and skill. Their proficiency
   allows them to navigate complex problems seamlessly.

Additional Contributions:

5. **Reflective Competence**: Learners at this stage continually evaluate their
   skills and actively seek to identify their weaknesses. They are self-aware
   and strive to go beyond their comfort zone, taking on challenging projects
   and seeking opportunities for growth and improvement.
6. **Replicative Competence**: Individuals who have achieved replicative competence
   have a profound impact on those around them. They become mentors and role
   models, helping others grow their level of competence exponentially. Their
   expertise and support empower others to excel in their learning journeys.

## Unconscious Incompetence - Take Off

This stage is a universal starting point for every learner, where one realizes,
"I don't know how much I don't know." At this juncture, learners cannot even
articulate what or how to learn next, and it can be a critical phase in the
learning process. The risk of feeling overwhelmed, frustrated, and disappointed
is high, potentially leading to abandoning the learning journey altogether.

To navigate this crucial stage successfully, I strongly recommend adopting a
Bottom-Up approach. Dedicate around 100 hours to immerse oneself in pure Python
without involving third party libraries, frameworks, or tools other than the
language itself.

Numerous online resources are available to assist individuals in commencing
their coding endeavors, providing a range of options from which to choose the
most comfortable platform. Utilizing fast-feedback online environments is
recommended, as they allow one to experiment with code and observe errors
without encountering the intricacies of installation and setup. Avoiding such
initial technical challenges can prevent premature disappointment. 

Here are some good free online environments for learning Python (not sponsored):

Single File:

- [Python Tutor](https://pythontutor.com/python-debugger.html){: target="_blank"} 
- [TutorialsPoint](https://www.tutorialspoint.com/execute_python3_online.php){: target="_blank"} 
- [W3
  Schools](https://www.w3schools.com/python/trypython.asp?filename=demo_compiler){: target="_blank"} 

Multi File:

- [Replit](https://replit.com/languages/python3){: target="_blank"} 
- [Online Python](https://www.online-python.com/){: target="_blank"} 
- [Programiz](https://www.programiz.com/python-programming/online-compiler/){: target="_blank"} 

**Important note**: Refrain from relying on help tools such as forums, chatbots,
or other guides during this stage. Instead, focus on understanding the
fundamentals of Python - what things are, how they work, and why they behave as
they do. Using AI Chat or similar aids at this point can be likened to learning
multiplication with a calculator; it hinders the learning experience. Save these
tools for later when a more solid foundation has been laid out.

This stage could be colloquially called "Take Off," as the learner leaves the
ground of total inexperience and begin to graduate from being completely unaware
to having a growing awareness of the Python language. Embrace this initial
learning phase with determination and patience, knowing it will lay the
foundation for future programming prowess.

## Conscious Incompetence - Consolidation

Having spent a significant number of hours learning or possessing a background
in programming, learners at this stage can now say, "I know what I don't know."
It may still seem like a daunting task to achieve complete understanding, but
there is a clear awareness of what lies ahead in the learning journey.

This awareness could be a result of existing programming knowledge in other
languages, prior experience with Python, or expertise in other fields that serve
as a good proxy to estimate the upcoming complexity. Regardless of the source,
there has been significant improvement from the previous stage.

At this point, I recommend continuing with the Bottom-Up approach, but now
exploring more complex topics, such as popular Python libraries, frameworks, or
design patterns. Focus on well-known and reputable sources, avoiding
experimental or hobbyist projects. Additionally, start engaging with some
Top-Down material that integrates the use of these resources, understanding how
various pieces work together.

By now, the learner should have a proper Python installation on their local PC,
and dealing with installation challenges is acceptable, as long as they have
learned how to install Python from scratch. However, there is no need to delve
into virtual environments or dependency locking just yet; that can be left for
the next stage.

For instance, if the learner aims to become a back-end developer, they could
explore the following resources:

- Learn how APIs work (Bottom-Up)
- Learn how Flask work (Bottom-Up)
- Learn how to structure a Flask app (Bottom-Up)
- Develop an ToDo list with Flask (Top-Down)

The focus should remain on learning rather than building fully functional
projects at this stage. Familiarize with the tools and gain intuition on how to
accomplish the desired tasks. This is also a suitable time to start slowly
incorporating tools like AI Chats to aid in the learning process.

The Consolidation stage may span a couple of months, involving trial and error
and iterative learning, but since the basics are well understood, navigating
through challenges should not be a problem. This stage is aptly named
"Consolidation" as learners solidify their understanding and expand their
programming horizons.

## Conscious Competence - Portfolio

One has reached a stage where one understands how the tools work with a
comfortable level of proficiency. The majority of the time was spent learning,
and now it is time to put that knowledge into practice. Bottom-Up materials may
start to feel repetitive, as they cover familiar content.

In this stage, one finds oneself spending more time reading documentation,
exploring forums, and seeking answers to specific problems rather than following
beginners' tutorials. One has reached the "Intermediate Level," where one
possesses a significant amount of knowledge but may still be lacking some
hands-on experience to fully demonstrate one's competence.

At this point, it is crucial to shift the focus to "Top-Down" resources. Start
creating a portfolio of projects, building things that one understands and can
confidently explain to others. Share progress on social media or through a blog,
or even consider building a blog as part of a portfolio.

Some tasks may still be challenging, and the learner might rely on online
tutorials to guide them. Exposure to a variety of projects will help one gain
intuition about how things are done and improve one's problem-solving skills.
However, try to avoid starting everything from scratch. Incorporate virtual
environments and dependency-locking tools like pipenv, poetry, or similar, to
better manage one's projects. This stage is also an excellent opportunity to
learn Git and publish projects as public repositories on GitHub.

Most of the practical building happens at this stage, which is why it is known
as the "Portfolio" stage. While it is fine to experiment with some new
frameworks, the bulk of the building should be focused on well-established
frameworks and tools. Building a strong portfolio during this stage will not
only enhance one's competence but also provide valuable material to showcase
skills to potential employers or clients.

## Unconscious Competence - Independence

At this stage, the learner has reached a level of competence where building
projects and navigating the programming world feel like second nature. The
individual can confidently and effortlessly build projects, and their
understanding of how things work is deep-rooted.

However, there is a caveat to this stage. Maintaining this level of competence
requires continuous practice and engagement. While knowledge may stay with
individuals longer, competency can rust over time if not consistently exercised.
This stage can be risky, as it might lead to stagnation, either intentionally or
unintentionally. When becoming a master at something, a comfort zone naturally
forms around it, and the effort invested in reaching this level can become a
barrier to moving beyond it.

At this stage, learners can consider themselves "Independent." They are likely
not beginners anymore, but it is essential to avoid limiting oneself to the
comfort zone. Gradually expanding horizons to include more topics and challenges
is recommended. Seeking mentors with extensive knowledge and experience to
provide guidance is beneficial. However, it is crucial to keep in mind that
expecting others to invest time without compensation may not be realistic.
Learners should be proactive in their learning journey.

This is an excellent time to continue with the Top-Down approach and start
incorporating Experimental learning. Embracing new challenges and exploring
unfamiliar territories is essential. Staying curious and open to learning new
things is advised.

Nonetheless, this stage represents the first "stable" stage in the learning
journey. Individuals might feel content and comfortable with their current
skills and knowledge, and that's okay. However, remembering that staying in the
comfort zone for too long can make it difficult to make significant moves in the
future is important. Maintaining a balance between expertise and continuous
growth is essential. An example of someone at this stage might be an expert in
an older, less popular language like COBOL. They are competent and independent
in their field and may not feel the need to switch to other technologies as long
as COBOL is still relevant. But this situation is fragile, as the longer one
stays in the same niche, the harder it becomes to transition to something
different.

Always remembering that expertise is not a free ticket to rest on one's laurels
is crucial. Continuing to push oneself to learn and grow, and being open to
embracing new challenges and opportunities is necessary. Continuous and
conscious action is necessary to prevent unconscious competence from fading into
unconscious incompetence.

## Reflective Competence - Research and Development


The original model of four stages of competencies does not include a fifth
stage, but some authors have proposed one called "Reflective Competence." At
this stage, individuals not only possess a skill to the point where they can
perform it effortlessly and automatically but also can reflect on their
performance and continuously improve. 

In this stage, one becomes aware and understands their thought process, a
concept known as metacognition. This stage includes the meta-competency of
proactiveness, where individuals can self-assess, take initiative, anticipate
future needs, adapt in advance, and actively seek feedback. Reflective
Competence represents the highest level of individual competency.

In the technology world, where change is constant, it is crucial to stay
proactive and avoid becoming outdated. To do so, I suggest continuously pushing
oneself outside of the comfort zone, but [not too
aggressively](https://mcfunley.com/choose-boring-technology){: target="_blank"}. Engage in learning
new frameworks, trying new tools and methodologies, mentoring others, starting
side projects, getting involved in the community, and contributing to
open-source projects. This stage is known as "Research and Development," and
it's a time to enter "Experimentation" mode.

Examples of activities during this stage include:

- If one has mastered relational databases, one can try learning ORMs or NoSQL
  databases.
- If one has mastered Keras, one can explore learning FastAI or Bayesian
  Frameworks.
- If one has mastered Pytest, one can delve into learning Hypothesis.
- If one has mastered Flask, one can consider learning FastAPI.
- If one has mastered Type Hints, one can try learning Pydantic.
- If one has mastered their field's favorite library, one can try fixing some
  issues or developing new features.

Individuals in this stage can act with just small pieces of information; a
simple idea may be enough to spark the whole process, and they can keep the
momentum going. In the industry, these individuals are often referred to by
various names such as "Leaders," "Seniors," "Tech Leads," or "Mentors/Coaches,"
among others. They are valued for their extensive knowledge and their ability to
guide and mentor others.

## Replicative Competence - Exponential Growth

The stage of Replicative Competence is not formal and is a personal
contribution. Once an individual reaches Reflective Competence, there is only
one way to continue growing: horizontally. This stage assumes that one does not
operate in isolation and has people around them.

Individuals at this stage not only continue to grow themselves but also foster
an environment for efficient, engaging, and motivating growth for everyone
around them.

This involves several competencies that go beyond the technical side and may not
be something desired by everyone, as previously mentioned, not everyone wants to
leave the IC role. These individuals are characterized by being people who
**C.A.R.E.S**:

- **C - Competence in the Domain**: They are experts in the specific domain or skill
  they aim to multiply in others.
- **A - Adaptive Communication**: They have effective and adaptable communication
  skills, ensuring clear and relatable knowledge transfer.
- **R - Relational Empathy**: They build strong relationships and connect with
  others' needs and emotions.
- **E - Encouraging Patience**: They cultivate patience and persistence to support
  and guide individuals through their learning journey, even during challenging
  moments.
- **S - Supportive Coaching**: They provide constructive feedback, coaching, and
  mentorship, fostering growth and critical thinking in others.

By having an individual at this level on a team, they make it possible for other
team members to grow at a rate that may not have been achievable otherwise. They
enable others and, by doing so, produce "Exponential Growth" within the team.

This is the stage that any person aspiring for a leadership position should aim
for. People at this level are influential, they lead by example, and they create
a subculture within an organization. They are sought after, and they actively
seek opportunities, not just for themselves, but for the people around them.
They are a never-ending fountain of knowledge and experience, driving continuous
improvement and development in those they interact with.

## Self-Assessment and Criticism

Self-assessment is indeed a crucial aspect of the learning process, and it's
important to acknowledge that the roadmap presented in the article may not fully
capture the diverse experiences and perspectives of all learners. While the
article provides a structured approach, it's essential to recognize that
learning is a personal journey, and each individual may have unique preferences,
goals, and constraints.

## Begineers do not Care

The approach presented in the article is indeed geared towards learners who are
willing to invest time and effort in their learning journey and are looking for
a structured and goal-oriented plan.

The content's focus on programming and Python is meant to provide concrete
examples and guidance for learners in the technology field, but the underlying
principles and concepts can be adapted to various domains of learning.
Emphasizing that the content is intended for individuals who want a long-term
plan and are committed to their learning journey is crucial. This approach aims
to empower learners to take ownership of their learning, be proactive, and set
realistic goals for continuous improvement.

Indeed, the value delivered by this content lies in the long-term return and the
gradual internalization of the learning process. By adopting this approach and
incorporating it into their learning style, learners can develop a deeper
understanding and competence in their chosen field, leading to more meaningful
and sustainable growth.

Ultimately, the approach provided in the article serves as a guide and a
framework, but it is up to each learner to personalize and adapt it according to
their needs, preferences, and learning pace. The willingness to take ownership
and actively engage in the learning process will greatly influence the overall
success and fulfillment of the journey.

## This is Utopian and Unrealistic

Work, family, travel, personal obligations, and various external factors can
often create time constraints and obstacles that make it difficult to follow a
structured learning plan consistently.

No guide can indeed address all possible angles and individual circumstances,
and the approach presented in the article may not be feasible for everyone in
every situation. Life is unpredictable, and there will always be unforeseen
challenges and disruptions that can hinder progress.

However, the value of having a long-term goal and a structured learning approach
lies in the adaptability and resilience it fosters in learners. While it may be
challenging to dedicate extensive time solely to learning, even small steps
taken consistently can lead to significant progress over time. It is about
recognizing that progress may be gradual, and it is okay to make adjustments to
fit learning into one's existing lifestyle and responsibilities.

Flexibility and adaptability are essential qualities to develop, and having a
loose plan or roadmap can help individuals stay focused and motivated amid the
chaos of life. It provides a sense of direction and purpose, even if the pace of
learning is slower than originally intended.

Moreover, acknowledging the existence of obstacles and challenges can help
learners be kinder to themselves and avoid unnecessary pressure or guilt when
they face setbacks. It is essential to remember that progress is not always
linear, and it is okay to take breaks, reassess goals, and adapt the learning
approach as needed.

In the end, the ability to cope with the challenges of the real world and
maintain a commitment to learning is a valuable competency worth cultivating.
Embracing the journey as an ongoing process of growth and self-improvement can
lead to a more fulfilling and meaningful learning experience.

## Closing Thoughts

In conclusion, learning is a deeply personal and individualized journey. There
is no one-size-fits-all approach, and it is crucial to be aware of your
strengths, weaknesses, and learning style. Building a roadmap that aligns with
your preferences and comfort levels can lead to a more effective and enjoyable
learning experience.

While there are abundant learning resources available online, it is essential to
approach them with a critical mindset. Not all information is reliable, and not
all approaches will work for everyone. Seeking feedback from experienced
individuals and questioning your assumptions can help you refine your learning
path and avoid falling into confirmation bias.

Moreover, it is crucial to strike a balance between seeking guidance and
exploring on your own. Relying solely on pre-packaged solutions may limit your
growth, but venturing into uncharted territory without any guidance may lead to
frustration and discouragement. Embrace a mix of structured learning and
experimentation to foster a well-rounded and adaptable skill set.

Lastly, be open to challenging your beliefs and exploring different
perspectives. Exposing yourself to diverse ideas and viewpoints can help you
grow intellectually and creatively. Embrace a growth mindset, be receptive to
feedback, and never stop seeking opportunities for learning and improvement.

In the end, the journey of learning is an ongoing and enriching process. Embrace
the challenges, celebrate your progress, and keep pushing yourself to reach new
levels of competence. Remember that the path to mastery is not always smooth,
but it is the continuous pursuit of knowledge and self-improvement that leads to
true expertise.
