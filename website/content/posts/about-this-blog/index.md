---
title: "About this blog"
date: 2020-07-02T22:13:29Z
description: >-
  Why I started blogging, what I'm going to be blogging about.
draft: false
#tags: [""]
#categories: [""]
series: ["blog hosting"]
markup: md
#image: "images/2014/Jul/titledotscale.png"
comments: true     # set false to hide Disqus comments
share: true        # set false to share buttons
authors:
  - matt
resources:
  - name: devexp
    src:  images/devexp.gif
---
# Welcome!

It's been an interesting few weeks getting this off the ground.
I have indulged in a fair amount of [yak shaving](https://www.hanselman.com/blog/YakShavingDefinedIllGetThatDoneAsSoonAsIShaveThisYak.aspx)
on the way but I'm pretty much there now!

I'm using this blog as a vehicle to showcase some of my Azure learnings.
I wanted to start with the following question...

## Why blog?

<!--more-->
I am a person that likes to ***learn by doing***.
This means that I wanted to challenge myself with something new.

Instead of using Medium, WordPress or any of the other blogging platforms,
I thought I would do something different...

## My needs

* I wanted content to be {{< atgtblank "https://github.com/matt-FFFFFF/blog" "open source" >}}
* I needed to do local development that would produce identical output to the deployed website
* I wanted to automate deployments
* I wanted to minimise costs

## Decisions

| Thing | Technology | Rationale
| - | - | -
| Web content | {{< atgtblank "https://gohugo.io/" Hugo >}} | Uses {{< atgtblank "https://golang.org/" golang >}}, another interest of mine
| Web hosting | {{< atgtblank "https://azure.microsoft.com/en-us/services/app-service/static/" "Azure Static Web Apps" >}} | Inexpensive & reliable
| Local development | {{< atgtblank "https://docs.microsoft.com/en-us/windows/wsl/wsl2-install" "WSL 2" >}}, {{< atgtblank "https://www.docker.com/" Docker >}}, {{< atgtblank "https://code.visualstudio.com/" "VS Code" >}} & {{< atgtblank "https://devblogs.microsoft.com/commandline/introducing-windows-terminal/" "Windows Terminal" >}} | Fast & efficient workflow. Containers ensure consistency.
| CI/CD | {{< atgtblank "https://github.com/features/actions" "GitHub Actions" >}} | Comes out the box with Azure Static Web Sites

## Next...

I'll give an overview of the system architecture.
After that I'll talk about the amazing developer experience that you get on Windows. Here's a little preview :smiley:

{{< figure src="images/devexp.gif" >}}
