Lapis Project Builder
======================
A [Lapis](http://leafo.net/lapis/) project builder with [docker](https://www.docker.com/)
 [fig](http://www.fig.sh/) ready and ldoc assembly by
[Alejandro Baez](https://twitter.com/a_baez).

## DESCRIPTION
[Lapis](http://leafo.net/lapis) is a great lua/moonscript web framework. Lapis
already has a project builder for the framework. However, there are couple of
things I use to make my life easier using the already simplified tool.

The purpose of this project builder is to automatically have a set of
configurations for rapid prototyping using a
[Docker](https://www.docker.com/) container for Lapis
 web framework with [Fig](http://www.fig.sh/). As an extra bonus, [LDoc](http://stevedonovan.github.io/ldoc/index.html)
 `config.ld` is added on the set up to help the 'process'. Due to using Lapis
 from a container, you do not require to have it installed on your machine or
 deal with actually getting it installed.

## DEPENDENCIES

*   [Docker](https://www.docker.com/)
*   [Fig](http://www.fig.sh/)

Optional:

*   [LDoc](http://stevedonovan.github.io/ldoc/index.html)
*   [Lapis](http://leafo.net/lapis/)

## INSTALLATION
First make sure you have the [Lapis Project Builder]() in a local copy.
    hg clone <lapis-builder> <your location>
Incase you want to have `lapis_init.lua` to use your default locations of both
`lapis-builder` and your docker container, edit the conf table fields in
`lapis_init.lua` to your own. Otherwise, you will have to point to the path,
when you using the script. Afterwards, link `lapis_init.lua` into your
preferred path, like so:
    ln -s <lapis-builder literal location>/lapis_init.lua ~/bin/lapis_init

## USAGE
Run `lapis_init`, the help menu should say how to make a lapis project.

You can use the lapis docker container by running `fig up` inside the
directory of your lapis project that was initialized by `lapis_init`.

To make use of ldoc, run `ldoc .` in the root of the lapis project.


## LICENSE
Copyright (c) 2014 Alejandro Baez

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


