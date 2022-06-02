#!/bin/bash

#SBATCH -J MPI_TEST # job name
#SBATCH -o log_slurm.o%j # output and error file name (%j expands to jobID)
#SBATCH -n 4 # total number of tasks requested
#SBATCH -N 2 # number of nodes you want to run on
#SBATCH -p gpu # queue (partition)
#SBATCH -t 0:30:00 # run time (hh:mm:ss) - 12.0 hours in this example.

export MPI_EXE=/bsuhome/frankwillmore/scratch/mpi_hello

echo "loading base"

echo "Running on: $(hostname)"

module purge
module load slurm/slurm/19.05.8
module load borah-base

echo "build oneapi-mpi/gcc test:"

module load intel-oneapi-mpi+cuda/2021.6.0/gcc/12.1.0 
module list
echo "mpicc: $(which mpicc )"
mpicc mpi_hello.c -o ${MPI_EXE}
echo "mpirun: $(which mpirun )"
mpirun -ppn 2 -n 4 ${MPI_EXE}
rm ${MPI_EXE}
module unload intel-oneapi-mpi+cuda/2021.6.0/gcc/12.1.0 

echo

echo "build oneapi-mpi/oneapi test:"

module load intel-oneapi-mpi+cuda/2021.6.0/oneapi/2022.1.0
module list
echo "mpicc: $(which mpicc )"
mpicc mpi_hello.c -o ${MPI_EXE}
echo "mpirun: $(which mpirun )"
mpirun -ppn 2 -n 4 ${MPI_EXE}
rm ${MPI_EXE}
module unload intel-oneapi-mpi+cuda/2021.6.0/oneapi/2022.1.0

echo

echo "build mpich/gcc test:"

module load mpich+cuda/3.4.3/gcc/12.1.0
module list
echo "mpicc: $(which mpicc )"
mpicc mpi_hello.c -o ${MPI_EXE}
echo "mpirun: $(which mpirun )"
mpirun -ppn 2 -n 4 ${MPI_EXE}
rm ${MPI_EXE}
module unload mpich+cuda/3.4.3/gcc/12.1.0

echo

echo "build mpich/oneapi test:"

module load mpich+cuda/3.4.3/oneapi/2022.1.0
module list
echo "mpicc: $(which mpicc )"
mpicc mpi_hello.c -o ${MPI_EXE}
echo "mpirun: $(which mpirun )"
mpirun -ppn 2 -n 4 ${MPI_EXE}
rm ${MPI_EXE}
module unload mpich+cuda/3.4.3/oneapi/2022.1.0

echo

echo "build openmpi+cuda/4.1.3/gcc test:"

module load openmpi+cuda/4.1.3/gcc/12.1.0
module list
echo "mpicc: $(which mpicc )"
mpicc mpi_hello.c -o ${MPI_EXE}
echo "mpirun: $(which mpirun )"
mpirun -N 2 -n 4 ${MPI_EXE}
rm ${MPI_EXE}
module unload openmpi+cuda/4.1.3/gcc/12.1.0

echo

echo "build openmpi+cuda/4.1.3/oneapi test:"

module load openmpi+cuda/4.1.3/oneapi/2022.1.0
module list
echo "mpicc: $(which mpicc )"
mpicc mpi_hello.c -o ${MPI_EXE}
echo "mpirun: $(which mpirun )"
mpirun -N 2 -n 4 ${MPI_EXE}
rm ${MPI_EXE}
module unload openmpi+cuda/4.1.3/oneapi/2022.1.0

echo 

echo "Finished mpi_build.sh"

