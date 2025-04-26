# John Ezra See
# P02 - Islands in the Stream on Multiple Nodes
# 04/20/2025
# I certify that this is my work and, where appropriate, an extension of the starter code provided for the assignment.

# Compiler
CXX = mpicxx
CXXFLAGS = -std=c++14 -Wall -Wextra -pedantic -Wno-used-parameter -fopenmp

# Find all .cc files and create a list of executables
SOURCES := $(wildcard *.cc)
EXECUTABLES := $(SOURCES:.cc=)

# Default target: build all executables
all: $(EXECUTABLES)

# Rule to compile each .cc file into an executable
%: %.cc
	$(CXX) $(CXXFLAGS) $< -o $@

# Clean rule to remove all generated files from execution
clean:
	rm -f $(EXECUTABLES) *.ppm *.csv lbm.err lbm.out lbmExperiment.txt
