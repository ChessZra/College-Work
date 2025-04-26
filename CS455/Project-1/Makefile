# John Ezra See
# P01 - OpenMP
# 03/11/2025
# I certify that this is my work and, where appropriate, an extension of the starter code provided for the assignment.

# Compiler
CXX = g++
CXXFLAGS = -std=c++11 -Wall -Wextra -fopenmp

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
	rm -f $(EXECUTABLES) *.ppm
