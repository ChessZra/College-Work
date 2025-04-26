[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/M-qKf2nz)
# MPI Parallelization of LBM Simulation (100 points)

## Overview

In this assignment, you will parallelize a **2D Lattice Boltzmann (LBM) fluid simulation** using MPI. Building upon the provided serial code, your task is to distribute the computational workload across multiple nodes, handling communication between processes through MPI's message-passing capabilities. The simulation will run on `lakeshore.acer.uic.edu` or `crux.alcf.anl.gov` with at least node counts: **1, 2, 4**.

You will measure execution times (`fluid.csv`) for key simulation components:

- **Computation**: Fluid dynamics calculations including collision, streaming, and boundary handling.
- **Conversion**: Transforming fluid data to pixel buffers for visualization.
- **I/O**: Writing image files to disk.

These timings will be recorded for each timestep, with total execution time measured for **10,000 simulation steps**.

After MPI implementation, you'll analyze parallel performance against the serial baseline, calculating the **speedup** with 4 nodes and generating performance plots **Speedup vs. Serial Baseline** – Execution times comparison (1, 2, 4 nodes).

## Objective and Expected Learning Outcomes

The primary objectives of this assignment are:

- Implement MPI directives for distributed parallelization of a 2D LBM fluid simulation.
- Analyze and visualize performance gains and scaling behaviors.
- Handle inter-node communication explicitly with MPI.

**Outcomes:**

1. **Employ MPI Communication Directives**
   - Distribute data among nodes using MPI send/receive operations (e.g., `MPI_Isend`, `MPI_Irecv`, `MPI_Gather`).
   - Implement ghost cells for halo exchanges to ensure correct boundary data sharing between nodes.

2. **Performance Measurement**
   - Record timings (`fluid.csv`) for computation, conversion, and I/O operations across 10,000 simulation steps.

3. **Speedup and Scaling**
   - Compute speedup metrics relative to a serial execution baseline.
   - Analyze communication overhead introduced by MPI.

4. **Data Analysis**
   - Generate clear performance visualizations:
     - Speedup vs. number of nodes.
     - Computation time per timestep.

4. **Distributed Memory Programming**
   - Gain experience in distributed scientific computing.
   - Manage data dependencies explicitly through ghost cell exchanges and parallel I/O.

## Instructions

1. **Clone and Setup**
   - Accept the assignment via **GitHub Classroom** and clone it to your workspace.
   - Verify correct execution of the provided **serial version** on `lakeshore.acer.uic.edu` or `crux.alcf.anl.gov`.

2. **MPI Parallelization**
   - Include MPI headers (`#include <mpi.h>`) and configure your `Makefile` to compile using MPI (e.g., `mpicc`, `mpicxx`).
   - Integrate MPI functions (e.g., `MPI_Isend`, `MPI_Irecv`, `MPI_Gather`) to manage communication between nodes.

3. **Ghost Cell Implementation**
   - Clearly define ghost cell regions around each node's computational domain.
   - Exchange ghost cell data at each timestep using non-blocking communication.

**High-Level Pseudocode for Ghost Cell Exchange:**

```
function exchangeGhostRows(data, haloThickness, rank, numProcs, comm):

    requests = []

    if rank > 0:
        non-blocking send top boundary rows to rank-1
        non-blocking receive into top ghost rows from rank-1

    if rank < numProcs - 1:
        non-blocking send bottom boundary rows to rank+1
        non-blocking receive into bottom ghost rows from rank+1

    wait for all MPI communications to complete
```

4. **Node Count Experiments**
   - Execute simulations using **1, 2, and 4 nodes**.
   - Run simulations for **10,000 timesteps** and collect runtime data.

4. **Performance Analysis and Visualization**
   - Generate the following plot **Speedup vs. Nodes** (`speedup.png`).

6. **Extra Credit: Performance Competition** (Weekly awards: 3pts first, 2pts second, 1pt third)
   - Submit your speedup weekly creating a GitHub branch `week{0,1,2}-<number of speed up>` (e.g., `week0-32.3`, `week1-48.2`)

## Submission Guidelines and Evaluation Criteria

- Add and/or edit the following files in your GitHub repository:
	- **Original source code** `lbmSimulation-serial.cc` code provided.
	- **Updated source code** `lbmSimulation.cc` using MPI.
   - **Makefile** updated to compile with MPI (that can can build `lbmSimulation` (parallel version), `lbmSimulation-serial` (serial version), `clean` and `all`).
   - **fluid.csv** showcasing at least 1, 2, 4 node results for 10,000 steps.
   - ** speedup.png** and **computation.png**.
   - **reflection.txt** describing your parallelization strategy and findings.
- In this assignment, document your experience parallelizing the LBM fluid simulation in reflection.txt. Describe your approach to parallelizing loops, optimizing workload distribution, and handling synchronization challenges. Compare your strategy and results with the OpenMP implementation, highlighting differences in ease of use, performance, and scalability. Discuss any encountered data races or load-balancing issues and your resolutions. Analyze your observed speedup relative to ideal scaling and identify bottlenecks. Suggest further optimizations or improvements, including adjustments to memory access patterns, scheduling strategies, or alternative parallelization techniques.In this assignment, document your experience parallelizing the LBM fluid simulation in reflection.txt. Describe your approach to parallelizing loops, optimizing workload distribution, and handling synchronization challenges. Compare your strategy and results with the OpenMP implementation, highlighting differences in ease of use, performance, and scalability. Discuss any encountered data races or load-balancing issues and your resolutions. Analyze your observed speedup relative to ideal scaling and identify bottlenecks. Suggest further optimizations or improvements, including adjustments to memory access patterns, scheduling strategies, or alternative parallelization techniques.
- When your program is ready for grading, commit and push your local repository following the Assignment Submission Instructions.
- Your work will be evaluated on your adherence to instructions, code quality, file naming, completeness, and your reflection on the assignment.

## Additional Resources

- [MPI Tutorial](https://mpitutorial.com)
- [MPI Reference Documentation](https://www.open-mpi.org/doc/)
- [Matplotlib Plotting Guide](https://matplotlib.org/stable/tutorials/introductory/pyplot.html)
