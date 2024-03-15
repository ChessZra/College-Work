VALGRIND = valgrind --leak-check=full --track-origins=yes
CXXFLAGS = -O2 -Wall -I. -g -std=c++2a

UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)
	WARNING = echo '\033[0;31mValgrind is not supported on MacOS. Make sure to run your tests in zyBooks to check for memory safety and leaks. See the Project 3 guide for more info.\033[0m';
	VALGRIND =
	CXXFLAGS += -I/opt/homebrew/Cellar/googletest/1.14.0/include -L/opt/homebrew/Cellar/googletest/1.14.0/lib
endif

tests: prqueue_tests.cpp
	g++ $(CXXFLAGS) prqueue_tests.cpp -lgtest -lgtest_main -lpthread -o prqueue_tests

prqueue_main: prqueue_main.cpp
	g++ $(CXXFLAGS) prqueue_main.cpp -o prqueue_main

# This target's pretty cursed because the assignment is header-only.
# 1. Replace the student header with the stubbed solution header
# 2. Compile against the solution object file
# 3. _Regardless of the compilation result_, swap the headers back.
solution_tests: prqueue_solution.o prqueue_tests.cpp
	@mv prqueue.h prqueue_student.h && mv prqueue_solution_stub.h prqueue.h
	g++ $(CXXFLAGS) prqueue_solution.o prqueue_tests.cpp -lgtest -lgtest_main -lpthread -o solution_tests; \
		EXIT_CODE=$$?; \
		mv prqueue.h prqueue_solution_stub.h && mv prqueue_student.h prqueue.h; \
		exit $$EXIT_CODE

.PHONY: run run_tests run_solution_tests

run: prqueue_main
	@$(WARNING)
	$(VALGRIND) ./prqueue_main

run_tests: tests
	@$(WARNING)
	$(VALGRIND) ./prqueue_tests --gtest_color=yes

run_solution_tests: solution_tests
	@$(WARNING)
	$(VALGRIND) ./solution_tests --gtest_color=yes
