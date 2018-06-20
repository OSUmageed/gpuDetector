#ifndef DETECT_H
#define DETECT_H

#define RLEN 80

#include <vector>

#include <cstring>
#include <iostream>
#include <sstream>
#include <string>

#include <cuda.h>
#include <cuda_runtime.h>
#include <mpi.h>

struct hname{
    int ng;
    char hostname[RLEN];
};

typedef std::vector<hname> hvec;

int getHost(hvec &ids, hname *newHost);

int detector(const int ranko, const int sz, const bool display=false, const int startpos=1);

void gpuPrinter(const int gpuExist, const int ranko);

#endif