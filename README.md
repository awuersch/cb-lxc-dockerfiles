# cb-lxc-dockerfiles
Dockerfiles for Docker images, plus supporting scripts.

These images run in Chromebook LXC containers.
Chrome supports Linux LXC containers under Crostini.

## Thanks and Caveats

Inspired by (@jessfraz) Jessie Frazelle's dockerfiles,
which recommend working in containers.

Note, these files and scripts are _opinionated_ for me.
They try to consistently follow certain conventions,
to be described here.
You might like the conventions, or not.

I can't guarantee, for sure, that their organization will suit you.
With that caveat ..., feel free to reuse.

The scripts use `bash`.
Some scripts may use `python`, often with `jinja`.

I'm in deep debt to:

* too many open source contributors whose source I've read,
* bloggers whose pieces I've read, especially in Medium, and
* @jessfraz as a pioneer.

## What's different?

### My work

I work a lot with Kerberos. Many images here include Kerberos libraries.

Kerberos is a group of secure protocols and services that enable single
sign-on login. Single sign-on is like a passport to applications. Its hope
is that

* You logon once. Then,
* all apps you use will be able to check your credentials.
* And no one will steal your credentials.

Products such as Microsoft's Active Directory use Kerberos at its core.

My general project is called _homespun directory_. It focuses on creating
directories, by which are meant user, group and access supports, for homes,
apartment complexes, and small home businesses. It also tries to use
certificate authorities in a transparent way, in accord with "certificate
transparency".

I prefer Postgres as a database.

Finally, I prefer Python web frameworks, i.e., Django and Flask.

### Focus on Debian

Most images here start from the Linux Debian distribution.
Why Debian?

* Google uses Debian in its Chrome Linux, and also for Kubernetes.
* Debian has the most supported Kerberos software.
* Debian is regularly updated for security.
* Debian is the largest and most widely supported free Linux.

### A Hierarchy of Images

Docker's `FROM` verb lets one image start from another image.
Images here start from a very basic base.

For Debian,
the base,
`debian_base`,
is derived from
Google's Debian base for Kubernetes.

Each image adds libraries to already defined images. So most images
depend on other images.

File `bin/image.order`, in this repo, shows the dependency order.

### Docker Network `my-bridge`

The default Docker network is officially deprecated by Docker,
so we created a Docker network `my-bridge` to run our containers.

You should create `my-bridge` by the following command:

```
$ docker network create my-bridge
```

If you don't create `my-bridge`, commands from this repo _fail_.
So create `my-bridge` now.

### Containers Run as "Me", Not Root

`_me_sudo` images,
and all images depending on them,
add a local user called `me`,
with UID and GID equal to 1000.

How to achieve this is debated.
We preferred to do user creation work in `Dockerfile`.
An alternative, used in @jessfraz scripts,
is to use root to add and switch to a local user
in container initialization.

Our decision is rooted in the Linux environment of
Crostini on a Chromebook. Crostini wraps its Linux users
in LXC containers. The default user of an LXC container
under Crostini has UID and GID 1000.

A related decision is to give `sudo` power to the
local user, so the local user can switch to root when
needed.

We enter
many containers
with `bash`.
We then work
in them
as if
they're our virtual machine.
Often,
we find we need a library
from a package
we didn't know we needed,
in a container.

It's simple, then,
to add that package via `sudo`,
work on,
and decide later
to make yet another container, or
to update the `Dockerfile` of this one.

To make images production-ready,
I would recommend to

* drop `sudo` from `debian_me_sudo`,
* update `FROM` lines from child images accordingly,
* define entrypoints other than `bash`, and
* rebuild the hierarchy.

Some may consider these suggestions obvious.
To them, I'd say: belabor the obvious.

With power scripts and the file `bin/image.order`,
rebuilding is easy.

### Power Scripts

Butler Lampson is famous for his quote, _don't hide power_.

Scripts in `bin` that have

* suffixes such as `_all`, or
* prefixes such as `bulk_`,

are power scripts.
They operate over many images,
instead of
one at a time.

Key to the success of power scripts is file `bin/image.order`.
Using `bin/image.order`
with `tsort`
(a Unix command which stands for "transitive sort"),
one can act on containers from parent to child,
or in the reverse order.

A great help here, with respect to registry access, is (@jessfraz) Jessie
Frazelle's `jess/reg` container.

Warning:
don't use a power script
without
reading it
and understanding it!

Respect warnings.

### A Convenience Script Directory -- "local\_bin"

The directory `$REPO/local_bin`
can be added to the `PATH` variable of a user.
I symbolically link it to my home directory.
Actually, I've made it my `$HOME/bin`.

The key file in `$REPO/local_bin`
is `volumeids.map`. It's used by
scripts `run_bash_l` and `run_bash_c`.

To understand it and
its associated scripts,
one needs to understand
how docker run commands are generated.
And,
to understand that,
one needs to explore
project and volume directory
trees.

### Project and Volume Directory Trees

We're _opinionated_ about projects and volumes.
Why?
Because we use the opinionated structure we set up
to generate docker run commands.

A directory `$REPO/trees` has skeleton project and
volume trees set up as we recommend.

Our rules are hopefully not too complicated.

#### Project Tree Rules

Project tree directories
have the same name
as container images.

Each project tree directory
must have an empty file
with the same name as the directory.

When a container image
becomes a container,
by being run _via_ standard scripts,
it will have

* a home directory called `$MEHOME`, and
* a directory named `$MEHOME/app`.

`$MEHOME/app` is mapped
to a volume
which is
the project tree directory
with the image name.
The volume mapping
ensures that
all work in `$MEHOME/app`
is preserved
in the project tree.
This work will not go
away when the container
is removed.

The empty file
in `$MEHOME/app`,
with a name the same as
the container image,
is a check for the user,
that the directory
`$MEHOME/app` is mapped to
is
what the user expects,
based on the container image.

#### Volume Tree Rules

All directories
mapped as volumes
to containers,
_other than_
the project tree directory
represented as `$MEHOME/app`,
are subtrees
of the volume
tree.

Directory `$REPO/trees/volumes`
has a skeleton volume tree
set up as we recommend.
Its directory names are arbitrary.
The skeleton is
just
what we're using currently.
We're not worried that it is
revealing anything we need to
keep secret.

What matters are the subtree labels.
Specifically, files with names 
starting with `volume`.

Subtrees of the volume tree
are eligible
to be used
as volumes
in a `docker run` command
if and only if
they have a `volume.id` file.
The contents of `volume.id`
is a simple name for a volume.

Other `volume.*` files
in a volume subtree define
what a `docker run` command
will use for its arguments.

* `volume.var` defines variable assignments the `docker run` arguments will use.
* `volume.env` defines `--env` arguments to `docker run`.
* `volume.user` defines `--user` arguments to `docker run`.
* `volume.workdir` defines `--workdir` arguments to `docker run`.
* `volume.device` defines `--device` arguments to `docker run`.
* `volume.map` defines `--volume` arguments to `docker run`.

The assignments in `volume.var` appear before a `docker run` call in the
execution of scripts.

Let's look at the full power made possible by these `volume.*` files.

As an example, run the following
command from `$REPO/local_bin`.
As run here, because the `env`
command presets an environment
variable `DO_RUN_CMD`
to show command arguments
instead of running `docker run`,
this command will have no effect
other than to echo to your console!
```
$ env DO_RUN_CMD=show_run run_pycode_bash_l
```

We're assuming you're in `$REPO/local_bin`
or have it in your `PATH`. The script
`show_run` was created to output how a
`docker run` command will be called to
create a container from an image. The
`run_pycode_bash_l` script is a convenience
script which runs the following:
```
env NAME=buster_krb5_pg_pipenv_code run_bash_l iti me_pycode
```

The `NAME` environment variable assignment
selects a container image.
The `iti` argument to the `run_bash_l` command
requests to use `--interactive --tty --init`
in a generated `docker run` command.
The `me_pycode` argument
to `run_bash_l`
refers to a line
in `$REPO/local_bin/volumeids.map`:
```
me_pycode EVERY ME X11 GIT USERSOCK KRB5 KRB5PG PY PYCODE
```

The line above shows a long list of volume ids.
Each volume id represents the content of a
`volume.id` file in the volume tree. The files
associated with these `volume.id` files
are used
in the generated `docker run` command
to create, start and run a container.

The generated `docker run` command
is huge,
but also very illustrative of the power
of volume ids. Alas, in the wild, this
output is all on one superlong line.
It's reformatted for you here.
The `show_run` command represents
project tree and volume tree bases
with variable names
`$PROJBASE` and `$VOLBASE`.
Further, it represents the user home
directory with variable `$MEHOME`,
and the registry with variable `$REGISTRY`.
We wish we could do more, but this is
better than nothing.
```
--network my-bridge
--interactive --tty --init
--rm
--env SHELL=/bin/bash
--volume /etc/localtime:/etc/localtime:ro
--volume /usr/share/i18n:/usr/share/host-i18n:ro
--volume /usr/share/locale:/usr/share/host-locale:ro
--volume /usr/share/terminfo:/usr/share/host-terminfo:ro
--user 1000:1000
--workdir $MEHOME
--volume $PROJBASE/buster_krb5_pg_pipenv_code:$MEHOME/app:rw
--user 1000:1000
--workdir $MEHOME
--device /dev/snd
--env DISPLAY=unix:0
--volume /tmp/.X11-unix:/tmp/.X11-unix:rw
--volume /tmp/.X1M-unix:/tmp/.X1M-unix:rw
--volume $VOLBASE/git/git:$MEHOME/git:rw
--volume $VOLBASE/git/gitconfig:$MEHOME/.gitconfig:ro
--volume $VOLBASE/usersock/ssh-agent.socket:/run/user/1000/ssh-agent.socket:rw
--volume $VOLBASE/krb5/krb5.conf:/etc/krb5.conf:ro
--volume $VOLBASE/krb5/krb5:/etc/krb5:ro
--volume $VOLBASE/krb5_pg/pguser.keytab:/etc/pguser.keytab:ro
--volume $VOLBASE/pipenv/pg/local:$MEHOME/.local:rw
--volume $VOLBASE/code/pipenv/bashrc:$MEHOME/.bashrc:ro
--volume $VOLBASE/code/pipenv/config:$MEHOME/.config:rw
--volume $VOLBASE/code/pipenv/pki:$MEHOME/.pki:rw
--volume $VOLBASE/code/pipenv/vscode-insiders:$MEHOME/.vscode-insiders:rw
--name buster_krb5_pg_pipenv_code
$REGISTRY/buster_krb5_pg_pipenv_code
bash -l
```

Note the `my-bridge` Docker network,
which you _must create_
for commands from this repository to succeed.
See [here](#docker-network-my-bridge)
for a reminder.

## Where is the Meat?

Most dirs here are container image directories.
Each image directory `$dir` has at least two members:

* a `Dockerfile`
* a build script at `$dir/bin/build_this`.

A _snippet_ is a small piece of code.
A `bash` snippet to find image directories is:

```bash
cd $REPO
for d in $(find . -maxdepth 1 -type d); do
  [[ -f $d/Dockerfile && -f $d/bin/build_this ]] && echo $d
done
```

To build, run `$PWD/bin/build_this` from a container image's directory.
Make sure your current directory is the image directory when you run this.

## My Docker Registry

The `build_this` scripts assume a specific Docker registry,
which is not the Docker public registry.
See Docker documentation on how to set up a secure registry.

My registry

* uses TLS/SSL,
* uses certs from a private certificate authority, and
* uses password authentication.

My registry's password is stored
in base64 encoding
in the standard location,
i.e.,
`~/.docker/config.json`.

My registry is a default, but
you're encouraged
to define and export
an environment variable `REGISTRY`
with the name of
your preferred Docker registry.

Scripts in this repo are written to adapt
to your exported `REGISTRY` definition.

## run_bash Command Usage

The `run_bash` commands
call `docker run`
with appropriate arguments.

Short usage statements:
```
$ run_bash_l
usage: run_bash_l ['i'|'it'|'iti'|'d'|'di'|'init-only'] volumeslabel

$ run_bash_c
usage: run_bash_c ['i'|'it'|'iti'|'d'|'di'|'init-only'] volumeslabel arg ...
```

`run_bash_l`
causes `docker run`
to call `bash -l`.
`run_bash_c`
causes `docker run`
to call `bash -c`.

`bash -l`
starts bash,
calls login scripts,
and delivers a user prompt.
`bash -c`
runs the command
following the `-c` flag
with the bash shell.

A long description explains `run_bash` command detail.
```
second argument options (filling in 'docker run' flags):
  'i' -- '--interactive'
  'it' -- '--interactive --tty'
  'iti' -- '--interactive --tty --init'
  'd' -- '--detach'
  'di' -- '--detach --init'
  'init-only' -- '--init'
files used:
  $REPO_DIR/local_bin/volumeids.map -- maps labels to volume id lists
environment variables affecting run_bash_l:
  NAME [required] -- the container image to run
  DO_RUN_CMD [optional, try 'show_run'] -- 'do_run' replacement
  TRACE [optional] -- if set to 'on', enables Linux strace
  REGISTRY [optional] -- your docker registry
  PROJ_BASE_DIR [optional] -- project dirtree base
  VOL_BASE_DIR [optional] -- volumes dirtree base
  REPO_DIR [optional] -- repository dirtree base
  APPDIR [optional] -- your application work directory
  DOCKER_RUN_CMD [optional] -- 'docker run' replacement
```

If `run_bash_l` or `run_bash_c`
is run
with no arguments,
both the short usage statement
and the long description
will be output
to standard error.

The example [here](#project-and-volume-directory-trees)
is an example of running `run_bash_l`.

### A `run_bash_c` example, in detail.

Here is an example of running `run_bash_c`.
```
env NAME=alpine_pg run_bash_c iti me_pg "psql -h my_host -U my_user mydb"
```

This command:

* runs a `psql` Postgres client
* in a Linux Alpine container,
* under user `me`,
* in working directory `$MEHOME`,
* with a Docker volume pointing to a password file at `$MEHOME/.pgpass`.

Volumeslabel `me_pg` can be found in `$REPO_DIR/local_bin/volumeids.map`.
```
$ grep me_pg local_bin/volumeids.map
me_pg EVERY ME PG
```

The `EVERY ME PG` volume ids listed
under `me_pg`
can be found
in `volume.id` files
under
the repository skeleton
volume tree
`$REPO_DIR/trees/volumes`.
There, we can see `volume.*` files.
```
$ cd $REPO_DIR/trees/volumes
$ cat {every,me,pg}/volume.id
EVERY
ME
PG
$ ls every me pg
every:
volume.env  volume.id  volume.map  volume.var

me:
volume.id  volume.map  volume.user  volume.var  volume.workdir

pg:
volume.id  volume.map
```

These `volume.*` files
are used to generate arguments to
`docker run`
when `run_bash_c` runs
with `DO_RUN_CMD=show_run`.

The `volume.*` files
have simple formats:

* one record per line, and columns separated by spaces.

Let's look at a few of them.
```
$ cat me/volume.map
$APPDIR $MEHOME/app rw
```

`volume.map` defines
Docker volume mappings.
The `$APPDIR` line above
declares a read-write volume,
mapping `$APPDIR`
on the Docker host
to `$MEHOME/app`
in the Docker container.
As discussed earlier [here](#project-and-volume-directory-trees),
by our _opinionated_
project directory rule,
`$APPDIR` is defined
to be a project directory
with the name of the container image.

The `volume.map` file
is converted into
`--volume <source>:<target>:<mode>`
arguments to `docker run`.

```
$ cat me/volume.var
MEHOME /home/me
myUID $(id -u)
myGID $(id -g)
```

A `volume.var` line
has two columns,
i.e., variable and value,
separated by a space.
So,
we know that `$(id -u)`
is a second column,
even though it has
a space in its string.
Why?
A space preceded it
on its line.

This `volume.var`
sets `MEHOME`, `myUID`,
and `myGID` variables.
`run_bash` commands
convert these lines
to `bash` variable
assignment expressions,
such as
`myUID=$(id -u)`,
which runs the Linux
`id` command to find
the UID of the current
user, and then assigns
this UID value (by
default, 1000)
to a variable, `myUID`.
Variables are then
available for later
`bash` expressions.

```
$ cat me/volume.user
$myUID $myGID
```

In `volume.user`,
we see the variables
`myUID` and `myGID`,
defined in `volume.var`,
now in use as expanded
values.

The `volume.user` file
is converted into a
`--user <uid>:<gid>`
argument to `docker run`.

`volume.env`
and `volume.workdir`
files 
are similar.
These are
converted into `--env`
and `--workdir` arguments
to `docker run`
respectively.

Now that we've had a look
at some `volume.*` files,
Here is
our example `run_bash_c` command
with `DO_RUN_CMD` set,
and its output.
```
$ env DO_RUN_CMD=show_run NAME=alpine_pg run_bash_c iti me_pg "psql -h my_host -U my_user mydb"
--network my-bridge --interactive --tty --init --rm --env SHELL=/bin/bash --volume /etc/localtime:/etc/localtime:ro --volume /usr/share/i18n:/usr/share/host-i18n:ro --volume /usr/share/locale:/usr/share/host-locale:ro --volume /usr/share/terminfo:/usr/share/host-terminfo:ro --volume $PROJBASE/alpine_pg:$MEHOME/app:rw --user 1000:1000 --workdir $MEHOME --volume $VOLBASE/pg/pgpass:$MEHOME/.pgpass:ro --name alpine_pg $REGISTRY/alpine_pg bash -c psql -h my_host -U my_user mydb
```

Unfortunately, the output is all on one line.
Output all on one line is very inconvenient to view.

One can format this output further by
piping it through Linux command `fmt`.
`fmt` breaks lines on spaces.
It also
ensures that
formatted lines are
less than
80 characters
long.

Using `fmt`, we get the following:
```
$ env DO_RUN_CMD=show_run NAME=alpine_pg run_bash_c iti me_pg "psql -h my_host -U my_user mydb" | fmt
--network my-bridge --interactive --tty --init --rm --env
SHELL=/bin/bash --volume /etc/localtime:/etc/localtime:ro
--volume /usr/share/i18n:/usr/share/host-i18n:ro --volume
/usr/share/locale:/usr/share/host-locale:ro --volume
/usr/share/terminfo:/usr/share/host-terminfo:ro --volume
$PROJBASE/alpine_pg:$MEHOME/app:rw --user 1000:1000 --workdir $MEHOME
--volume $VOLBASE/pg/pgpass:$MEHOME/.pgpass:ro --name alpine_pg
$REGISTRY/alpine_pg bash -c psql -h my_host -U my_user mydb
```

This output is not ideal,
but still easier to view and read
than output all on one line.

In the output,
note the `my-bridge` Docker network.
You _must create_ this network,
for commands from this repository to succeed.
See [here](#docker-network-my-bridge)
for a reminder.

In the output,
one can see
parts of the `docker run` command
that draw from:

* the `me` directory of the volume tree, and
* the `pg` directory of the volume tree.

Remaining parts draw from the `every` directory of the volume tree.
