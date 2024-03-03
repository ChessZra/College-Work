# This is cursed. Sue me.
# This Makefile and the one on zyBooks are not the same!

VALGRIND = valgrind
CXXFLAGS = -O2 -Wall -I. -g -std=c++2a
WARNING = :

UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)
	WARNING = echo '\033[0;31mValgrind is not supported on MacOS. Make sure to run your tests in zyBooks to check for memory safety and leaks. See the project guide for more info.\033[0m';
	VALGRIND =
	CXXFLAGS += -I/opt/homebrew/Cellar/googletest/1.14.0/include -L/opt/homebrew/Cellar/googletest/1.14.0/lib
endif

tests: canvaslist.cpp shape.cpp canvaslist_tests.cpp
	g++ $(CXXFLAGS) canvaslist.cpp shape.cpp canvaslist_tests.cpp -lgtest -lgtest_main -lpthread -o canvaslist_tests

main: canvaslist.cpp shape.cpp main.cpp
	g++ $(CXXFLAGS) canvaslist.cpp shape.cpp main.cpp -o canvaslist_main

run: main
	@$(WARNING)
	$(VALGRIND) ./canvaslist_main --gtest_color=yes

run_tests: tests
	@$(WARNING)
	$(VALGRIND) ./canvaslist_tests --gtest_color=yes
