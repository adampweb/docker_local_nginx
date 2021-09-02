# Basic Nginx image <br/><small>with a bit of customization</small>

## Introduction

The source of this build is the [official Nginx (version: 1.21.1) image](https://hub.docker.com/_/nginx) 
from [Docker Hub](https://hub.docker.com/). I copy the original **nginx.conf** to the image because this
mode facilitates later modification. But I always install a CLI text editor 
(e.g.: [nano](https://www.nano-editor.org/)) into my Docker projects.

## How to use
I did not plan this for direct use, but you can create a stand-alone project with it. I did plan it as a source image
of more customized projects e.g.: combined with PHP container with [Docker-Compose](https://docs.docker.com/compose/) 
for web-applications.

