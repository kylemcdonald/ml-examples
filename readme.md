# ml-examples

These examples are meant to run inside [ml-notebook](https://github.com/kylemcdonald/ml-notebook).

To get started, first set up ml-notebook, but before calling `./run.sh` clone this repository and pull the submodules:

```
$ cd ml-notebook/shared
$ git https://github.com/kylemcdonald/ml-examples.git && cd ml-examples
$ git submodule init # registers submodules with git
$ git submodule update # pulls content of submodule repos
```

Then you can start ml-notebook and have access to the examples inside `ml-examples`.