# pouchlinter

pouchlinter is a very useful linter tool used in all pouch-related open source golang repositories.

Any project can use pouchlinter to linter code and document.

## Applied Repositories

Lots of container-related open source projects in Alibaba have adopted pouchlinter as a very essential tool to make code and document better. 

* [PouchContainer](https://github.com/alibaba/pouch): an efficient container engine;
* [Dragonfly](https://github.com/alibaba/Dragonfly): a cloud native image distirbution system

## Quick Start

If you are using tool pouchlinter locally, you need to install a container engine(PouchContainer or Docker) since pouchlinter is totally encapsulated in a container image. Because only Linux OS could support container images, **pouchlinter can only be used on Linux OS**.

Here we take PouchContainer as an example.

### Install a Container Engine

It is quite easy to install PouchContainer engine locally, just use `apt-get` or `yum` to make it.

```shell
# install PouchContainer on ubuntu
$ sudo apt-get install pouch
```

or install that on CentOS series:

```shell
# install PouchContainer on CentOS
$ sudo yum install pouch
```

### Pull pouchlinter image

After installing container engine, we could pull pouchlinter image to enable linter functionality:

```shell
# pull pouchlinter images
$ pouch pull pouchcontainer/pouchlinter:v0.1.2
```

### Run pouchlinter locally

Run pouchlinter torwards your target repo or file  is quite simple, only map your local repo or file inside to running container.

``` shell
# check a local file via misspell
$ pouch run -v fileA:/tmp/fileA pouchcontainer/pouchlinter:v0.1.2 misspell /tmp/fileA
```

## Integration with CI 


