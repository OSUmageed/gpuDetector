# gpuDetector
Finds GPUs by PCI ids and assigns them to MPI process.
For usage in C/C++ projects.

Assigns individual GPUs to individual MPI processes using PCI hardware ids to avoid clashes.

## Dependencies

Any version should work

* CUDA
* MPI

## Installation
``` 
make
make install
```

This will install it to /usr/lib && /usr/include but if you don't have root you can just include the files in your project and link them in your makefile.

## Test
Test it out by running 
```
make runtest
```

## Usage
Library has two public functions: 
* detector: Finds gpus and assigns them to specific processes.
* gpuPrinter: Prints out details of assignment.

Include it in your project using:
```
#include "gpuDetector.h"
...
//Start MPI PROCESSES
int iHaveAGPU = detector(rank, numberofMPIProcesses, includeDisplayGPUs?=false, initialRank=1);

if(iHaveAGPU) { 
    //DO GPU STUFF
}

```

The detector function begins assigning gpus to process number _initialRank_. 
So, if there are 4 gpus on a node with 20 processes and _initialRank_ is set to 2, ranks 2, 3, 4, 5 will get gpus.
You can exclude display GPUs by setting the third argument to false which is the default argument.
If you want to use the display GPU for computation, set it to true.

## Future Plans

* Option to test all visible GPUs and assign them to "closest" processes.
* Option to set multiple GPUs to a process
* Option to stride GPU assignments, e.g. ranks 2, 4, 6, 8.
* Map of output -- i.e. ascii drawing.

