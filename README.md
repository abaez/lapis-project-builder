Lapis Project Builder
======================
A [Lapis](http://leafo.net/lapis/) project builder with [docker](https://www.docker.com/)
 [Docker Compose](http://docs.docker.com/compose/) ready and ldoc assembly by
[Alejandro Baez](https://twitter.com/a_baez).

## DESCRIPTION
[Lapis](http://leafo.net/lapis) is a great lua/moonscript web framework. Lapis
already has a project builder for the framework. However, there are couple of
things I use to make my life easier using the already simplified tool.

The purpose of this project builder is to automatically have a set of
configurations for rapid prototyping using a
[Docker](https://www.docker.com/) container for Lapis
 web framework with [Docker Compose](http://docs.docker.com/compose/). As an extra bonus, [LDoc](http://stevedonovan.github.io/ldoc/index.html)
 `config.ld` is added on the set up to help the 'process'. Due to using Lapis
 from a container, you do not require to have it installed on your machine or
 deal with actually getting it installed.

## DEPENDENCIES

*   [Docker](https://www.docker.com/)
    *   [abaez/lapis docker container](https://github.com/abaez/docker-lapis)
*   [Docker Compose](http://docs.docker.com/compose/)

Optional:

*   [LDoc](http://stevedonovan.github.io/ldoc/index.html)
*   [Lapis](http://leafo.net/lapis/)

## INSTALLATION
First make sure you have the [Love2D Project Builder](#) in a local copy.

    hg clone <lapis-project-builder> <your location>
Next link or copy `lapis_init` to your `$PATH` like so:

    ln -s <lapis-builder literal location>/lapis_init.lua ~/bin/lapis_init
Next, when you run `lapis_init` for the first time, it will ask you to use the
`-s` argument parameter if not given. You need to give the source location of
`lapis-project-builder` like so:

    lapis_init -s <lapis-project-builder>
After running the first time, the `-s <src>` argument is optional.
Finally, edit `~/.lapis.init.conf` key `src` to where you have your src:

    inside (~/.lapis.init.conf)
    src = "/your/location/for/lapis-project-builder"

## USAGE
You can run with only the name of the project:

    lapis_init <name>
You can run with project path destination:

    lapis_init <name> -p <path>
You can also use your own location for source of `lapis-project-builder`:

    lapis_init <name> -s <src>
Note that `lapis_init` automatically defaults to mercurial. If you want to use
git simply use the `-g` argument.

    lapis_init <name> -g
Lastly, you can combine commands:

    lapis_init <name> -p <path> -s <src> -g
If you have ldoc installed, then when you already have a project you can run
`ldoc .` to build api documentation.


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


