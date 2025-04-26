#include <cmath>
#include <cstdint>
#include <memory>
#include <iostream>
#include <fstream>
#include <iomanip>
#include <sstream>
#include <algorithm>
#include <chrono>
#include <vector>
#include <limits>
#include <string>

/**
 * @file lbmSimulation.cc
 * @brief A 2D Lattice Boltzmann (LBM) simulation for computational fluid dynamics.
 *
 * This simulation uses a D2Q9 LBM model to simulate fluid flow, including
 * collision, streaming, and bounce-back boundary conditions.
 */

enum BarrierType
{
    barrierOffsetMid,   ///< Barrier offset at mid-height.
    barrierCenterGap    ///< Barrier with a central gap.
};

enum FluidProperty
{
    density,    ///< Use density as the fluid property.
    speed,      ///< Use speed as the fluid property.
    vorticity   ///< Use vorticity as the fluid property.
};

// -----------------------------------------------------------------------------
// Data structure to hold all relevant LBM fields
// -----------------------------------------------------------------------------
struct LBMData
{
    // Simulation grid dimensions.
    uint32_t dimX;         ///< Number of grid cells in the x-direction.
    uint32_t dimY;         ///< Number of grid cells in the y-direction.

    // Contiguous storage for distribution functions and derived data.
    // The layout of the 14 subarrays (each of size dimX * dimY) is as follows:
    //   f0, fN, fE, fS, fW, fNE, fNW, fSE, fSW,
    //   density, velocityX, velocityY, vorticity, speed
    std::unique_ptr<double[]> data;  ///< Big array of size 14 * (dimX * dimY)

    // Pointers into the 'data' array:
    double* f0;         ///< Rest distribution function.
    double* fN;         ///< North distribution function.
    double* fE;         ///< East distribution function.
    double* fS;         ///< South distribution function.
    double* fW;         ///< West distribution function.
    double* fNE;        ///< North-East distribution function.
    double* fNW;        ///< North-West distribution function.
    double* fSE;        ///< South-East distribution function.
    double* fSW;        ///< South-West distribution function.
    double* density;    ///< Macroscopic density.
    double* velocityX;  ///< Macroscopic velocity in the x-direction.
    double* velocityY;  ///< Macroscopic velocity in the y-direction.
    double* vorticity;  ///< Vorticity of the flow.
    double* speed;      ///< Speed (magnitude of velocity).

    // Barrier array (true if the cell is a barrier).
    std::unique_ptr<bool[]> barrier;
};

// -----------------------------------------------------------------------------
// createLBMData()
// -----------------------------------------------------------------------------
LBMData createLBMData(uint32_t width, uint32_t height)
{
    LBMData lbmData;

    lbmData.dimX = width;
    lbmData.dimY = height;

    // Total number of cells in the simulation grid.
    const uint32_t size = lbmData.dimX * lbmData.dimY;
    lbmData.data = std::unique_ptr<double[]>(new double[14 * size]);

    // Assign pointers to each region in the contiguous block.
    lbmData.f0         = lbmData.data.get() + 0 * size;
    lbmData.fN         = lbmData.data.get() + 1 * size;
    lbmData.fE         = lbmData.data.get() + 2 * size;
    lbmData.fS         = lbmData.data.get() + 3 * size;
    lbmData.fW         = lbmData.data.get() + 4 * size;
    lbmData.fNE        = lbmData.data.get() + 5 * size;
    lbmData.fNW        = lbmData.data.get() + 6 * size;
    lbmData.fSE        = lbmData.data.get() + 7 * size;
    lbmData.fSW        = lbmData.data.get() + 8 * size;
    lbmData.density    = lbmData.data.get() + 9  * size;
    lbmData.velocityX  = lbmData.data.get() + 10 * size;
    lbmData.velocityY  = lbmData.data.get() + 11 * size;
    lbmData.vorticity  = lbmData.data.get() + 12 * size;
    lbmData.speed      = lbmData.data.get() + 13 * size;

    // Allocate the barrier array.
    lbmData.barrier = std::unique_ptr<bool[]>(new bool[size]);

    return lbmData;
}

// -----------------------------------------------------------------------------
// destroyLBMData()
// -----------------------------------------------------------------------------
void destroyLBMData(LBMData& /*lbmData*/)
{
    // Memory is automatically freed by unique_ptr.
}

// -----------------------------------------------------------------------------
// setEquilibrium()
// -----------------------------------------------------------------------------
static void setEquilibrium(LBMData& lbmData,
                           int x, int y,
                           double newVelocityX,
                           double newVelocityY,
                           double newDensity)
{
    const int idx = y * lbmData.dimX + x;

    const double oneNinth       = 1.0 / 9.0;
    const double fourNinths     = 4.0 / 9.0;
    const double oneThirtySixth = 1.0 / 36.0;

    const double velocity3X = 3.0 * newVelocityX;
    const double velocity3Y = 3.0 * newVelocityY;
    const double velocityX2 = newVelocityX * newVelocityX;
    const double velocityY2 = newVelocityY * newVelocityY;
    const double velocity2XY = 2.0 * newVelocityX * newVelocityY;
    const double velocity2 = velocityX2 + velocityY2;
    const double velocity2Factor = 1.5 * velocity2;

    lbmData.f0[idx]  = fourNinths * newDensity * (1.0 - velocity2Factor);
    lbmData.fE[idx]  = oneNinth * newDensity * (1.0 + velocity3X + 4.5 * velocityX2 - velocity2Factor);
    lbmData.fW[idx]  = oneNinth * newDensity * (1.0 - velocity3X + 4.5 * velocityX2 - velocity2Factor);
    lbmData.fN[idx]  = oneNinth * newDensity * (1.0 + velocity3Y + 4.5 * velocityY2 - velocity2Factor);
    lbmData.fS[idx]  = oneNinth * newDensity * (1.0 - velocity3Y + 4.5 * velocityY2 - velocity2Factor);
    lbmData.fNE[idx] = oneThirtySixth * newDensity * (1.0 + velocity3X + velocity3Y
                                                   + 4.5 * (velocity2 + velocity2XY) - velocity2Factor);
    lbmData.fSE[idx] = oneThirtySixth * newDensity * (1.0 + velocity3X - velocity3Y
                                                   + 4.5 * (velocity2 - velocity2XY) - velocity2Factor);
    lbmData.fNW[idx] = oneThirtySixth * newDensity * (1.0 - velocity3X + velocity3Y
                                                   + 4.5 * (velocity2 - velocity2XY) - velocity2Factor);
    lbmData.fSW[idx] = oneThirtySixth * newDensity * (1.0 - velocity3X - velocity3Y
                                                   + 4.5 * (velocity2 + velocity2XY) - velocity2Factor);

    lbmData.density[idx]   = newDensity;
    lbmData.velocityX[idx] = newVelocityX;
    lbmData.velocityY[idx] = newVelocityY;
}

// -----------------------------------------------------------------------------
// initBarrier()
// -----------------------------------------------------------------------------
void initBarrier(LBMData& lbmData, BarrierType barrierType)
{
    for (int j = 0; j < static_cast<int>(lbmData.dimY); j++)
    {
        const int row = j * lbmData.dimX;
        for (int i = 0; i < static_cast<int>(lbmData.dimX); i++)
        {
            switch (barrierType)
            {
            case barrierOffsetMid:
                if ((i == static_cast<int>(lbmData.dimX) / 8 ||
                     i == static_cast<int>(lbmData.dimX) / 8 + 1) &&
                    j > 8 * static_cast<int>(lbmData.dimY) / 27 &&
                    j < 17 * static_cast<int>(lbmData.dimY) / 27)
                {
                    lbmData.barrier[row + i] = true;
                }
                else
                {
                    lbmData.barrier[row + i] = false;
                }
                break;

            case barrierCenterGap:
                if ((i == static_cast<int>(lbmData.dimX) / 8 ||
                     i == static_cast<int>(lbmData.dimX) / 8 + 1) &&
                    ((j > 8 * static_cast<int>(lbmData.dimY) / 27 &&
                      j < 12 * static_cast<int>(lbmData.dimY) / 27) ||
                     (j > 13 * static_cast<int>(lbmData.dimY) / 27 &&
                      j < 17 * static_cast<int>(lbmData.dimY) / 27)))
                {
                    lbmData.barrier[row + i] = true;
                }
                else
                {
                    lbmData.barrier[row + i] = false;
                }
                break;

            default:
                lbmData.barrier[row + i] = false;
                break;
            }
        }
    }
}

// -----------------------------------------------------------------------------
// initFluid()
// -----------------------------------------------------------------------------
void initFluid(LBMData& lbmData, double speed)
{
    for (int j = 0; j < static_cast<int>(lbmData.dimY); j++)
    {
        const int row = j * lbmData.dimX;
        for (int i = 0; i < static_cast<int>(lbmData.dimX); i++)
        {
            setEquilibrium(lbmData, i, j, speed, 0.0, 1.0);
            lbmData.vorticity[row + i] = 0.0;
        }
    }
}

// -----------------------------------------------------------------------------
// collide()
// -----------------------------------------------------------------------------
void collide(LBMData& lbmData, double viscosity)
{
    const double omega = 1.0 / (3.0 * viscosity + 0.5); // Relaxation parameter

    for (int j = 1; j < static_cast<int>(lbmData.dimY) - 1; j++)
    {
        const int row = j * lbmData.dimX;
        for (int i = 1; i < static_cast<int>(lbmData.dimX) - 1; i++)
        {
            const int idx = row + i;

            // Compute macroscopic density.
            lbmData.density[idx] =
                lbmData.f0[idx] + lbmData.fN[idx] + lbmData.fS[idx] +
                lbmData.fE[idx] + lbmData.fW[idx] +
                lbmData.fNW[idx] + lbmData.fNE[idx] + lbmData.fSW[idx] + lbmData.fSE[idx];

            // Compute macroscopic velocities.
            lbmData.velocityX[idx] =
                (lbmData.fE[idx] + lbmData.fNE[idx] + lbmData.fSE[idx] -
                 lbmData.fW[idx] - lbmData.fNW[idx] - lbmData.fSW[idx]) /
                lbmData.density[idx];

            lbmData.velocityY[idx] =
                (lbmData.fN[idx] + lbmData.fNE[idx] + lbmData.fNW[idx] -
                 lbmData.fS[idx] - lbmData.fSE[idx] - lbmData.fSW[idx]) /
                lbmData.density[idx];

            // Precompute equilibrium coefficients.
            const double oneNinthDensity       = (1.0 / 9.0)  * lbmData.density[idx];
            const double fourNinthsDensity     = (4.0 / 9.0)  * lbmData.density[idx];
            const double oneThirtySixthDensity = (1.0 / 36.0) * lbmData.density[idx];

            const double velocity3X = 3.0 * lbmData.velocityX[idx];
            const double velocity3Y = 3.0 * lbmData.velocityY[idx];
            const double velocityX2 = lbmData.velocityX[idx] * lbmData.velocityX[idx];
            const double velocityY2 = lbmData.velocityY[idx] * lbmData.velocityY[idx];
            const double velocity2XY = 2.0 * lbmData.velocityX[idx] * lbmData.velocityY[idx];
            const double velocity2 = velocityX2 + velocityY2;
            const double velocity2Factor = 1.5 * velocity2;

            // Relaxation toward equilibrium for each distribution function.
            lbmData.f0[idx] += omega * (fourNinthsDensity * (1.0 - velocity2Factor) - lbmData.f0[idx]);
            lbmData.fE[idx] += omega * (oneNinthDensity * (1.0 + velocity3X + 4.5 * velocityX2 - velocity2Factor) - lbmData.fE[idx]);
            lbmData.fW[idx] += omega * (oneNinthDensity * (1.0 - velocity3X + 4.5 * velocityX2 - velocity2Factor) - lbmData.fW[idx]);
            lbmData.fN[idx] += omega * (oneNinthDensity * (1.0 + velocity3Y + 4.5 * velocityY2 - velocity2Factor) - lbmData.fN[idx]);
            lbmData.fS[idx] += omega * (oneNinthDensity * (1.0 - velocity3Y + 4.5 * velocityY2 - velocity2Factor) - lbmData.fS[idx]);
            lbmData.fNE[idx] += omega * (oneThirtySixthDensity * (1.0 + velocity3X + velocity3Y
                            + 4.5 * (velocity2 + velocity2XY) - velocity2Factor) - lbmData.fNE[idx]);
            lbmData.fSE[idx] += omega * (oneThirtySixthDensity * (1.0 + velocity3X - velocity3Y
                            + 4.5 * (velocity2 - velocity2XY) - velocity2Factor) - lbmData.fSE[idx]);
            lbmData.fNW[idx] += omega * (oneThirtySixthDensity * (1.0 - velocity3X + velocity3Y
                            + 4.5 * (velocity2 - velocity2XY) - velocity2Factor) - lbmData.fNW[idx]);
            lbmData.fSW[idx] += omega * (oneThirtySixthDensity * (1.0 - velocity3X - velocity3Y
                            + 4.5 * (velocity2 + velocity2XY) - velocity2Factor) - lbmData.fSW[idx]);
        }
    }
}

// -----------------------------------------------------------------------------
// stream()
// -----------------------------------------------------------------------------
void stream(LBMData& lbmData)
{
    // NW direction streaming.
    for (int j = static_cast<int>(lbmData.dimY) - 2; j > 0; j--)
    {
        const int row  = j * lbmData.dimX;
        const int rowp = (j - 1) * lbmData.dimX;
        for (int i = 1; i < static_cast<int>(lbmData.dimX) - 1; i++)
        {
            lbmData.fN[row + i]  = lbmData.fN[rowp + i];
            lbmData.fNW[row + i] = lbmData.fNW[rowp + i + 1];
        }
    }

    // NE direction streaming.
    for (int j = static_cast<int>(lbmData.dimY) - 2; j > 0; j--)
    {
        const int row  = j * lbmData.dimX;
        const int rowp = (j - 1) * lbmData.dimX;
        for (int i = static_cast<int>(lbmData.dimX) - 2; i > 0; i--)
        {
            lbmData.fE[row + i]  = lbmData.fE[row + i - 1];
            lbmData.fNE[row + i] = lbmData.fNE[rowp + i - 1];
        }
    }

    // SE direction streaming.
    for (int j = 1; j < static_cast<int>(lbmData.dimY) - 1; j++)
    {
        const int row  = j * lbmData.dimX;
        const int rown = (j + 1) * lbmData.dimX;
        for (int i = static_cast<int>(lbmData.dimX) - 2; i > 0; i--)
        {
            lbmData.fS[row + i]  = lbmData.fS[rown + i];
            lbmData.fSE[row + i] = lbmData.fSE[rown + i - 1];
        }
    }

    // SW direction streaming.
    for (int j = 1; j < static_cast<int>(lbmData.dimY) - 1; j++)
    {
        const int row  = j * lbmData.dimX;
        const int rown = (j + 1) * lbmData.dimX;
        for (int i = 1; i < static_cast<int>(lbmData.dimX) - 1; i++)
        {
            lbmData.fW[row + i]  = lbmData.fW[row + i + 1];
            lbmData.fSW[row + i] = lbmData.fSW[rown + i + 1];
        }
    }
}

// -----------------------------------------------------------------------------
// bounceBackStream()
// -----------------------------------------------------------------------------
void bounceBackStream(LBMData& lbmData)
{
    for (int j = 1; j < static_cast<int>(lbmData.dimY) - 1; j++)
    {
        const int row  = j * lbmData.dimX;
        const int rowp = (j - 1) * lbmData.dimX;
        const int rown = (j + 1) * lbmData.dimX;
        for (int i = 1; i < static_cast<int>(lbmData.dimX) - 1; i++)
        {
            const int idx = row + i;
            // Bounce-back from neighboring barriers.
            if (lbmData.barrier[row + i - 1])
            {
                lbmData.fE[idx] = lbmData.fW[row + i - 1];
            }
            if (lbmData.barrier[row + i + 1])
            {
                lbmData.fW[idx] = lbmData.fE[row + i + 1];
            }
            if (lbmData.barrier[rowp + i])
            {
                lbmData.fN[idx] = lbmData.fS[rowp + i];
            }
            if (lbmData.barrier[rown + i])
            {
                lbmData.fS[idx] = lbmData.fN[rown + i];
            }
            if (lbmData.barrier[rowp + i - 1])
            {
                lbmData.fNE[idx] = lbmData.fSW[rowp + i - 1];
            }
            if (lbmData.barrier[rowp + i + 1])
            {
                lbmData.fNW[idx] = lbmData.fSE[rowp + i + 1];
            }
            if (lbmData.barrier[rown + i - 1])
            {
                lbmData.fSE[idx] = lbmData.fNW[rown + i - 1];
            }
            if (lbmData.barrier[rown + i + 1])
            {
                lbmData.fSW[idx] = lbmData.fNE[rown + i + 1];
            }
        }
    }
}

// -----------------------------------------------------------------------------
// checkStability()
// -----------------------------------------------------------------------------
bool checkStability(const LBMData& lbmData)
{
    bool stable = true;
    const int midY = lbmData.dimY / 2;
    const int row = midY * lbmData.dimX;

    for (int i = 0; i < static_cast<int>(lbmData.dimX); i++)
    {
        if (lbmData.density[row + i] <= 0)
        {
            stable = false;
            break;
        }
    }
    return stable;
}

// -----------------------------------------------------------------------------
// computeSpeed()
// -----------------------------------------------------------------------------
void computeSpeed(LBMData& lbmData)
{
    for (int j = 1; j < static_cast<int>(lbmData.dimY) - 1; j++)
    {
        const int row = j * lbmData.dimX;
        for (int i = 1; i < static_cast<int>(lbmData.dimX) - 1; i++)
        {
            const int idx = row + i;
            lbmData.speed[idx] = std::sqrt(lbmData.velocityX[idx] * lbmData.velocityX[idx] +
                                           lbmData.velocityY[idx] * lbmData.velocityY[idx]);
        }
    }
}

// -----------------------------------------------------------------------------
// computeVorticity()
// -----------------------------------------------------------------------------
void computeVorticity(LBMData& lbmData)
{
    for (int j = 1; j < static_cast<int>(lbmData.dimY) - 1; j++)
    {
        const int row  = j * lbmData.dimX;
        const int rowp = (j - 1) * lbmData.dimX;
        const int rown = (j + 1) * lbmData.dimX;
        for (int i = 1; i < static_cast<int>(lbmData.dimX) - 1; i++)
        {
            // Approximate finite differences (ignoring constant factors).
            lbmData.vorticity[row + i] =
                lbmData.velocityY[row + i + 1] - lbmData.velocityY[row + i - 1] -
                lbmData.velocityX[rown + i]    + lbmData.velocityX[rowp + i];
        }
    }
}

// -----------------------------------------------------------------------------
// Getter functions for demonstration
// -----------------------------------------------------------------------------
bool* getBarrier(LBMData& lbmData) { return lbmData.barrier.get(); }
double* getDensity(LBMData& lbmData) { return lbmData.density; }
double* getVorticity(LBMData& lbmData) { return lbmData.vorticity; }
double* getSpeed(LBMData& lbmData) { return lbmData.speed; }

// -----------------------------------------------------------------------------
// mapDensityToColor()
// -----------------------------------------------------------------------------
void mapDensityToColor(double value,
    uint8_t& r, uint8_t& g, uint8_t& b,
    bool isBarrier,
    double minValue,
    double maxValue)
{
    if (isBarrier)
    {
        // For barriers, use red.
        r = 255; g = 0; b = 0;
        return;
    }

    double deltaBelow = 1.0 - minValue;
    double deltaAbove = maxValue - 1.0;
    double delta = std::max(deltaBelow, deltaAbove);
    if (delta <= 0) delta = 1.0;

    double deviation = std::fabs(value - 1.0) / delta;
    deviation = std::min(1.0, deviation);
    uint8_t grey = static_cast<uint8_t>(255 * (1.0 - deviation));

    r = grey;
    g = grey;
    b = grey;
}

// -----------------------------------------------------------------------------
// main()
// -----------------------------------------------------------------------------
/**
 * @brief Entry point for the LBM simulation.
 *
 * If the command-line flag "--movie" is provided, a series of frames are saved with unique filenames.
 * Otherwise (default debug mode), a single image file is updated every timestep.
 */
int main(int argc, char** argv)
{
    // Determine if movie mode is enabled.
    bool movieMode = false;
    for (int i = 1; i < argc; i++)
    {
        if (std::string(argv[i]) == "--movie")
        {
            movieMode = true;
            break;
        }
    }

    // Global simulation parameters.
    const uint32_t dimX = 1920; // Grid width.
    const uint32_t dimY = 1024; // Global grid height.
    uint32_t timeSteps = 10000; // Total timesteps.
    uint32_t saveInterval = 100; // Save every saveInterval timesteps.
    BarrierType selectedBarrier = barrierCenterGap;
    FluidProperty selectedFluidProperty = vorticity;

    // Physical properties.
    double physicalDensity = 1380.0;
    double physicalSpeed = 1.0;
    double physicalLength = 2.0;
    double physicalViscosity = 0.75;
    double physicalTime = 0.4;
    double physicalFreq = 0.04;
    double reynoldsNumber = (physicalDensity * physicalSpeed * physicalLength) / physicalViscosity;

    // Convert physical properties into simulation properties.
    double simulationDx        = physicalLength / static_cast<double>(dimY);
    double simulationDt        = physicalTime / static_cast<double>(timeSteps);
    double simulationSpeed     = (simulationDt / simulationDx) * physicalSpeed;
    double simulationViscosity = simulationDt / (simulationDx * simulationDx * reynoldsNumber);

    std::cout << std::fixed << std::setprecision(6)
              << "LBM-CFD> speed: "     << simulationSpeed
              << ", viscosity: "        << simulationViscosity
              << ", reynolds: "         << reynoldsNumber
              << std::endl << std::endl;

    // Create the LBM data structure.
    LBMData lbmData = createLBMData(dimX, dimY);
    initBarrier(lbmData, selectedBarrier);
    initFluid(lbmData, simulationSpeed);

    // Parameters for mapping density to color.
    double minValue = 0.908812;
    double maxValue = 1.04644;

    // Open CSV file for timing output.
    std::ofstream csvFile("fluid.csv");
    if (!csvFile.is_open())
    {
        std::cerr << "Error: Could not open fluid.csv for writing." << std::endl;
        return 1;
    }
    csvFile << "Timestep,SimStepTime,ImageConversionTime,ImageWriteTime\n";

    // Simulation loop variables.
    int outputCount = 0;
    double outputTime = 0.0;
    auto totalStart = std::chrono::high_resolution_clock::now();

    for (uint32_t t = 0; t < timeSteps; t++)
    {
        double conversionTime = 0.0;
        double writeTime = 0.0;

        // Determine whether to write a frame.
        // In movie mode, write only every saveInterval timesteps.
        // In debug mode, write a frame on every timestep (overwriting the same file).
        bool doFrame = movieMode ? (t % saveInterval == 0) : true;
        if (doFrame)
        {
            std::ostringstream oss;
            if (movieMode)
            {
                oss << "fluidframe" << std::setw(5) << std::setfill('0') << t << ".ppm";
            }
            else
            {
                oss << "fluidframe.ppm";
            }
            std::string filename = oss.str();

            // Get pointers to simulation arrays.
            double* densityArr = getDensity(lbmData);
            bool* barrierArr   = getBarrier(lbmData);
            std::vector<unsigned char> imageBuffer(dimX * dimY * 3);

            auto convStart = std::chrono::high_resolution_clock::now();
            for (uint32_t j = 0; j < dimY; ++j)
            {
                for (uint32_t i = 0; i < dimX; ++i)
                {
                    uint32_t index = j * dimX + i;
                    double value   = densityArr[index];
                    bool isBar     = barrierArr[index];
                    uint8_t r, g, b;

                    mapDensityToColor(value, r, g, b, isBar, minValue, maxValue);
                    size_t pixelIndex = (j * dimX + i) * 3;
                    imageBuffer[pixelIndex    ] = r;
                    imageBuffer[pixelIndex + 1] = g;
                    imageBuffer[pixelIndex + 2] = b;
                }
            }
            auto convEnd = std::chrono::high_resolution_clock::now();
            conversionTime = std::chrono::duration<double>(convEnd - convStart).count();

            auto writeStart = std::chrono::high_resolution_clock::now();
            std::ofstream file(filename, std::ios::binary);
            if (file.is_open())
            {
                file << "P6\n" << dimX << " " << dimY << "\n255\n";
                file.write(reinterpret_cast<const char*>(imageBuffer.data()), imageBuffer.size());
                file.close();
                // Only print "Saved frame" message in movie mode.
                if (movieMode)
                    std::cout << "Saved frame to " << filename << "\n";
            }
            else
            {
                std::cerr << "Error: Could not open file " << filename << "\n";
            }
            auto writeEnd = std::chrono::high_resolution_clock::now();
            writeTime = std::chrono::duration<double>(writeEnd - writeStart).count();
        }

        // Print progress.
        if (static_cast<double>(t) * simulationDt >= outputTime)
        {
            if (!movieMode)
            {
                // Overwrite the same line in debug mode.
                std::cout << "\r" << std::fixed << std::setprecision(3)
                          << "LBM-CFD> time: " << static_cast<double>(t) * simulationDt
                          << " / " << physicalTime
                          << " , time step: " << t << " / " << timeSteps << std::flush;
            }
            else
            {
                std::cout << std::fixed << std::setprecision(3)
                          << "LBM-CFD> time: " << static_cast<double>(t) * simulationDt
                          << " / " << physicalTime
                          << " , time step: " << t << " / " << timeSteps << std::endl;
            }

            bool stable = checkStability(lbmData);
            if (!stable)
            {
                std::cerr << "\nLBM-CFD> Warning: simulation has become unstable (more time steps needed)\n";
            }

            switch (selectedFluidProperty)
            {
            case density:
                break;
            case speed:
                computeSpeed(lbmData);
                break;
            case vorticity:
                computeVorticity(lbmData);
                break;
            }
            outputCount++;
            outputTime = outputCount * physicalFreq;
        }

        auto simStart = std::chrono::high_resolution_clock::now();
        collide(lbmData, simulationViscosity);
        stream(lbmData);
        bounceBackStream(lbmData);
        auto simEnd = std::chrono::high_resolution_clock::now();
        double simStepTime = std::chrono::duration<double>(simEnd - simStart).count();

        csvFile << t << "," 
                << simStepTime << ","
                << conversionTime << ","
                << writeTime << "\n";
    }

    auto totalEnd = std::chrono::high_resolution_clock::now();
    double totalSimTime = std::chrono::duration<double>(totalEnd - totalStart).count();
    std::cout << "\nTotal simulation time: " << totalSimTime << " s\n";

    csvFile.close();

    destroyLBMData(lbmData);
    return 0;
}
