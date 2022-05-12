# Containers

- [Containers](#containers)
- [Useful commands](#useful-commands)


This repository is used to build and push custom containers. Each container has a separate directory, that provides everything it needs, and also exposes a `build()` and a `push()` function inside of a `commands.sh` file. This is the interface that the tooling will consume to interact with each container's directory.

# Useful commands

**`$ NAME=<container_name> make new`**

This command will bootstrap a new container directory, copying the basic `commands.sh.tpl`.

**`$ make build`**

Run the `build()` function of each container directory.

**`$ make deploy`**

Runs both the `build()` and the `push()` function of each container directory.

**`$ make help`**

View all make commands available.
