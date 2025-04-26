[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/5GkrDb0I)
# OpenMP Parallelization of LBM Simulation (100 points)

## Weekly Speedup Challenge
<table>
  <tr>
    <th>Week</th>
    <th colspan="3">Results (speedup)</th>
  </tr>
  <tr>
    <td><b>One</b> (02/25)</td>
    <td>🥇</td>
    <td>🥈</td>
    <td>🥉</td>
  </tr>
  <tr>
    <td><b>Two</b> (03/04)</td>
    <td>🥇</td>
    <td>🥈</td>
    <td>🥉</td>
  </tr>
  <tr>
    <td><b>Three</b> (03/11)</td>
    <td>🥇</td>
    <td>🥈</td>
    <td>🥉</td>
  </tr>
</table>

## Overview  

In this assignment, you will parallelize a **2D Lattice Boltzmann (LBM) fluid simulation** using OpenMP. Building upon the provided serial code, your goal is to introduce multi-threading and evaluate its impact on performance. The simulation will be executed on `cs455.cs.uic.edu` using varying thread counts: **1, 2, 4, 8, and 16**. The baseline for `cs455` machine is **3756.8544s**. 

Inorder to get **75** points you must get at least **1.5x** or **6.0x** speedup for **85** points, these are base numbers, plots and reflection add value to your final score.

To assess the effectiveness of parallelization, you will record execution times (`fluid.csv`) for key components of the simulation, including:  

- **Computation**: The core fluid flow calculations, encompassing collision, streaming, and bounce-back operations.  
- **Conversion**: The process of transforming fluid data into a pixel buffer for visualization.  
- **I/O**: Writing the generated images to disk.  

At each timestep, these timings will be logged in a CSV file, and the **total execution time** for a **10,000-step simulation** will be measured.  

After implementing OpenMP, you will compare the performance of the parallelized version against the serial implementation, calculating the **speedup** achieved with 16 threads. Finally, two performance plots will be generated:  

1. **Speedup vs. Serial Baseline** – A comparison of execution time across different thread counts (1, 2, 4, 8, 16).  
2. **Time per Timestep vs. Timestep** – A visualization of computation time per step as recorded in the CSV file.  

Through this process, you will gain insight into how OpenMP scales computational workloads and impacts performance in fluid simulations.

## Objective and Expected Learning Outcomes

The primary objectives of this assignment are:

- Implement OpenMP directives to parallelize a 2D Lattice Boltzmann (LBM) fluid simulation.
- Measure and analyze the performance improvements gained through parallelization.
- Visualize speedup and scaling behavior using performance plots.

**Outcomes:**

1. **Employ OpenMP Directives**  
   - Insert OpenMP pragmas (`#pragma omp ...`) in the LBM simulation code to parallelize loops over the grid.  
   - Use techniques like `parallel for`, `reduction`, and scheduling to optimize performance.  

2. **Benchmarking and Timing**  
   - Measure wall-clock time for key components (simulation, image conversion, file I/O).  
   - Log timings to a CSV file and analyze the impact of parallelization on each step.  

3. **Speedup and Scaling**  
   - Calculate the speedup for multiple thread counts compared to the serial baseline.  
   - Identify bottlenecks and discuss theoretical vs. observed speedup.  

4. **Data Analysis**  
   - Generate plots to illustrate performance metrics:  
     - Speedup vs. number of threads.  
     - Timestep duration vs. timestep index.  
   - Use appropriate labels, scales, and formatting for clear communication of results.  

5. **Practical Parallel Programming**  
   - Gain experience in parallelizing real-world-like scientific simulations.  
   - Understand how memory access patterns, loop scheduling, and load balancing impact performance.  

## Instructions

1. **Clone and Setup**  
   - Accept the project assignment on **GitHub Classroom** and clone the repository to your preferred working environment.  
   - Ensure that all **experiments and performance evaluations** are conducted on `cs455.cs.uic.edu`.  
   - Compile and run the **serial version** of the code to verify correctness before proceeding.  

2. **OpenMP Parallelization**  
   - Add `#include <omp.h>` to the necessary files and enable **OpenMP support** in the `Makefile` using the appropriate compiler flags (e.g., `-fopenmp`).  
   - Modify the code to allow execution with multiple threads while maintaining correctness and ensuring reduction operations, such as summations and minimum/maximum calculations if used are properly handled to avoid race conditions.  

3. **Thread Count Experiments**  
   - Run the simulation with **1, 2, 4, 8, and 16** threads.  
   - Use **10,000 time steps** (instead of the default 50,000) to balance runtime efficiency with meaningful performance insights.  
   - Collect total runtime and per-step timings (collision, conversion, and writing) from the **CSV logs**.  

5. **Performance Analysis**  
   - Using your collected CSV data, generate the following plots with a tool of your choice (e.g., Python/Matplotlib):  
     1. **Speedup vs. Threads**  
        	- **x-axis**: Number of threads (1, 2, 4, 8, 16)  
        	- **y-axis**: Speedup = $\left(\frac{T_\text{serial}}{T_\text{parallel}}\right)$  
     2. **Time per Timestep**
      		- **x-axis**: Timestep index (0 to 10,000)  
        	- **y-axis**: Time per timestep (seconds or milliseconds) for **Computation**

   - Save the plots as:  
     - `speedup.png`  
     - `computation.png`  
7. **Compete for Fastest Code**  (**Extra Credit:** 3pts for first, 2pts for second, 1pts for third, each week)
   - Run the **original serial code** (or set `OMP_NUM_THREADS=1`) to establish a baseline performance metric.  
   - Compare the **16-thread performance** against this serial baseline (**3756.8544s**) to compute speedup using: Speedup = $\left(\frac{T_\text{serial}}{T_\text{parallel}}\right)$
   - Create a branch `week{0,1,2}-<number of speed up>` (e.g., `week0-32.3`, `week1-48.2`)
   

## Submission Guidelines and Evaluation Criteria

- Add and/or edit the following files in your GitHub repository:
	- **Original source code** `lbmSimulation-serial.cc` code provided.
	- **Updated source code** `lbmSimulation.cc` with OpenMP directives.
   	- **Makefile** updated to compile with OpenMP flags (e.g., `-fopenmp`), can can build `lbmSimulation` (parallel version), `lbmSimulation-serial` (serial version), `clean` and `all`.
   	- **fluid.csv** showcasing at least 1, 2, 4, 8, 16 threads results for 10,000 steps.
   	- **speedup.png** and **computation.png**.
   	- **reflection.txt** describing your parallelization strategy and findings.
- Document your experience parallelizing the LBM fluid simulation in `reflection.txt` for this assignment. Describe your approach to parallelizing loops and optimizing workload distribution. Discuss any synchronization challenges, data races, or load balancing issues you encountered and how you resolved them. Analyze the observed speedup compared to ideal scaling, identifying potential bottlenecks. Finally, suggest optimizations or future improvements, considering factors like memory access patterns, scheduling strategies, and alternative parallelization techniques.
- When your program is ready for grading, commit and push your local repository following the Assignment Submission Instructions.
- The baseline for `cs455` machine is **3756.8544s**. Inorder to get **75** points you must get at least **1.5x** or **6.0x** speedup for **85** points, these are base numbers, plots and reflection add value to your final score.
- Your work will be evaluated on your adherence to instructions, code quality, file naming, completeness, and your reflection on the assignment.

## Additional Resources

- [OpenMP Tutorial](https://www.openmp.org/resources/tutorials-articles/)
- [GNU OpenMP documentation](https://gcc.gnu.org/onlinedocs/libgomp/)
- [Best Practices for Parallelizing Loops with OpenMP](https://hpc-tutorials.llnl.gov/openmp/)
- [Plotting with Python’s Matplotlib](https://matplotlib.org/stable/tutorials/introductory/pyplot.html)
