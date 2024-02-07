# -O2: light optimization
# -Wall: all warnings
# -std=c++2a: standard version
# -g: include debug symbols
CXXFLAGS = -O2 -Wall -I. -g -std=c++2a

# If we're on MacOS, need to explicitly say where googletest is
# (While on Linux, it's in /usr/include and /usr/lib already)
UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)
	CXXFLAGS += -I/opt/homebrew/Cellar/googletest/1.14.0/include -L/opt/homebrew/Cellar/googletest/1.14.0/lib
endif

tests: search_tests.cpp search.h
	g++ $(CXXFLAGS) search_tests.cpp -lgtest -lgtest_main -lpthread -o search_tests

search: search_main.cpp search.h
	g++ $(CXXFLAGS) search_main.cpp -o search_main

clean:
	rm -rf search_tests search_main

# Individual test targets
test_all: tests
	./search_tests --gtest_color=yes

test_cleantoken: tests
	./search_tests --gtest_filter="CleanToken.*" --gtest_color=yes

test_gathertokens: tests
	./search_tests --gtest_filter="GatherTokens.*" --gtest_color=yes

test_findquerymatches: tests
	./search_tests --gtest_filter="FindQueryMatches.*" --gtest_color=yes

test_buildindex: tests
	./search_tests --gtest_filter="BuildIndex.*" --gtest_color=yes

search_main: search
	./search_main
