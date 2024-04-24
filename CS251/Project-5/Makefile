VALGRIND = valgrind --leak-check=full --track-origins=yes
CXXFLAGS = -O2 -Wall -I. -g -std=c++2a
WARNING = :

UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)
	WARNING = echo '\033[0;31mValgrind is not supported on MacOS. Make sure to run your tests in zyBooks to check for memory safety and leaks. See the Project 3 guide for more info.\033[0m';
	VALGRIND =
	CXXFLAGS += -I/opt/homebrew/Cellar/googletest/1.14.0/include -L/opt/homebrew/Cellar/googletest/1.14.0/lib
endif

osm_tests: application.cpp dist.cpp osm.cpp tinyxml2.cpp tests.cpp graph.h tests/graph_tests.h tests/buildgraph_tests.h tests/dijkstra_tests.h
	g++ $(CXXFLAGS) application.cpp dist.cpp osm.cpp tinyxml2.cpp tests.cpp -lgtest -lgtest_main -lpthread -o osm_tests

test_graph: osm_tests
	@$(WARNING)
	$(VALGRIND) ./osm_tests --gtest_filter="Graph.*" --gtest_color=yes

test_buildgraph: osm_tests
	@$(WARNING)
	$(VALGRIND) ./osm_tests --gtest_filter="BuildGraph.*" --gtest_color=yes

test_dijkstra: osm_tests
	@$(WARNING)
	$(VALGRIND) ./osm_tests --gtest_filter="Dijkstra.*" --gtest_color=yes

test_all: osm_tests
	@$(WARNING)
	$(VALGRIND) ./osm_tests --gtest_color=yes

osm_main: application.cpp dist.cpp osm.cpp tinyxml2.cpp main.cpp graph.h
	g++ $(CXXFLAGS) application.cpp dist.cpp osm.cpp tinyxml2.cpp main.cpp -o osm_main

run_osm_main: osm_main
	@$(WARNING)
	$(VALGRIND) ./osm_main

clean:
	rm -f osm_tests
	rm -f osm_main

.PHONY: clean
