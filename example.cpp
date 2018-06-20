
#include "gpuDetector.h"

int main(int argc, char *argv[])
{
    int rank, nprocs, gpuHere;

    MPI_Init(&argc, &argv);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Comm_size(MPI_COMM_WORLD, &nprocs);

    if (!rank) std::cout << nprocs << " Processes Launched" << std::endl;

    gpuHere = detector(rank, nprocs, true, 2);

    gpuPrinter(gpuHere, rank);

    MPI_Barrier(MPI_COMM_WORLD);
	MPI_Finalize();

    return 0;
}