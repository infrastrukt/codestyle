## Codestyle tools for Python & JavaScript

Out-of-the-box Docker image with the following tools: [Flake8](http://flake8.readthedocs.org), 
[Closure Linter](https://developers.google.com/closure/utilities/) and [ESLint](http://eslint.org). 
Fully configurable and compatible with JSX.

## Installation

Get a [Docker](https://www.docker.com) if you don't have it yet. If you're on Mac or 
Windows, you'll need a [Docker Machine](https://docs.docker.com/machine/) (works with 
a number of  virtualization providers including VirtualBox, VMware Fusion, cloud providers, 
etc.)  or [Boot2Docker](http://boot2docker.io) (VirtualBox only).

Pull the image:

```sh
$ docker pull ivelum/codestyle:latest
```

## Usage

Create a `codestyle.sh` file in your project root:

```sh
#!/usr/bin/env bash

SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}/" )" && pwd )"
docker run -v $SRC_DIR/:/code/ --rm ivelum/codestyle:latest $*
```

...and grant execution permissions to it:

```sh
$ chmod +x codestyle.sh
```

Now you can run codestyle checks using the script you just created (assuming 
that you're in project root):

```
$ ./codestyle.sh
```

By default, it checks all Python and JS files in your project tree. If your
project has a Git repository, you can also run a faster check of uncommitted
changes only:

```
$ ./codestyle.sh --changes
```

## Configuration

Each tool in the package can be configured individually using its native 
configuration files. You just need to create these files in your project 
root:

* setup.cfg or tox.ini - configuration and ignore options for 
  [Flake8](http://flake8.readthedocs.org/en/latest/config.html);
* .gjslint - configuration and ignore options for 
  [Closure Linter](https://developers.google.com/closure/utilities/docs/linter_howto);
* .eslintignore - [ignore file for ESLint](http://eslint.org/docs/user-guide/configuring#ignoring-files-and-directories);
* .eslintrc - [configuration file for ESLint](http://eslint.org/docs/user-guide/configuring).

For a quick start, check out our 
[sample configuration files](https://github.com/ivelum/codestyle/tree/master/samples).

## Add Git pre-commit hook

This could very convenient to run fast codestyle checks automatically before every commit.
This is pretty easy to do, just execute the following commands from your project root:

```sh
$ echo './codestyle.sh --changes' > .git/hooks/pre-commit
$ chmod +x .git/hooks/pre-commit
```
