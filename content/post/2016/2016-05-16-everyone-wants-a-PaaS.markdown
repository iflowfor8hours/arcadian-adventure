+++
layout = "single"
title = "The pipeline you want versus the one you need."
date = "2016-05-06"
tags = [
  "pipelines",
  "CD",
  "rant",
  "PaaS"
  ]

+++

* What clients want

Often times I find myself working with a client where they are determined to accelerate development, and feel they need a build and deployment pipeline. Development teams need a pipeline that automatically runs tests, runs builds, maintains artifacts, configures applications, and manages deployments and promotions through their environments. Other requirements creep in such as tracking bugs and releases, integrating operational metrics from the application, adding business metrics around revenue or market events, and tracing static quality or other characteristics from their version control system or other sources, but the core functionality of the pipeline is ensuring artifacts go from environment to environment reliably and repeatably. 

Many companies design their pipelines around their development environment, citing specifics about their processes or technologies that require attention, and scope creep begins to happen from the very inception.

    "We need it to run nUnit, jUnit, and support both Gradle and ANT-based builds for all platforms."

The value proposition of a pipeline begins to fade into the background as the technical details and toolset of the pipeline are hashed out and decided upon. This is a slippery slope in any project, but especially toxic in infrastructure projects, where KPIs are often less well understood, and internal tools are almost always uglier than customer-facing ones.

    "There will need to be exceptions around applications with coupled databases. How are we to express those relationships?"

When these questions and you don't yet have anything deployed, I would caution that you are far into the weeds already and it is time to start asking yourself what problem you are trying to solve.

The purpose of a pipeline is to continuously deliver high-quality software. As the complexity of the software or number of components increases, the CI pipeline should not add additional complexity, but save on complexity by having and established and repeatable path to production. It is also a powerful tool for maintaining the discipline and health of the project.

* What we wind up building *

The thought process and desire for building a PaaS often stems from the technology side of the business, looking to decrease the entropy in environments. Usually the effort to centralize configurations is driven by a desire for more flexibility, scalability, easier of administration, a migration to a public cloud platform, or a combination of those reasonable justifications. As applications become configuration-managed using chef, ansible, or puppet, and environments in consul or something similar, the amount of source code and software that the organization must wrestle with and control balloons. New terminolgy is introduced, new environments are comissioned and named, and tools take the place of manual processes, a natural separation starts to occur between people who understand the point of this, and those who see the new measures as needless and frustrating impediments to getting things done.

    "How will we control the version of libraries in our build and deployment environments?"

The same thinking beings to creep in, putting the cart far before the horse in terms of customer need. Although building a pipeline is almost always initially a *cost* center, that does not mean that it cannot deliver value incrementally.

As a developers, we often try to build the most generic and flexible system possible, to enable other developers to make responsible decisions for themselves. After all, they know their software better than we ever could and are therefore poised to make the best decisions for the project. A *pipline, in essence, is an unopinionated orchestration of independent tools, workflows, and environmental constraints whose output is running software*. 

As experts, this is what we want. A system that an expert user or even mere mortal can bend to their will to do just about anything. Jenkins, Bazel, and TeamCity are CI servers, and built around the concepts of builds, builders, jobs, and artifacts. This language is too limited for the ideal conceptual model for a CD pipeline. GoCD and concourse.ci build on that concept from a higher level, and can express the famously complex relational model of pipelines-of-pipelines, determine the order in which artifacts must be built, and understand various types of triggers. To the expert, this is actually far _simpler_ and less error prone then the [*complicated-ness*](insert link about complex vs complicated from tao of python;;) of plugins, frameworks, languages, and tools that a CI server has to deal with. The CD-aware toolchain expresses the abstractions as *WHAT ARE THEY IN GOCD;;*, which are ideas that come very naturally to those familiar with trying to squeeze the pipeline abstraction into a CI tool's language abstraction.

    An ideal pipline in essence is an unopinionated orchestration of independent tools, workflows, and environmental constraints whose output is working, running software.

More generic methods are considered to express these relationships as systems become more complex to reason about. The culmination of this idea is in travis and codeship-style build and deployment tools, which execute whatever is in the entrypoint file and often continuously deploy the built artifacts. Systems such as this lack knowledge about anything other than the localized build. A single-paradigm web application developer's wet dream. Few of the ideal-world advantages of a pipeline are realized in this implementation, but they are all available, just a shell script or untested block of code in a YAML file away.

The widespread use of containers and microservices has greatly accelerated this trend far past the humble beginnings of Heroku's 12 factor app philosophy. This pushes operational complexity further away from the developer and onto the operations team to have service discovery working, autoscaling available, and data layers well-abstracted. A very high level of maturity is required for this to work, let alone to begin paying dividends.

Meanwhile, back on earth, our developer still struggles to run some new code in a prod-like environment and then forget about it when she is done doing whatever she needed it for. The level of mental engagement and knowledge required for the tooling to get out of the way has already tanked the project, before the cost and the scope creep even had a chance. The object of the pipeline was to accelerate development, not to build a devops cathedral out of lofty concepts and generic software.

What I see as the ideal after building a ton of these

Changing development workflows
