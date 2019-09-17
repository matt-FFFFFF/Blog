---
title: "About this blog"
date: 2019-09-17T15:51:29Z
description: >-
  Blog hosting
draft: false
tags: [""]
series: ["blog hosting"]
markup: mmark
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

* I wanted content to be <a href="https://github.com/matt-FFFFFF/blog" target="_blank">open source</a>
* I needed to do local development that would produce identical output to the deployed website
* I wanted to automate deployments
* I wanted to make the website highly available globally
* I wanted to minimise costs

## Decisions

{.table}
| Thing | Technology | Rationale
| ---- | ---------- | ---
| Web content | <a href="https://gohugo.io/" target="_blank">Hugo</a> | Uses <a href="https://golang.org/" target="_blank">golang</a>, another interest of mine
| Web hosting | <a href="https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website" target="_blank">Azure Storage</a> | Inexpensive
| Global load balancing & TLS | <a href="https://azure.microsoft.com/en-gb/services/frontdoor/" target="_blank">Azure Front Door | TLS bridging, HTTP->HTTPS redirection, custom domains 
| Local development | <a href="https://docs.microsoft.com/en-us/windows/wsl/wsl2-install" target="_blank">WSL 2</a>, <a href="https://www.docker.com/" target="_blank">Docker</a>, <a href="https://code.visualstudio.com/" target="_blank">VS Code</a> & <a href="https://devblogs.microsoft.com/commandline/introducing-windows-terminal/" target="_blank">Windows Terminal | Fast & efficient workflow
| CI/CD | <a href="https://azure.microsoft.com/en-gb/services/devops/" target="_blank">Azure DevOps</a> | Desire to learn about the new YAML pipelines

## Next...

I'll dig a little deeper into the dev experience that's now possible on Windows. Here's a little preview :smiley:

{{< figure src="images/devexp.gif" >}}
